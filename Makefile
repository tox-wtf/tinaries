PREFIX=/usr
BINDIR=$(PREFIX)/bin

all: clear false pause reset true

clear: clear.asm
	nasm -f bin clear.asm -o /dev/stdout | install -Dm755 /dev/stdin bin/clear

false: false.asm
	nasm -f bin false.asm -o /dev/stdout | install -Dm755 /dev/stdin bin/false

pause: pause.asm
	nasm -f bin pause.asm -o /dev/stdout | install -Dm755 /dev/stdin bin/pause

reset: reset.asm
	nasm -f bin reset.asm -o /dev/stdout | install -Dm755 /dev/stdin bin/reset

true: true.asm
	nasm -f bin true.asm -o /dev/stdout | install -Dm755 /dev/stdin bin/true

clean:
	rm -rf bin

install:
	find bin -mindepth 1 -maxdepth 1 -type f -executable | xargs -I _ install -vDm755 _ -t $(DESTDIR)$(BINDIR)/
