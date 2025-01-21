reg map
0:NOP
1:TMR0L
2:TMR0H
3:PWM_DT
4:PWM_PERIOD
5:PWM1_DUTY
6:PWM2_DUTY
7:PWM3_DUTY
8:ENC
9~:SOUT

>>>+. dead time
>
+++++ +++++
+++++ +++++
+++++ +++++
+++++ +++++
+++++ +++++
+++++ +++++. period 60

>
+++++ +++++
+++++ +++++
+++++ +++++

>
+++++ +++++
+++++ +++++
+++++ +++++

.<.

//control pwm2 duty
//pwm1 duty : const

[
	>>>,
	[
		<+<+
		>>-
	]
	<<.
	>
	[-<->] //reset
	<<
]