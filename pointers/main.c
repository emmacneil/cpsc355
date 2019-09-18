// Some examples involving pointers
// Recommended reading : http://www.cplusplus.com/doc/tutorial/pointers/

#include <stdio.h>

void do_not_change_a(int a)
{
	a = a + 1; // Increment a
}

void change_a(int * ptr)
{
	(*ptr) = (*ptr) + 1; // Increment the value stored at the memory address stored in ptr
}

int main()
{
	// Declare some variables to play with
	int a;
	int * ptr_a;
	int ** ptr_ptr_a;

	// a is a signed integer.
	a = -3;
	printf("a = %d\n", a);

        // & is the address-of operator	
	// &a gives the memory address at which a is stored
	printf("&a = %p\n", &a);

	// ptr_a is a pointer to a signed integers
	// pointers store memory addresses
	ptr_a = &a; // Store the address of a in ptr_a
	printf("ptr_a = %p\n", ptr_a);

	// * is the dereference operator
	// *ptr_a gives the value stored at the address stored in ptr_a
	printf("*ptr_a = %d\n", *ptr_a);
	
	// &ptr_a gives the memory address at which ptr_a is stored
	printf("&ptr_a = %p\n", &ptr_a);

	// It is also possible to have pointers to pointers to signed integers.
	ptr_ptr_a = &ptr_a; // Store the address of ptr_a in ptr_ptr_a
	printf("ptr_ptr_a = %p\n", ptr_ptr_a);

	// When calling a function, we make a *copy* of the arguments.
	// This function gets a *copy* of a, so it cannot change a.
	do_not_change_a(a);
	printf("a = %d\n", a);
	
	// This function gets a *copy* of the *address* of a.
	// By knowing the address, it can change a!
	change_a(&a);
	printf("a = %d\n", a);

	// In C, strings are arrays of characters, and must end in the null character '\0'
	// There are a few ways to declare a string
	char * str1 = "hello";                          // '\0' is added for us
	char str2[6] = {'h', 'e', 'l', 'l', 'o', '\0'}; // We add '\0' ourselves
	char str3[] = "hello";                          // The compiler turns this into str3[6] = {'h', ..., '\0'}
	printf("str1 = %s\n", str1);
	printf("str2 = %s\n", str2);
	printf("str3 = %s\n", str3);

	// Strange things might happen if we overwrite the null character
	str2[5] = 'X'; // Replace '\0' with 'X'
	printf("str2 = %s\n", str2);

	// Arrays and pointers are very similar
	// Some ways in which they are the same:
	// Pointers can be accessed like arrays. 
	printf("str1[0] = %c\n", str1[0]); // str1[0] is the same as *str1
	printf("str1[2] = %c\n", str1[2]); // str1[2] is the same as *(str1 + 2)
	// Arrays can be dereferenced like pointers
	printf("*str2 = %c\n", *str2); // *str2 is the same as str2[0]
	printf("*(str2+2) = %c\n", *(str2+2)); // *(str2 + 2) is the same as str2[2]
	
	// One difference between the pointer version of a string, char * str
	// and the array version of a string, char str[]
	// is that pointers are variables and arrays are not.
	// We can change str1 because it is a variable ...
	str1 = "hey!";
	printf("str1 = %s\n", str1);

	// ... but we cannot change str2 and str3
	// Uncommenting the next line causes a compile error
	// str3 = "hey!";
	
	// str3 cannot be changed, but str[0], str[1], etc. can.
	str3[2] = 'y'; str3[3] = '!'; str3[4] = '\0';
	printf("str3 = %s\n", str3);

	return 0;
}
