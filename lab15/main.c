/* Example of nested structures.
 *
 * This file defines a structure 'rect' representing a rectangle, defined by a
 * point, some dimensions, and a color. The main function declares a rect,
 * assigns it some values, then prints out its color formatted as a hex code.
 */

#include <stdint.h> // Defines int32_t, uint32_t, uint8_t
#include <stdio.h>  // Defines printf

#define DEFAULT_R 1
#define DEFAULT_G 2
#define DEFAULT_B 3
#define DEFAULT_A 255

// Declare some structures
struct point2d {
  int32_t x, y;
};

struct size2d {
  uint32_t w, h;
};

struct color4d {
  uint8_t r, g, b, a;
};

// Declare a rectangle structure, made up of nested structures.
struct rect {
  struct point2d point;
  struct size2d  size;
  struct color4d color;
};



// Function prototypes. These functions are defined below.
struct rect new_rect(int32_t x, int32_t y, uint32_t w, uint32_t h);
void print_rect_color(struct rect * r);



int main(int argc, char * argv[])
{
  struct rect r;                // Declare a new rectangle

  r = new_rect(-1, 2, 3, 4);     // Assign some values to it
  print_rect_color(&r);         // Print out its color

  return 0;                     // Exit
}



struct rect new_rect(int32_t x, int32_t y, uint32_t w, uint32_t h)
{
  struct rect r;

  // Fill in its position and dimensions based on function arguments
  r.point.x = x;
  r.point.y = y;
  r.size.w = w;
  r.size.h = h;

  // Fill in its color based on program defaults
  r.color.r = DEFAULT_R;
  r.color.g = DEFAULT_G;
  r.color.b = DEFAULT_B;
  r.color.a = DEFAULT_A;

  return r;
}



void print_rect_color(struct rect * r)
{
  // Print out the rectangle's color in the format #aabbccdd, where, e.g.
  // aa is the rectangle's red value in hexadecimal.
  printf("#%02hhx%02hhx%02hhx%02hhx\n", r->color.r, r->color.g, r->color.b, r->color.a);
}

