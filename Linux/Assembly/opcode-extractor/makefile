op: op.o
	ld -e start -o op op.o
op.o: op.asm
	nasm -f elf32 -o op.o op.asm
