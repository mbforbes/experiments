#include <stdio.h>
#include <stdint.h>

int main(int argc, char **argv) {
  uint64_t a = 1535345111111114444;
  int b = 17;
  int c = a % b;
  printf("c = %d\n", c);

  return 0;
}
