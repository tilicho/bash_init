from openai import OpenAI
import sys
import os
import httpx

http_client = httpx.Client(verify=False)

url = os.getenv('OPENAI_HOST', "https://server.local/llm/v1/")
model = os.getenv('OPENAI_MODEL', "gemma-3-27b-it-Q4_K_M")
system_prompt = os.getenv('OPENAI_SYSTEM_PROMPT', "")
verbose = os.getenv('OPENAI_VERBOSE', "")
api_key = os.getenv('OPENAI_API_KEY', "42")

prompt = sys.argv[1]

system_prompt = ("answer briefly" if (len(system_prompt) == 0) else system_prompt) if len(sys.argv) <= 2 else sys.argv[2]

if (len(verbose)):
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
