default: build

build:
	@argbash-2.10.0/bin/argbash avd-bootstrap.template > avd-bootstrap.sh

run: 
	@./avd-bootstrap.sh

clean:
	@rm avd-bootstrap.sh