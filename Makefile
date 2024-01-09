OBJECTS = loader.o kmain.o io.o screen.o
CC = gcc
CFLAGS = -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector \
		 -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c
LDFLAGS = -T link.ld -melf_i386
AS = nasm
ASFLAGS = -f elf

all: kernel.elf

kernel.elf: $(OBJECTS)
	ld $(LDFLAGS) $(OBJECTS) -o kernel.elf

OS_dev.iso: kernel.elf
	cp kernel.elf iso/boot/kernel.elf
	genisoimage -R								\
				-b boot/grub/stage2_eltorito	\
				-no-emul-boot					\
				-boot-load-size 4				\
				-A OS_dev						\
				-input-charset utf8				\
				-quiet							\
				-boot-info-table				\
				-o OS_dev.iso					\
				iso

runb: OS_dev.iso
	bochs -f bochsrc.txt -q

runq: OS_dev.iso
	qemu-system-x86_64 -cdrom OS_dev.iso

%.o: %.c
	$(CC) $(CFLAGS) $< -O $@

%.o: %.asm
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -rf *.o kernel.elf OS_dev.iso
