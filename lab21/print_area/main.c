#include <stdio.h>
#include <math.h>

struct circle 
{
  double x, y, r;
};

const double PI = 3.141592653589793;

double area(struct circle * c)
{
  return c->r * c->r * PI;
}

int main(int argc, char * argv[])
{
  struct circle c;
  double a;

  c.x = 1.0;
  c.y = -1.0;
  c.r = sqrt(2.0);

  a = area(&c);

  printf("Volume = %lf\n", a);
  return 0;
}
