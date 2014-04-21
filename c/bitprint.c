// MBF, Oct 27, 2011

#include <stdio.h>

/*

VA: 0x00700000
 L1 Index    L2 Index    PPO
 0000000001  1100000000  000000000000
  0   0   1   3   0   0     0   0   0

*/

// int li = length of bits to print
// void *data = the 32 bits of data
void print_bits(int l1, int l2, int l3, void *data) {
  // generate bit array
  unsigned int bits = *((int *) data);
  printf("%x\n", bits);

  
}

int main(int argc, char **argv) {
  int x = 0xdeadbeef;
  print_bits(10, 10, 12, (void *) &x);

  return 0;
}
