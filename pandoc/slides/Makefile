SRC := md/
OUT := pdf/
INC := inc/
SLIDES := $(patsubst $(SRC)%.md,$(OUT)%.pdf,$(wildcard $(SRC)*.md))
HANDOUTS := $(patsubst $(SRC)%.md,$(OUT)%.md.handout.pdf,$(wildcard $(SRC)*.md))
DEPS=$(INC)lecture.beamer $(INC)lecture.yaml $(INC)columnfilter.py
PANFLGAS = $(INC)lecture.yaml -t beamer --filter $(INC)columnfilter.py --template=$(INC)lecture.beamer --slide-level=2 --latex-engine=xelatex

slides : $(SLIDES)

all : $(SLIDES) $(HANDOUTS)

$(OUT)%.pdf : $(SRC)%.md $(DEPS)
	TEXINPUTS=$(INC)/patex:${TEXINPUTS} pandoc $< $(PANFLGAS) -o $@ 

$(OUT)%.md.handout.pdf : $(SRC)%.md $(DEPS)
	TEXINPUTS=$(INC)/patex: pandoc  $< $(PANFLGAS) -V handout -o $@ 
	pdfnup $@ --nup 1x2 --no-landscape --keepinfo \
		--paper letterpaper --frame true --scale 0.9 \
		--suffix "nup"
	mv $*.md.handout-nup.pdf $@
		

clean : 
	rm -f $(SLIDES)
	rm -f $(HANDOUTS)
