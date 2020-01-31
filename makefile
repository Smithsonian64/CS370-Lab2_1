# makefile for Lab2_1
# Michael Smith
# January 31 2020
# Creates the executable lab2_1 from lab2remove.l

all:	lab2_1 #executable

lab2_1:	lex.yy.c #c file from lex
	gcc -o lab2_1 lex.yy.c

lex.yy.c:	lab2remove.l #lex file
	lex lab2remove.l
