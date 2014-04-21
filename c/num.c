#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  char foo[11];
  snprintf(foo, 11, "file-%05d", 127);
  printf("%s", foo);
  printf("\n");
  return 0;
}
