PERL=perl
CP=cp
.SUFFIXES: .txt .xml .xpl

TARGETS=viewport.txt for-each.txt identity.txt xslt.txt xinclude.txt choose.txt \
     input-doc.txt input-port.txt input-select.txt pipeline.txt \
     pipeline-library.txt group.txt trycatch.txt xslt-empty.txt \
     simple-default.txt simple-explicit.txt \
     xpathcontext.txt file.txt filebin.txt \
     value-available.txt exclude-pfx.txt

all: $(TARGETS)

.xml.txt:
	$(PERL) strip.pl < $< > $@

.xpl.txt:
	$(PERL) strip.pl < $< > $@

pipeline.txt: pipeline.xml
	cp $< $@

pipeline-library.txt: pipeline-library.xml
	cp $< $@

simple-default.txt: simple-default.xml
	cp $< $@

simple-explicit.txt: simple-explicit.xml
	cp $< $@

exclude-pfx.txt: exclude-pfx.xml
	cp $< $@

clean:
	rm -f $(TARGETS)
