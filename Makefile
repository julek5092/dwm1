# dwm1 - dynamic window manager
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c dwm.c util.c
OBJ = ${SRC:.c=.o}

all: dwm1

.c.o:
	${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

config.h:
	cp config.def.h $@

dwm1: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	rm -f dwm1 ${OBJ} dwm1-${VERSION}.tar.gz

dist: clean
	mkdir -p dwm1-${VERSION}
	cp -R LICENSE Makefile README config.def.h config.mk\
		dwm.1 drw.h util.h ${SRC} dwm.png transient.c dwm1-${VERSION}
	tar -cf dwm1-${VERSION}.tar dwm1-${VERSION}
	gzip dwm1-${VERSION}.tar
	rm -rf dwm1-${VERSION}

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f dwm1 ${DESTDIR}${PREFIX}/bin/dwm1
	chmod 755 ${DESTDIR}${PREFIX}/bin/dwm1
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	sed "s/VERSION/${VERSION}/g" < dwm.1 > ${DESTDIR}${MANPREFIX}/man1/dwm1.1
	chmod 644 ${DESTDIR}${MANPREFIX}/man1/dwm1.1

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dwm1 \
		${DESTDIR}${MANPREFIX}/man1/dwm1.1

.PHONY: all clean dist install uninstall
