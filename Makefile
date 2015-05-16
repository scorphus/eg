# install development dependencies (don't forget to create a virtualenv first)
setup:
	@pip install -U -e .\[tests\]

# run tests
unit:
	@coverage run --branch `which nosetests` \
		-vv --with-yanc $(FOCUS_INFO) -s test/

# run only tests annotated with @focus
focus:
	$(MAKE) unit FOCUS_INFO='--with-focus'

# run tests ignoring those annotated with @focus_ignore
focus_ignore:
	$(MAKE) unit FOCUS_INFO='--without-ignored'

# show coverage
coverage: unit
	@coverage report -m --fail-under=75

# generate a HTML coverage report
coverage-html: unit
	@coverage html -d cover

# delete *.pyc files
clean_pycs:
	@find . -name "*.pyc" -delete

# delete *.pyc files, run tests and show coverage
test: clean_pycs coverage
