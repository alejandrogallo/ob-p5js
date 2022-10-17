PKG = ob-p5js.el

test: checkdoc
checkdoc:
	emacs \
	--batch \
	-Q \
	--load $(PKG) \
	$(PKG) \
	-f checkdoc

examples:
	make -C examples/p5js.org/ index.html
