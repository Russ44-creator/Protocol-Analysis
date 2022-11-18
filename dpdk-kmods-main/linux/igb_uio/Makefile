KSRC ?= /lib/modules/`uname -r`/build

all:
	make -C $(KSRC)/ M=$(shell pwd)

clean:
	make -C $(KSRC)/ M=$(shell pwd) clean
