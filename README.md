Test steps:

	# Initial setup
	docker build -t docker-ngc-test .
	docker run -it -v $PWD:/test docker-ngc-test

	# Inside Docker
	rm -rf .tmp 2> /dev/null ; cp -a /quickstart .tmp ; cd .tmp

	# Standard TypeScript compiler test
	time tsc -p .

	# Angular compiler test
	time ngc -p .
