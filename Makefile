VERSION := 0
PREFIX := /usr
BINDIR := $(PREFIX)/bin

all: bin/clear bin/false bin/pause bin/reset bin/true

clear bin/clear: clear.asm
	nasm -f bin clear.asm -o /dev/stdout | install -Dm755 /dev/stdin bin/clear

false bin/false: false.asm
	nasm -f bin false.asm -o /dev/stdout | install -Dm755 /dev/stdin bin/false

pause bin/pause: pause.asm
	nasm -f bin pause.asm -o /dev/stdout | install -Dm755 /dev/stdin bin/pause

reset bin/reset: reset.asm
	nasm -f bin reset.asm -o /dev/stdout | install -Dm755 /dev/stdin bin/reset

true bin/true: true.asm
	nasm -f bin true.asm -o /dev/stdout | install -Dm755 /dev/stdin bin/true

clean:
	rm -rf bin tinaries-*.tar*

install:
	install -vDm755 bin/* -t $(DESTDIR)$(BINDIR)/

release: .git
	git tag $(VERSION)
	git archive -o tinaries-$(VERSION).tar --prefix=tinaries-$(VERSION)/ $(VERSION)
	xz -fk9 tinaries-$(VERSION).tar
	gzip -fk9 tinaries-$(VERSION).tar
