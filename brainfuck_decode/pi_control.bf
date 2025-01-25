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


+++++
[
	>+++++ +++++ ++
	<-
]
>.  //timer0 prescale 61


>>>+. dead time

>
-.+ //period:255

+++++ +++++
[
	> +++++ +++++ ++
	> +++++ +++++ ++
	>>+++++
	<<<<-
]
>.
>.   //pwm1 2 duty = 120
>>.  //enc_prescaler = 30

<<<


//control pwm2 duty
//pwm1 duty : const
//loop origin:PWM1_DUTY

[
	<<<<,[,] //wait until TMR0L == 0
	>>>>
	
	>>>>,
	[
		-
		<<+<+++++ +  +  //Pgain:6  Igain:1
		>>> //move enc_val to pwm2 and pwm3
	]
	<<<.
	>
	[-<----- ->] //reset pwm2
	<<
]