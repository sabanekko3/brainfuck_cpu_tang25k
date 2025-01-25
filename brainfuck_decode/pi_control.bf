reg map
0:NOP
1:TMR0_DIVR
2:TMR0L
3:TMR0H
4:PWM_DT
5:PWM_PERIOD
6:PWM1_DUTY
7:PWM2_DUTY
8:PWM3_DUTY
9:ENC_PRSC
A:ENC
B~:SOUT

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