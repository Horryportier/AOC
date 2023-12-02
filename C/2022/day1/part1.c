#include <stdio.h>
#include <stdlib.h>


void input_dat(char *path, char *buf) {
    FILE *in=fopen("day1/input.txt","r");
	char c;
	while((c=fgetc(in))!=EOF)
	fclose(in);
}


int main(int argc, char *argv[])
{
    
	return EXIT_SUCCESS;


}
