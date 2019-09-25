#include <stdio.h>

int main()
{
  unsigned long N = 27L; // Initialize N
  printf("%lu\n", N);    // Print N
  while (N > 1L)
  {
    if ( (N & 1L) == 0 ) // If N is even
      N = N / 2L;        // Divide N by 2
    else                 // If N is odd
      N = 3L*N + 1L;     // Multiply N by 3 and add 1
    printf("%lu\n", N);  // Print N
  }
  return 0;
}
