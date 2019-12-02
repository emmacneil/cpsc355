#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

struct circle 
{
  double x, y, r;
};

const double PI = 3.141592653589793;

double area(struct circle * c)
{
  return c->r * c->r * PI;
}

void print_circle(struct circle * c)
{
  double a;

  a = area(c);
  printf("(x, y, r) = (%0.2lf, %0.2lf, %0.2lf)\n", c->x, c->y, c->r);
  printf("area = %0.4lf\n\n", a);
}

int main(int argc, char * argv[])
{
  char filename[] = "circles.bin";
  int fd, n_circles, i;
  // Open file

  fd = openat(-100, filename, 0, 0);
  if (fd < 0)
  {
    printf("Could not open file \"%s\".\n", filename);
    return 0;
  }

  read(fd, &n_circles, sizeof(int));
  for (int i = 0; i < n_circles; i++)
  {
    struct circle c;
    read(fd, &c, sizeof(struct circle));
    print_circle(&c);
  }
  close(fd);

  return 0;
}


