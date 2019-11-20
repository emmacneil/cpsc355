#include <stdio.h>

char lfsr();

/*char lfsr()
{
  static unsigned short state = 1;
  short unsigned bit;

  bit = (state >> 15) ^ (state >> 13) ^ (state >> 12) ^ (state >> 10);
  bit = bit & 1u;
  state = (state << 1) ^ bit;
  return bit;
}*/

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
