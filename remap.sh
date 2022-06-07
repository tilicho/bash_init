hidutil property --set '{"UserKeyMapping":[]}'


hidutil property --set '{"UserKeyMapping":[
	{"HIDKeyboardModifierMappingSrc":0x7000000E6,"HIDKeyboardModifierMappingDst":0x7000000E4},
	{"HIDKeyboardModifierMappingSrc":0x7000000E4,"HIDKeyboardModifierMappingDst":0x7000000E6},
	
	{"HIDKeyboardModifierMappingSrc":0x7000000E5,"HIDKeyboardModifierMappingDst":0x700000052},
	{"HIDKeyboardModifierMappingSrc":0x700000052,"HIDKeyboardModifierMappingDst":0x700000051},
	
	{"HIDKeyboardModifierMappingSrc":0x7000000E0,"HIDKeyboardModifierMappingDst":1095216660483},
	{"HIDKeyboardModifierMappingSrc":1095216660483,"HIDKeyboardModifierMappingDst":0x7000000E0},
	]}'


hidutil property --get "UserKeyMapping"
