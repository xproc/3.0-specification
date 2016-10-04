all: legacy-hack-to-fix

legacy-hack-to-fix:
	$(MAKE) -C schema
	$(MAKE) -C langspec

clean:
	rm -rf build
	$(MAKE) -C schema clean
	$(MAKE) -C langspec clean
