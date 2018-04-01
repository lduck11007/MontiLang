/# Monti Reference sheet #/
/#
/#
Comments are multiline
Nested comments are not supported 
#/
/# Whitespace is all arbitrary, indentation is optional #/
/# All programming in Monti is done by manipulating the parameter stack 
arithmetic and stack operations in MontiLang are similar to FORTH
https://en.wikipedia.org/wiki/Forth_(programming_language)
#/

/# in Monti, everything is either a string or a number. Operations treat all numbers
similarly to floats, but anything without a remainder is treated as type int #/

/# numbers and strings are added to the stack from left to right #/

/# Arithmetic works by manipulating data on the stack #/

5 3 + PRINT . /# 8 #/

/#  5 and 3 are pushed onto the stack
    '+' replaces top 2 items on stack with sum of top 2 items
    'PRINT' prints out the top item on the stack
    '.' pops the top item from the stack. 
    #/

6 7 * PRINT . /# 42 #/
1360 23 - PRINT . /# 1337 #/
12 12 / PRINT . /# 1 #/
13 2 % PRINT . /# 1 #/

37 NEG PRINT . /# -37 #/
-12 ABS PRINT . /# 12 #/
52 23 MAX PRINT . /# 52 #/
52 23 MIN PRINT . /# 23 #/

/# 'PSTACK' command prints the entire stack, 'CLEAR' clears the entire stack #/

3 6 8 PSTACK CLEAR /# [3, 6, 8] #/

/# Monti comes with some tools for stack manipulation #/

2 DUP PSTACK CLEAR /# [2, 2] - Duplicate the top item on the stack#/
2 6 SWAP PSTACK CLEAR /# [6, 2] - Swap top 2 items on stack #/
1 2 3 ROT PSTACK CLEAR /# [2, 3, 1] - Rotate top 3 items on stack #/
2 3 NIP PSTACK CLEAR /# [3] - delete second item from the top of the stack #/

/# variables are assigned with the syntax 'VAR [name]'#/
/# When assigned, the variable will take the value of the top item of the stack #/

6 VAR six . /# assigns var 'six' to be equal to 6 #/
3 6 + VAR a . /# assigns var 'a' to be equal to 9 #/

/# strings are defined with | | #/

|Hello World!| VAR world . /# sets variable 'world' equal to string 'Hello world! #/ 

/# variables can be called by typing its name. when called, the value of the variable is pushed
to the top of the stack #/
world PRINT .

/# with the OUT statement, the top item on the stack can be printed without a newline #/

|world!| |Hello, | OUT SWAP PRINT CLEAR

/# User input is taken with INPUT and pushed to the stack. If the top item of the stack is a string, 
the string is used as an input prompt #/

|What is your name? | INPUT NIP 
|Hello, | OUT SWAP PRINT CLEAR


/# FOR loops have the syntax 'FOR [condition] [commands] ENDFOR' At the moment, [condition] can
only have the value of an integer. Either by using an integer, or a variable call to an integer.
[commands] will be interpereted the amount of time specified in [condition] #/
/# E.G: this prints out 1 to 10 #/

1 VAR a .
FOR 10
    a PRINT 1 + VAR a
ENDFOR

/# the syntax for while loops are similar. A number is evaluated as true if it is larger than
0. a string is true if its length > 0. Infinite loops can be used by using literals.
#/
10 var loop .
WHILE loop
    loop print 
    1 - var loop
ENDWHILE
/#
this loop would count down from 10.

IF statements are pretty much the same, but only are executed once.
#/
IF loop
 loop PRINT .
ENDIF

/# This would only print 'loop' if it is larger than 0 #/

/# If you would want to use the top item on the stack as loop parameters, this can be done with the ':' character #/

/# eg, if you wanted to print 'hello' 7 times, instead of using #/

FOR 7
    |hello| PRINT .
ENDFOR

/# this could be used #/
7
FOR : .
    |hello| PRINT .
ENDFOR

/# Equality and inequality statements use the top 2 items on the stack as parameters, and replace the top two items with the output #/
/# If it is true, the top 2 items are replaced with '1'. If false, with '0'. #/

7 3 > PRINT . /# 1 #/
2 10 > PRINT . /# 0 #/
5 9 <= PRINT . /# 1 #/
5 5 == PRINT . /# 1 #/
5 7 == PRINT . /# 0 #/
3 8 != PRINT . /# 1 #/

/# User defined commands have the syntax of 'DEF [name] [commands] ENDDEF'. #/
/# eg, if you wanted to define a function with the name of 'printseven' to print '7' 10 times, this could be used #/

DEF printseven
    FOR 10
       7 PRINT .
    ENDFOR
ENDDEF

/# to run the defined statement, simply type it and it will be run by the interpereter #/

printseven

/# Montilang supports AND, OR and NOT statements #/

1 0 AND PRINT . /# 0 #/
1 1 AND PRINT . /# 1 #/
1 0 OR PRINT . /# 1 #/
0 0 OR PRINT . /# 0 #/
1 NOT PRINT . /# 0 #/
0 NOT PRINT . /# 1 #/

/# Preprocessor statements are made inbetween '&' characters #/
/# currently, preprocessor statements can be used to make c++-style constants #/

&DEFINE LOOP 20&
/# must have & on either side with no spaces, 'DEFINE' is case sensative. #/
/# All statements are scanned and replaced before the program is run, regardless of where the statements are placed #/

FOR LOOP 7 PRINT . ENDFOR /# Prints '7' 20 times. At run, 'LOOP' in source code is replaced with '20' #/ 