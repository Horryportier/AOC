#include <stdio.h>
#include "aoc_utils.h"
void input_data(char * path, char * buf) { 
    FILE *fptr;
    fptr = fopen(path, "r");

    fgets(buf, MAX_FILE_SIZE, fptr);

    fclose(fptr);
}
