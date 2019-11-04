// Example of nested structures.

#include <stdint.h>
#include <stdio.h>

#define DEFAULT_R 0
#define DEFAULT_G 0
#define DEFAULT_B 0
#define DEFAULT_A 255

struct point2d {
  uint32_t x, y;
};

struct size2d {
  uint32_t w, h;
};

struct color4d {
  uint8_t r, g, b, a;
};

struct rect {
  struct point2d point;
  struct size2d  size;
  struct color4d color;
};



struct rect new_rect(int x, int y, int w, int h);
void print_rect_color(struct rect * r);



int main(int argc, char * argv[])
{
  struct rect r;

  r = new_rect(1, 2, 3, 4);
  print_rect_color(&r);

  return 0;
}



struct rect new_rect(int x, int y, int w, int h)
{
  struct rect r;

  r.point.x = x;
  r.point.y = y;
  r.size.w = w;
  r.size.h = h;
  r.color.r = DEFAULT_R;
  r.color.g = DEFAULT_G;
  r.color.b = DEFAULT_B;
  r.color.a = DEFAULT_A;

  return r;
}



void print_rect_color(struct rect * r)
{
  printf("#%02hhx%02hhx%02hhx%02hhx\n", r->color.r, r->color.g, r->color.b, r->color.a);
}

