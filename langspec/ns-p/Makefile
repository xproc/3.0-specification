empty :=
space := $(empty) $(empty)

CLASSPATH=$(subst  $(space),:,$(wildcard ../../lib/*.jar)):../../lib
SAXON=java -cp $(CLASSPATH) -jar ../../lib/saxon9he.jar
CALABASH=java -cp $(CLASSPATH) com.xmlcalabash.drivers.Main -c ../../.calabash

TARGETS=Overview.html ns-xproc-p-incl-1.xml ns-xproc-p-incl-2.xml

all: $(TARGETS)

Overview.html: ,xproc.xml
	@echo Format spec: $@
	@$(SAXON) -s:$< -xsl:../../style/dbspec.xsl -o:$@

,xproc.xml: xproc.xml ns-xproc-p-incl-1.xml ns-xproc-p-incl-2.xml \
               ../../style/docbook.xsl ../../style/dbspec.xsl \
               ../../style/xprocns.xsl ../../style/rngsyntax.xsl
	@echo Validate spec: $<
	@$(CALABASH) -isource=$< -oresult=$@ \
                    ../../style/validate.xpl schema=../../schema/dbspec.rng

ns-xproc-p-incl-1.xml: ../xproc20/,xproc20.xml ../../style/ns-extract.xsl
	@echo Extract names from $<
	@$(SAXON) -s:$< -xsl:../../style/ns-extract.xsl -o:$@

ns-xproc-p-incl-2.xml: ../xproc20-steps/,steps.xml ../../style/ns-extract.xsl
	@echo Extract names from $<
	@$(SAXON) -s:$< -xsl:../../style/ns-extract.xsl -o:$@

clean:
	rm -f $(TARGETS) ,xproc.xml

