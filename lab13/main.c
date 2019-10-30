/* This program demonstrates adding and multiplying Gaussian integers.
 * Gaussian integers are simply complex numbers whose real and imaginary parts
 * are integers. For example, (1 + i) is a Gaussian integer, but
 * (3.14 + 1.41i) is not.
 */

#include <stdint.h> // Defines int64_t
#include <stdio.h>  // Defines printf()

struct gaussian
{
  int64_t re;
  int64_t im;
};



// Function prototypes. Three functions are declared here and defined further down.
struct gaussian gaussian_add(struct gaussian * a, struct gaussian * b);
struct gaussian gaussian_mul(struct gaussian * a, struct gaussian * b);
void gaussian_print(struct gaussian * a);



int main(int argc, char * argv[])
{
  struct gaussian a, b, c;
  
  a.re = 5;
  a.im = 3;
  
  b.re = 1;
  b.im = 2;

  gaussian_print(&a);
  gaussian_print(&b);

  c = gaussian_add(&a, &b);
  gaussian_print(&c);

  c = gaussian_mul(&a, &b);
  gaussian_print(&c);

  return 0;
}



/* Adds two Gaussian integers, using the formula
 *     (a + bi) + (c + di) = (a + c) + (b + d)i
 * and returns the result.
 */
struct gaussian gaussian_add(struct gaussian * a, struct gaussian * b)
{
  struct gaussian c;
  c.re = a->re + b->re;
  c.im = a->im + b->im;
  return c;
}

void gaussian_add(struct gaussian * a, struct gaussian * b, struct gaussian * c)
{
  c->re = a->re + b->re;
  c->im = a->im + b->im;
}



/* Multiplies two Gaussian integers, using the formula
 *     (a + bi)(c + di) = (ac - bd) + (ad + bc)i
 * and returns the result.
 */
struct gaussian gaussian_mul(struct gaussian * a, struct gaussian * b)
{
  struct gaussian c;
  c.re = a->re * b->re - a->im * b->im;
  c.im = a->re * b->im + a->im * b->re;
  return c;
}



/* Prints a Gaussian integer to stdout (including a newline character). */
void gaussian_print(struct gaussian * a)
{
  printf("%ld + %ldi\n", a->re, a->im);
}
