all : main.asm
	m4 main.asm > main.s
	gcc -g -c main.s
	gcc -g main.o

clean : 
	rm main.o a.out main.s
