PYTHON2:=python2
PYTHON3:=python3

.PHONY: init
init:
	pip install pipenv
	pipenv install --dev

.PHONY: test
test:
	tox -e py36

.PHONY: test
test-all:
	tox

.PHONY: dist
dist: test-all
	$(PYTHON3) setup.py bdist_wheel --universal

dist-upload: clean-dist dist
	twine upload dist/*

clean-dist:
	rm -rf build
	rm -rf dist

.PHONY: doc
doc:
	$(MAKE) -C docs html

.PHONY: doc-serve
doc-serve: doc
	cd docs/build/html && $(PYTHON3) -m http.server
