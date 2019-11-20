#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int useless_function();

int main(int argc, char * argv[])
{
  int r;
  srand(time(NULL));

  r = rand() & 0xff;

  for (int i = 0; i < r; i++)
    useless_function();

  printf("%d\n", r);

  return 0;
}

/*
int useless_function()
{
  static int n;
  n = n + 1;
  return n;
}
*/
