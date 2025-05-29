from openai import OpenAI
import sys
import os
import httpx
import requests
from requests.packages.urllib3.exceptions import InsecureRequestWarning

requests.packages.urllib3.disable_warnings(InsecureRequestWarning)
http_client = httpx.Client(verify=False)

url = os.getenv('OPENAI_HOST', "https://server.local/llm/v1/")
system_prompt = os.getenv('OPENAI_SYSTEM_PROMPT', "")
verbose = len(os.getenv('OPENAI_VERBOSE', "")) > 0
api_key = os.getenv('OPENAI_API_KEY', "42")

prompt = sys.argv[1]
if prompt == "-t":
    prompt = sys.stdin.read()

def trim_suffix(s, suffix):
    if s.endswith(suffix):
        return s[:-len(suffix)]
    return s

def get_default_model(url, verbose=False):
    model = os.getenv('OPENAI_MODEL', "")
    if len(model):
        return model

    def fetch_json_from_url(url):
        try:
            url = trim_suffix(url, "/v1/") + "/running"

            # Send a GET request to the URL
            response = requests.get(url, verify=False)

            # Raise an exception if the request was unsuccessful
            response.raise_for_status()

            # Try to parse the response body as JSON
            try:
                json_data = response.json()
                return json_data
            except ValueError as json_error:
                # Print error information if the response body is not valid JSON
                if verbose:
                    print(f"Error parsing JSON: {json_error}")
                return ""
        except requests.exceptions.HTTPError as http_error:
            # Print error information if the HTTP request returned an unsuccessful status code
            if verbose:
                print(f"HTTP error occurred: {http_error}")
            return ""
        except requests.exceptions.ConnectionError as conn_error:
            # Print error information if there was a connection error
            if verbose:
                print(f"Connection error occurred: {conn_error}")
            return ""
        except requests.exceptions.Timeout as timeout_error:
            # Print error information if the request timed out
            if verbose:
                print(f"Timeout error occurred: {timeout_error}")
            return ""
        except requests.exceptions.RequestException as req_error:
            # Print error information for any other request-related errors
            if verbose:
                print(f"An error occurred: {req_error}")
            return ""


    jsonData= fetch_json_from_url(url)
    if verbose:
        print("JSONDATA:", str(jsonData))
    if "running" in jsonData:
        run = jsonData["running"]
        if len(run) > 0:
            model = run[0]["model"]

        if len(model):
            return model
        if verbose:
            print("failed to get running model", str(jsonData))

    model="gemma-3-27b-it-Q4_K_M"
    return model


model = get_default_model(url)

system_prompt = ("answer briefly" if (len(system_prompt) == 0) else system_prompt) if len(sys.argv) <= 2 else sys.argv[2]

if verbose:
    print ("using url ", url)
    print ("using model", model)
    print ("using system prompt", system_prompt)

client = OpenAI(
        base_url=url,
        api_key=api_key,
        http_client=http_client,
        )

completion = client.chat.completions.create(
    model=model,
    messages=[
        {
            "role": "system",
            "content": system_prompt,
        },
        {
            "role": "user",
            "content": "\"" + prompt + "\"",
        },
    ],
    seed = 42,
    #temperature = 2.0,
    stream=True
)


for event in completion:
    content = event.choices[0].delta.content
    if content:
        print(content, end="", flush=True)

#print(completion.choices[0].message.content)
