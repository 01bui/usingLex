%{
#include<stdio.h>
#include<string.h>
#include <stdlib.h>
FILE *ff,*fr;
char p[20],q[20],r[20],fname[20];

// function to replace substring
char * replace(
    char const * const original, 
    char const * const pattern, 
    char const * const replacement
) {
  size_t const replen = strlen(replacement);
  size_t const patlen = strlen(pattern);
  size_t const orilen = strlen(original);

  size_t patcnt = 0;
  const char * oriptr;
  const char * patloc;

  // find how many times the pattern occurs in the original string
  for (oriptr = original; patloc = strstr(oriptr, pattern); oriptr = patloc + patlen)
  {
    patcnt++;
  }

  {
    // allocate memory for the new string
    size_t const retlen = orilen + patcnt * (replen - patlen);
    char * const returned = (char *) malloc( sizeof(char) * (retlen + 1) );

    if (returned != NULL)
    {
      // copy the original string, 
      // replacing all the instances of the pattern
      char * retptr = returned;
      for (oriptr = original; patloc = strstr(oriptr, pattern); oriptr = patloc + patlen)
      {
        size_t const skplen = patloc - oriptr;
        // copy the section until the occurence of the pattern
        strncpy(retptr, oriptr, skplen);
        retptr += skplen;
        // copy the replacement 
        strncpy(retptr, replacement, replen);
        retptr += replen;
      }
      // copy the rest of the string.
      strcpy(retptr, oriptr);
    }
    return returned;
  }
}

%}

our [a-zA-Z][a-zA-Z]+our
re [a-zA-Z]+^[ueoai]re
ce [a-zA-Z]+ce
xion [a-zA-Z]+xion
ise [a-zA-Z]+ise[s|d]?
isation [a-zA-Z]+isation
yse [a-zA-Z]+yse[s|d]?
ogue [a-zA-Z]+ogue
ae [a-zA-Z]+ae[a-zA-Z]+
oe [a-zA-Z]+oe[a-zA-Z]+
eol \n

%%
{our} {     
	char * const newstr = replace(yytext, "our", "or");
    	if (newstr)
   	{
	  fprintf(fr,newstr);
      	  free(newstr);
    	}	
       

        }
{re} {
	printf(yytext);
	if ((strcmp("here",yytext)!=0)&(strcmp("there",yytext)!=0)&(strcmp("are",yytext)!=0))
	{	     
	char * const newstr = replace(yytext, "re", "er");
    	if (newstr)
   	{
	  fprintf(fr,newstr);
      	  free(newstr);
    	}	
       	}
	else fprintf(fr,yytext);

        }
	
{ce} {
	if ((strcmp("advice",yytext)==0)|(strcmp("pratice",yytext)==0)|(strcmp("device",yytext)==0)|(strcmp("licence",yytext)==0)|(strcmp("defence",yytext)==0))
	{	
	char * const newstr = replace(yytext, "ce", "se");
    	if (newstr)
   	{
	  fprintf(fr,newstr);
      	  free(newstr);
    	}	

	}
	else fprintf(fr,yytext);
     }
{xion} {     
	char * const newstr = replace(yytext, "xion", "ction");
    	if (newstr)
   	{
	  fprintf(fr,newstr);
      	  free(newstr);
    	}	

	}
{ise} {     
	char * const newstr = replace(yytext, "ise", "ize");
    	if (newstr)
   	{
	  fprintf(fr,newstr);
      	  free(newstr);
    	}	

	}
{yse} {     
	char * const newstr = replace(yytext, "yse", "yze");
    	if (newstr)
   	{
	  fprintf(fr,newstr);
      	  free(newstr);
    	}	

	}

{isation} {     
	char * const newstr = replace(yytext, "isation", "ization");
    	if (newstr)
   	{
	  fprintf(fr,newstr);
      	  free(newstr);
    	}	

	}
{ogue} {     
	char * const newstr = replace(yytext, "ogue", "og");
    	if (newstr)
   	{
	  fprintf(fr,newstr);
      	  free(newstr);
    	}	

	}
{ae} {     
	char * const newstr = replace(yytext, "ae", "e");
    	if (newstr)
   	{
	  fprintf(fr,newstr);
      	  free(newstr);
    	}	

	}
{oe} {     
	char * const newstr = replace(yytext, "oe", "e");
    	if (newstr)
   	{
	  fprintf(fr,newstr);
      	  free(newstr);
    	}	

	}
{eol} {fprintf(fr,yytext);}
. {fprintf(fr,yytext);}
%%


int main(int argc,char *argv[])
{
        strcpy(fname,argv[1]);
        ff=fopen(fname,"r+");
        fr=fopen("result.txt","w+");
        yyin=ff;
        yylex();
        return(0);
}


yywrap()
{
  return(1);
}

