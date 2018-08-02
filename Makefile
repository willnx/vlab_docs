clean:
	-rm -rf docs/build
	-docker rmi `docker images -q --filter "dangling=true"`

build: clean
	cd docs && ${MAKE} html

images: build
	docker build -t willnx/vlab-docs .

up: build
	docker run -it --rm -p 5000:80 -v `pwd`/docs/build/html:/usr/share/nginx/html willnx/vlab-docs
