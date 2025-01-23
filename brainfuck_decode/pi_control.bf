reg map
0:NOP
1:TMR0L
2:TMR0H
3:PWM_DT
4:PWM_PERIOD
5:PWM1_DUTY
6:PWM2_DUTY
7:PWM3_DUTY
8:ENC_PRSC
9:ENC
A~:SOUT

>>>+. dead time

>
-. //period:255

+

+++++ +++++
[
	>+++++ +++++ ++
	>+++++ +++++ ++
	<<-
]
>.>. //pwm1 2 duty = 128

>>+++++++. //enc prescaler:2
<<<


//control pwm2 duty
//pwm1 duty : const

[
	>>>>,
	[
		-
		<<<+
		>>> //move enc_val to pwm2 and pwm3
	]
	<<<.
	<
]