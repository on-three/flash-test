
#dir structure
BIN := bin
SRC := src

# what we will build
# "target".as compiled into "target".swf
TARGET_SWF ?= $(BIN)/test.swf
TARGET_MP4 ?= $(TARGET_SWF).mp4

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
# standalone flash player for quick testing
# player (projector) available at:
# http://www.adobe.com/support/flashplayer/debug_downloads.html
PLAYER := /home/on-three/local/flash/flashplayer

all: $(TARGET_SWF)

$(BIN)/%.swf: $(SRC)/%.as
	mkdir -p $(@D)
	$(MXMLC) -debug=true \
		-static-link-runtime-shared-libraries=false \
		-optimize=false \
		-o $@ -file-specs \
		$^

DECOMPRESSED_SWF := $(TARGET_SWF)_decompressed.swf
$(DECOMPRESSED_SWF): $(TARGET_SWF)
	swfcombine -d $(TARGET_SWF) -o $@

decompress: $(DECOMPRESSED_SWF)

run: $(TARGET_SWF)
	$(PLAYER) $^

#convert: $(TARGET_SWF)
#	vlc \
#		-I dummy -vvv swf/hearts.swf \
#		--sout=#transcode{vcodec=h264,vb=1024,acodec=mp4a,ab=192,channels=2,deinterlace}:standard{access=file,mux=ts,dst=MyVid.mp4}

# attempt to convert to video via dump-gnash and mplayer
# see: https://stackoverflow.com/questions/33151918/convert-swf-file-to-mp4-using-ffmpeg
TMP_BIN_VIDEO := $(TARGET_SWF).bin
$(TARGET_MP4): $(TARGET_SWF)
	dump-gnash -1 -r 1 -D $(TMP_BIN_VIDEO) $(TARGET_SWF)
	mplayer $(TMP_BIN_VIDEO) -vo yuv4mpeg:file=$(TARGET_MP4) \
		-demuxer rawvideo -rawvideo \
		fps=24:w=500:h=500:format=bgra

convert: $(TARGET_MP4)

play: $(TARGET_MP4)
	mpv $(TARGET_MP4)

clean:
	rm -fr $(BIN)
