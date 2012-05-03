
all : paper.pdf

paper.pdf : paper.md dcj.pandoc.tex cmbrightmath.sty dcj.sty
	pandoc \
		--latex-engine=xelatex \
		--template=dcj.pandoc.tex \
		-o $@ $<

clean :
	rm -f paper.pdf
	