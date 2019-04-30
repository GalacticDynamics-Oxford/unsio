ifeq ($(origin CC),default)
CC = gcc
endif
ifeq ($(origin CXX),default)
CXX = g++
endif
SRCN = $(wildcard nemolight/*.c)
OBJN = $(patsubst nemolight/%.c,nemolight/obj/%.o,$(SRCN))
SRCU = $(wildcard unsio/*.cc)
OBJU = $(patsubst unsio/%.cc,unsio/obj/%.o,$(SRCU))
CFLAGS += -O2 -fPIC -Inemolight -Inemolight/inc

all: libnemo.a libunsio.a

nemolight/obj/%.o: nemolight/%.c
	@mkdir -p nemolight/obj
	$(CC) -c -o $@ $< $(CFLAGS)

unsio/obj/%.o: unsio/%.cc
	@mkdir -p unsio/obj
	$(CXX) -c -o $@ $< $(CFLAGS)

libnemo.a: $(OBJN)
	ar cr $@ $^

libunsio.a: $(OBJU)
	ar cr $@ $^

clean:
	rm -f nemolight/obj/*.o unsio/obj/*.o libnemo.a libunsio.a
