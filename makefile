PKGDIR := package/
FILEDIR := files/
PKGBUILD := $(PKGDIR)PKGBUILD

ARCH := x86_64

PKGNAME := $(shell sed -n 's/^pkgname=\(.*\)/\1/p' < $(PKGBUILD))
PKGVER := $(shell sed -n 's/^pkgver=\(.*\)/\1/p' < $(PKGBUILD))

PKGFILE := $(PKGDIR)$(PKGNAME)-$(PKGVER)-1-$(ARCH).pkg.tar.xz
TARFILE := $(PKGDIR)$(PKGNAME)-$(PKGVER).tar.gz

SUDO := su -c
PACMAN := pacman
PACMAN-INSTALL := $(PACMAN) -U

$(PKGNAME): $(PKGFILE)
tar: $(TARFILE)

$(PKGFILE): $(PKGBUILD) $(TARFILE)
	cd $(PKGDIR); \
		makepkg --skipinteg -f

$(TARFILE): $(FILEDIR)*
	tar -czf "$(TARFILE)" "$(FILEDIR)"

install: $(PKGFILE)
	$(SUDO) "$(PACMAN-INSTALL) $(PKGFILE)"

clean:
	@TMPFILE=$(shell mktemp); \
		mv $(PKGBUILD) $${TMPFILE}; \
		rm -r $(PKGDIR); \
		mkdir $(PKGDIR); \
		mv $${TMPFILE} $(PKGBUILD)

.PHONY: $(PKGNAME) clean tar install
