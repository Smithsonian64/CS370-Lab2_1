%{
         /* simple lex program which removes comments from a source program
            The main key is that a variable "comment" is set when the start of a comment
            is seen and then unset when the ending set is seen.  It is possible to have
            two starts closed by one end.

            Modified by Michael Smith
            January 2020

Changes:
-Added catches for characters, numbers, symbols, tab and whitspaces and comment 
 characters "*/" and "/*" so the input file is printed with the error
 messages.
-Added linecount variable so that when each newline character is encountered
 the variable is incremented and the totale line count is printed.
-Added EOF catch to make the end of file obvious when printing.
-added return type and void parameter to main
 
         */
        int comment = 0;
        int debug=1;  /* prints out debug statements if desired */
	int lineCount = 1;
%}
%%
<<EOF>>	{
	printf("\r");
	printf("********EOF********\n");
	printf("line count: %d\n", lineCount - 1);
	return 1;
	}
[a-zA-Z]+	|
[0-1]+		|
[ \t]		|
[.=+\-]	{printf("%s", yytext);}

"/*"	{	
	printf("%s", yytext);

	if (comment && debug) fprintf(stderr, ">>>>>>>> line %d: Possible Nested comment <<<<<<<<<<\n", lineCount);

	comment = 1;
	}

"*/"	{ 
	printf("%s", yytext);

	if (!comment && debug) fprintf(stderr, ">>>>>>>> line %d: Possible comment end without start <<<<<<<<<<\n", lineCount);

	comment = 0;
	}

.       { if (!comment) printf("%s",yytext);}

"\n"	{
	lineCount++; 
	printf("\n%d: ", lineCount);
	}
%%

int yywrap(void)
{ return 1;
}

int main(void)
{
  printf("%d: ", lineCount);
  yylex();
  return 1;
}

