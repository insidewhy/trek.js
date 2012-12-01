.PHONY: recompile test test-dev

PATH += :./node_modules/mocha/bin

recompile:
	@six -co lib src

test:
	@mocha

# tag a test with the word dev to have this target run it
test-dev: recompile
	@mocha -g dev
