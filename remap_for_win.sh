#https://hidutil-generator.netlify.app 
hidutil property --set '{"UserKeyMapping":[]}'


# r option -> r ctrl
#"HIDKeyboardModifierMappingDst": 0x7000000E4,
#"HIDKeyboardModifierMappingSrc": 0x7000000E6

# r cmd -> r option
#"HIDKeyboardModifierMappingDst": 0x7000000E6,
#"HIDKeyboardModifierMappingSrc": 0x7000000E7

# r shift -> up
#"HIDKeyboardModifierMappingDst": 0x700000052,
#"HIDKeyboardModifierMappingSrc": 0x7000000E5

hidutil property --set '{"UserKeyMapping":[
{
    "HIDKeyboardModifierMappingDst": 0x7000000E4,
    "HIDKeyboardModifierMappingSrc": 0x7000000E6
},
{
    "HIDKeyboardModifierMappingDst": 0x7000000E6,
    "HIDKeyboardModifierMappingSrc": 0x7000000E7
},
]}'


hidutil property --get "UserKeyMapping"
