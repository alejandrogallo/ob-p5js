all: index.html

website:
	git clone --depth=1 https://github.com/processing/p5.js-website $@

index.org: ./make-test-org website
	./make-test-org > $@

index.html: index.org
	emacs --batch -Q \
		--load \
		../../ob-p5js.el \
		--eval "(progn (require 'org) (setq org-confirm-babel-evaluate nil))" \
		$< \
		-f org-html-export-to-html
