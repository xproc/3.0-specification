PERL=perl
CP=cp
.SUFFIXES: .txt .xml .xpl

TARGETS=exec-as1.txt exec-as2.txt xquery.txt

all: $(TARGETS)

.xml.txt:
	$(PERL) strip.pl < $< > $@

.xpl.txt:
	$(PERL) strip.pl < $< > $@

xquery.txt: xquery.xml
	cp $< $@

clean:
	rm -f $(TARGETS)
