// The Fibonacci numbers are the numbers
//
//    1, 1, 2, 3, 5, 8, 13, 21, ...
//
// Where each number is the sum of the two numbers before it.
// Compute the first 40 Fibonacci numbers and store them in an array.
// (The first 40 each fit in 32 bits.)

int main(int argc, char * argv[])
{
  unsigned int fib[40];
  int i;

  fib[0] = 1;
  fib[1] = 1;

  for (i = 2; i < 40; i++)
  {
    fib[i] = fib[i-1] + fib[i-2];
  }

  return 0;
}
