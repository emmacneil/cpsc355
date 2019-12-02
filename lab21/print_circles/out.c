#include <fcntl.h> // openat
#include <unistd.h> // write, close
#include <stdio.h>
#include <stdlib.h>

double drand()
{
  double a = rand() % 1001;
  return a/100.0;
}

int main()
{
  int fd = openat(-100, "circles.bin", 1, 0);
  int n = rand() % 10 + 1;
  write(fd, &n, sizeof(int));
  for (int i = 0; i < n; i++)
  {
    double x, y, r;
    x = drand();
    y = drand();
    r = drand();
    write(fd, &x, sizeof(double));
    write(fd, &y, sizeof(double));
    write(fd, &r, sizeof(double));
  }
  close(fd);
  return 0;
}
