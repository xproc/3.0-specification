empty :=
space := $(empty) $(empty)

CLASSPATH=$(subst  $(space),:,$(wildcard ../../lib/*.jar)):../../lib
SAXON=java -cp $(CLASSPATH) -jar ../../lib/saxon9he.jar
CALABASH=java -cp $(CLASSPATH) com.xmlcalabash.drivers.Main -c ../../.calabash

TARGETS=Overview.html error-list-1.xml error-list-2.xml

all: $(TARGETS)

Overview.html: ,xproc-error.xml
	@echo Format spec: $@
	@$(SAXON) -s:$< -xsl:../../style/dbspec.xsl -o:$@

# Cannot validate schema=../../schema/dbspec.rng
# Fix it so that it validates!
,xproc-error.xml: xproc-error.xml error-list-1.xml error-list-2.xml \
               ../../style/docbook.xsl ../../style/dbspec.xsl \
               ../../style/xprocns.xsl ../../style/rngsyntax.xsl
	@echo Validate spec: $<
	@$(CALABASH) -isource=$< -oresult=$@ \
                    ../../style/validate.xpl schema=../../schema/dbspec.rng

error-list-1.xml: ../xproc20/,xproc20.xml ../../style/error-list.xsl
	@echo Extract names from $<
	@$(SAXON) -s:$< -xsl:../../style/error-list.xsl -o:$@

error-list-2.xml: ../xproc20-steps/,steps.xml ../../style/error-list.xsl
	@echo Extract names from $<
	@$(SAXON) -s:$< -xsl:../../style/error-list.xsl -o:$@

clean:
	rm -f $(TARGETS) ,xproc-error.xml
