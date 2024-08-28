# compile app
.PHONY: compile
compile: sbt
	./docker.sh --no-cache

# prepare sbt image
sbt: sbt.dockerfile
	docker build --tag experimental-sbt-cache-sbt --file $< .

# remove caches
.PHONY: clean
clean:
	git clean -d -f
