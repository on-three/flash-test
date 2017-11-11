
#dir structure
BIN := bin
SRC := src

# what we will build
# "target".as compiled into "target".swf
TARGET ?= test
TARGET_SWF := $(BIN)/$(TARGET).swf

# adobe air/flex/flash/shit tools
# Got flex-sdk at: http://download.macromedia.com/pub/flex/sdk/flex_sdk_3.6a.zip
# installation on linux is a pain
FLEX_TOOLS ?= /home/on-three/code/flex/bin
# mxmlc is used to compile .swf files from .as and maybe .mxml files
# for command line use see here:
# https://help.adobe.com/en_US/flex/using/WS2db454920e96a9e51e63e3d11c0bf69084-7ab6.html
MXMLC := $(FLEX_TOOLS)/mxmlc
# compc is used to compile .swc libraries from .as and maybe mxml files
# .swc libraries are really just .swf files zipped up with some xml
COMPC := $(FLEX_TOOLS)/compc

all: $(TARGET_SWF)


# $(MXMLC) -debug=false -static-link-runtime-shared-libraries=true -optimize=true -o recorder.swf -file-specs flash/FlashRecorder.as
$(TARGET_SWF): $(BIN) $(SRC)/$(TARGET).as
	$(MXMLC) -debug=false -static-link-runtime-shared-libraries=true -optimize=true -o $@ -file-specs $(SRC)/$(TARGET).as

$(BIN):
	mkdir -p $@

clean:
	rm -fr $(BIN)
