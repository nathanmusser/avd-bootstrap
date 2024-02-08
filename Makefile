default: clean build run-all

build:
	@argbash-2.10.0/bin/argbash avd-bootstrap.template > avd-bootstrap.sh

clean:
	@rm avd-bootstrap.sh

run-ubuntu:
	@echo "\n##### UBUNTU #####"
	@scp avd-bootstrap.sh v-avd-bstrap-ubuntu:~/
	-@ssh v-avd-bstrap-ubuntu ~/avd-bootstrap.sh

run-debian:
	@echo "\n##### DEBIAN #####"
	@scp avd-bootstrap.sh v-avd-bstrap-debian:~/
	-@ssh v-avd-bstrap-debian ~/avd-bootstrap.sh

run-rocky:
	@echo "\n##### ROCKY #####"
	@scp avd-bootstrap.sh v-avd-bstrap-rocky:~/
	-@ssh v-avd-bstrap-rocky ~/avd-bootstrap.sh

run-alma:
	@echo "\n##### ALMA #####"
	@scp avd-bootstrap.sh v-avd-bstrap-alma:~/
	-@ssh v-avd-bstrap-alma ~/avd-bootstrap.sh

run-all: run-ubuntu run-debian run-rocky run-alma