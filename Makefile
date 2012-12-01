.PHONY: recompile test test-dev clean

PATH += :./node_modules/mocha/bin

recompile:
	six -co lib src
	six -co test/src test

test:
	mocha

# tag a test with the word dev to have this target run it
test-dev: recompile
	mocha -g dev

clean:
	rm -rf node_modules
