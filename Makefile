CC = xenon-gcc
OBJCOPY = xenon-objcopy
STRIP = xenon-strip
TARGET = jogo
CFLAGS = -m32 -mpowerpc64 -mhard-float -maltivec -mcpu=cell -mtune=cell -fno-pic -Wall -DXENON -I$(DEVKITXENON)/usr/include
LDFLAGS = -L$(DEVKITXENON)/usr/lib -L$(DEVKITXENON)/xenon/lib/32
LIBS = -lxenon -lm -lc

.RECIPEPREFIX = >

all: $(TARGET).elf32

$(TARGET).elf: main.o
> $(CC) -o $@ main.o $(LDFLAGS) $(LIBS)

$(TARGET).elf32: $(TARGET).elf
> $(OBJCOPY) -O elf32-powerpc --adjust-vma 0x80000000 $< $@
> $(STRIP) $@

%.o: %.c
> $(CC) $(CFLAGS) -c -o $@ $<

clean:
> rm -f *.o *.elf *.elf32
