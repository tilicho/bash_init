hidutil property --set '{"UserKeyMapping":[]}'


hidutil property --set '{"UserKeyMapping":[
			{
              "HIDKeyboardModifierMappingDst": 0x7000000E2,
              "HIDKeyboardModifierMappingSrc": 0x7000000E3
            },
            {
              "HIDKeyboardModifierMappingDst": 0x7000000E3,
              "HIDKeyboardModifierMappingSrc": 0x7000000E0
            },
            {
              "HIDKeyboardModifierMappingDst": 0x7000000E0,
              "HIDKeyboardModifierMappingSrc": 0xFF00000003
            },
            {
              "HIDKeyboardModifierMappingDst": 0xFF00000003,
              "HIDKeyboardModifierMappingSrc": 0x7000000E2
            },
            {
              "HIDKeyboardModifierMappingDst": 0x700000052,
              "HIDKeyboardModifierMappingSrc": 0x7000000E5
            },
			{
              "HIDKeyboardModifierMappingDst": 0x7000000E4,
              "HIDKeyboardModifierMappingSrc": 0x7000000E6
            },
			{
              "HIDKeyboardModifierMappingDst": 0x700000049,
              "HIDKeyboardModifierMappingSrc": 0x7000000E7
            },

	
	]}'


hidutil property --get "UserKeyMapping"
