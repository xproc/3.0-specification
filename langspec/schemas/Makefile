empty :=
space := $(empty) $(empty)

CLASSPATH=$(subst  $(space),:,$(wildcard ../../lib/*.jar))
SAXON=java -cp $(CLASSPATH) -jar ../../lib/saxon9he.jar
CALABASH=java -cp $(CLASSPATH) com.xmlcalabash.drivers.Main
TRANG=java -cp $(CLASSPATH) com.thaiopensource.relaxng.translate.Driver

XSV=wxsv
XMLPARSE=rxp -VNxsz -D p:$$de ../schemas/xproc.dtd

DTD_PARTS=xproc_dtd_1.ent xproc_dtd_2.ent xproc_dtd_3.ent xproc_dtd_4.ent
XSD_PARTS=xproc_xsd_1.frag xproc_xsd_2.frag xproc_xsd_3.frag

all: steps.rnc xproc.rng xproc.dtd xproc.xsd

steps.rnc: ../xproc20-steps/typed-pipeline-library.xml ../../style/library-to-rnc.xsl
	@echo Build steps.rnc...
	@$(SAXON) -s:../xproc20-steps/typed-pipeline-library.xml -xsl:../../style/library-to-rnc.xsl -o:$@

xproc.rng: xproc.rnc steps.rnc
	@echo Convert RNC to RNG
	@$(TRANG) $< $@

xproc.dtd: $(DTD_PARTS)
	cat $^ > $@

xproc_dtd_2.ent xproc_dtd_4.ent: ../xproc20-steps/typed-pipeline-library.xml ../../style/library-to-dtd.xsl
	@echo Construct DTD entities
	@$(SAXON) -s:../xproc20-steps/typed-pipeline-library.xml -xsl:../../style/library-to-dtd.xsl step-cm=xproc_dtd_2.ent step-decls=xproc_dtd_4.ent

xproc.xsd: $(XSD_PARTS)
	cat $^ > $@

xproc_xsd_2.frag: ../xproc20-steps/typed-pipeline-library.xml ../../style/library-to-xsd.xsl
	@echo Construct XSD fragment
	@$(SAXON) -s:../xproc20-steps/typed-pipeline-library.xml -xsl:../../style/library-to-xsd.xsl | sed '1d;/xmlns:/d;/<.wrapper/d' > $@

clean:
	rm -f xproc.rng xproc.dtd xproc.xsd
	rm -f xproc_dtd_2.ent xproc_dtd_4.ent xproc_xsd_2.frag
	rm -f steps.rnc steps.rng errs_dtd.tmp errs_xsd.tmp

testDTD: xproc.dtd
	for f in ../xproc20/examples/*.{xml,xpl} ;\
	 do de=`lxprintf -e '/*' '%s\n' 'local-name(.)' $$f` ;\
	 case $$de in \
	  pipeline|declare-step|library) \
	    $(XMLPARSE) $$f ;;\
	  esac ;\
	 done 2> errs_dtd.tmp || :
	diff -bw errs_dtd.txt errs_dtd.tmp

testXSD: xproc.xsd
	for f in ../xproc20/examples/*.{xml,xpl} ;\
	 do de=`lxprintf -e '/*' '%s\n' 'local-name(.)' $$f` ;\
	 case $$de in \
	  pipeline|declare-step|library) \
	    $(XSV) $$f xproc.xsd ;;\
	  esac ; echo -n . ;\
	 done 2> errs_xsd.tmp || :
	echo
	diff -bwi errs_xsd.txt errs_xsd.tmp
