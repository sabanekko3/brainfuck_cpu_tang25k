{0:nop} 
{1:period} 
{2:duty1} 
{3:duty2} 
{4:duty3} 
{5:inc1} 
{6:(if state)} 
{7:0} 
{8:inc2} 
{(9:if state)} 
{10:0} 
{11:inc3} 
{12:(if state)} 
{13:0} {0} {0} {0} {0}

>>>
+.
>+++++ +++++ ++.//set period
>          //pwm1=0
>+++++ +++ //pwm2=8
>+++++ +++ //pwm3=8
>+ //pwm1 inc mode
>>>+  //pwm2 inc mode
>>>  //pwm3 dec mode

<<<<< <<<<< <

[
	//////////////////////////////
	//pwm1
	//////////////////////////////

	>>>>> >+
	<
	//inc or dec
	[
		<<< +.
		>>>> -
	]>
	[
		-
		<<<<-.>>>>>
	]
	
	<+ //set if state
	<<<<
	[>>>>-]>>>>
	[-
		<+>>>>>	
	]
	<<<<+ //set if state

	//20:dec
	<<<< 
	----- ----- --
	[>>>>-]>>>>
	[-
		<->>>>>	
	]
	<<<<< <<<
	+++++ +++++ ++
	<<


	//////////////////////////////
	//pwm2
	//////////////////////////////

	>>>>> >>>>+
	<
	//inc or dec
	[
		<<<<< +.
		>>>>> > -
	]>
	[
		-
		<<<<< <-. >>>>> >>
	]
	
	//if duty = 0
	<<<<+ //set if state
	<<<
	[>>>-]>>>
	[-
		>>+>	
	]
	
	if duty = 12
	//20:dec
	<<<+ //set if state
	<<<
	----- ----- --
	[>>>-]>>>
	[-
		>>->	
	]
	<<<<< <
	+++++ +++++ ++
	<<<


	//////////////////////////////
	//pwm3
	//////////////////////////////

	>>>>> >>>>> >>+
	<
	//inc or dec
	[
		<<<<< << +.
		>>>>> >>> -
	]>
	[
		-
		<<<<< <<<-. >>>>> >>>>
	]

	//current ptr = if_state3 and 1
	
	//if duty = 0
	<<<< + //set if state2
	<<<<<
	[>>>>>-]>>>>>
	[-
		>>+>>>	
	]
	
	if duty = 12
	//20:dec
	<<<<<+ //set if state
	<<<<<
	----- ----- --
	[>>>>>-]>>>>>
	[-
		>>->>>	
	]
	<<<<< <<<<<
	+++++ +++++ ++
	<<<<
]