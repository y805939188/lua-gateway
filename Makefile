all: cicd

cicd: clean
	mkdir -p ./release
	./build.sh
