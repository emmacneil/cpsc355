// The Fibonacci numbers are the numbers
//
//    1, 1, 2, 3, 5, 8, 13, 21, ...
//
// Where each number is the sum of the two numbers before it.
// Compute the first 20 Fibonacci numbers and store them in an array.
// (The first 20 are each less than 65,536)

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
