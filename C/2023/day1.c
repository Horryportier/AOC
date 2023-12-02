#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(int argc, char *argv[]) {

  char* input = argv[1];

  FILE* file = fopen(input, "r");
  char* line[256];

  int num = 0;

  while (fgets(*line, sizeof(line), file)) {
    int left_most = -1;
    int right_most = -1;

    for (int i = 0; i < strlen(*line) - 1; i++) {
      if (left_most != -1) {
        break;
      }
      if (isdigit(line[i])) {
        left_most = atoi(line[i]);
      }
    }
    for (int i = strlen(*line) - 1; i == 0; i--) {
      if (right_most != -1) {
        break;
      }
      if (isdigit(line[i])) {
        right_most = atoi(line[i]);
      }
    }

    printf("%i, %i\n", left_most, right_most);
  }

  return EXIT_SUCCESS;
}
