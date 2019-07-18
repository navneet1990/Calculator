# Calculator
An iOS command line calculator

## Requirements

- Legal operators shall be *, /, +, - (multiply, divide, add, subtract)
- Operands and operators shall be separated by one or more spaces
- Mixed numbers will be represented by whole_numerator/denominator. e.g. "3_1/4"
- Improper fractions and whole numbers are also allowed as operands 


## Detailed instructions as stated in subject requirements:

You are to prepare a macOS command-line tool that will act as a simple calculator. The calculator will be run from the command line and will only work with integer numbers and the following arithmetic operators: `+` `-` `x` `/` `. 

For example, if the program is compiled to `Calculator`, the following demonstrates how it will work

>./Calculator 1/2 * 3_3/4
>1_7/8

In the command line, the arguments are a repeated sequence in the form

number operator

and ending in a

number

Hitting the enter key will cause the program to evaluate the arguments and print the result. In this case `1_7/8`.

The program must follow the usual rules of arithmetic which say:

1. The `x` and `/` operators must all be evaluated before the `+` and `–` operators.
2. Operators must be evaluated from left to right.

For example, using Rule 1

> 2_3/8 + 9/8

becomes

> 7/2

which results in

> 3_1/2

## Running from the Command Line

- 1) Navigate to the project folder `/.../Calculator/bin`   on the terminal
- 2)  Run the command  by typing in `./Calculator`
- 3) Make sure to build first on Xcode, every time any modification made in code

## Read default Arguments
- 1) In `main.swit` just change `isTesting` to `true`
- 2) Will active debug mode and read default arguments


For example,  On terminal
>./Calculator 3  + 5

become
> 8
