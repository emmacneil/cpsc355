#include <stdio.h>

/*char lfsr()
{
  static unsigned short state = 1;
  short unsigned bit, tmp;

  tmp = state ^ 0xb400;
  tmp = tmp >> 10;
  bit = tmp & 1;
  tmp = tmp >> 2;
  bit = bit ^ (tmp & 1);
  tmp = tmp >> 1;
  bit = bit ^ (tmp & 1);
  tmp = tmp >> 2;
  bit = bit ^ (tmp & 1);
  state = (state << 1) ^ bit;
  // XOR bits 15, 13, 12, and 10 of state
  // state XOR 1011 0100 0000 0000 = 0xb400
  // Store result in tmp register
  // LSH state
  // Append bit

  return (char)bit;
}*/

char lfsr()
{
  static unsigned short state = 1;
  short unsigned bit;

  bit = (state >> 15) ^ (state >> 13) ^ (state >> 12) ^ (state >> 10);
  bit = bit & 1u;
  state = (state << 1) ^ bit;
  return bit;
}

int main(int argc, char * argv[])
{
  const int N_BITS = 1024;
  int i;

  for (i = 0; i < N_BITS; i++)
  {
    char b;

    b = lfsr();

    printf("%hhd", b);
  }
  printf("\n");

  return 0;
}
