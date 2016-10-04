all:
	$(MAKE) -C examples

# ============================================================

error-list.xml:
	@echo FIXME: Build error-list.xml from the source
#	@echo Extract error list: $@
#	@$(SAXON) -s:$< -xsl:../../style/error-list.xsl -o:$@

pipeline-library.xml:
	@echo FIXME: Build pipeline-library.xml from the source
#	@echo Extract pipeline library: $@
#	@$(SAXON) -s:$< -xsl:../../style/pipeline-library.xsl -o:$@

typed-pipeline-library.xml:
	@echo FIXME: Build typed-pipeline-library.xml from the source
#	@echo Extract typed pipeline library: $@
#	@$(SAXON) -s:$< -xsl:../../style/typed-pipeline-library.xsl -o:$@

clean:
	rm -f $(TARGETS) ,steps.xml ,steps.xml
	rm -f pipeline-library.xml typed-pipeline-library.xml
	rm -f error-list.xml diff.html
	$(MAKE) -C examples clean
