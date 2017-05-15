DESTDIR=/
name=tag

install:
	mkdir -p $(DESTDIR)usr/bin
	install -m 0755 $(name) $(DESTDIR)usr/bin
	
	mkdir -p $(DESTDIR)usr/share/$(name)/
	install -m 0644 tags/* $(DESTDIR)usr/share/$(name)/
	mkdir -p $(DESTDIR)usr/share/zsh/site-functions
	install -m 0644 _tag $(DESTDIR)usr/share/zsh/site-functions/

check:

.PHONY: install check
