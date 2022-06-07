hidutil property --set '{"UserKeyMapping":[]}'


hidutil property --set '{"UserKeyMapping":[
	{"HIDKeyboardModifierMappingSrc":0x7000000E5,"HIDKeyboardModifierMappingDst":0x7000000E4},
	{"HIDKeyboardModifierMappingSrc":0x7000000E4,"HIDKeyboardModifierMappingDst":0x7000000E5},
	]}'


hidutil property --get "UserKeyMapping"
