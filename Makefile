CC = xenon-gcc
OBJCOPY = xenon-objcopy
STRIP = xenon-strip
TARGET = jogo
DEVKITXENON ?= /usr/local/xenon

CFLAGS = -m32 -mpowerpc64 -mhard-float -maltivec -mcpu=cell -mtune=cell -fno-pic -Wall -DXENON -I$(DEVKITXENON)/usr/include
LDFLAGS = -m32 -n -T $(DEVKITXENON)/app.lds -u read -u _start -u exc_base
LDDIRS = -L$(DEVKITXENON)/usr/lib -L$(DEVKITXENON)/xenon/lib/32
LIBS = -lxenon -lm -lc

.RECIPEPREFIX = >

all: $(TARGET).elf32

$(TARGET).elf: main.o
> $(CC) -o $@ main.o $(LDFLAGS) $(LDDIRS) $(LIBS)

$(TARGET).elf32: $(TARGET).elf
> $(OBJCOPY) -O elf32-powerpc --adjust-vma 0x80000000 $< $@
> $(STRIP) $@

%.o: %.c
> $(CC) $(CFLAGS) -c -o $@ $<

clean:
> rm -f *.o *.elf *.elf32
