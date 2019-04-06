export ISIS_F1=$(HOME)/lib/isis/utils
export ISIS_F2=$(HOME)/lib/isis/plm80
export ISIS_F3=$(HOME)/lib/isis/asm80

all: sched.prl sched.rsp

sched.rsp: sched.plm
	@echo "***** Making $@ *****"
	isis :f2:plm80 sched.plm "pagewidth(80) debug"
	isis :f1:link sched.obj,monx,:f1:plm80.lib to sched.mod
	@rm sched.obj
	isis :f1:locate sched.mod to sched1 "code(0000H) stacksize(0)"
	isis :f1:locate sched.mod to sched2 "code(0100H) stacksize(0)"
	@rm sched.mod
	isis :f1:objhex sched1 to sched1.hex
	isis :f1:objhex sched2 to sched2.hex
	@rm sched2
	zxcc objcpm sched1
	@rm sched1 sched1.com
	cat sched1.hex sched2.hex > sched.hex
	zxcc genmod sched.hex sched.rsp
	@rm sched*.hex

sched.prl: mschd.plm
	@echo "***** Making $@ *****"
	isis :f2:plm80 mschd.plm "pagewidth(80) debug"
	isis :f1:link mschd.obj,x0100,:f1:plm80.lib to mschd1.mod
	isis :f1:locate mschd1.mod "code(0100H) stacksize(48)"
	@rm mschd1.mod
	isis :f1:objhex mschd1 to mschd1.hex
	isis :f1:link mschd.obj,x0200,:f1:plm80.lib to mschd2.mod
	isis :f1:locate mschd2.mod "code(0200H) stacksize(48)"
	@rm mschd2.mod
	isis :f1:objhex mschd2 to mschd2.hex
	@rm mschd2
	zxcc objcpm mschd1
	@rm mschd1 mschd1.com
	cat mschd1.hex mschd2.hex > mschd.hex
	@rm mschd1.hex mschd2.hex
	zxcc genmod mschd.hex sched.prl 
	@rm *.hex

copy:
	cpmrm -f p112 /dev/fd0 0:sched.prl
	cpmcp -f p112 /dev/fd0 sched.prl 0:
	cpmrm -f p112 /dev/fd0 0:sched.rsp
	cpmcp -f p112 /dev/fd0 sched.rsp 0:

clean:
	rm -f *.obj *.lst *.lin *.sym *.prl *.rsp *~
