#
#  modplayer - Amiga SoundTracker/ProTracker Module Player for Playdate.
#
#  Based on littlemodplayer by Matt Evans.
#
#  MIT License
#  Copyright (c) 2022 Didier Malenfant.
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in all
#  copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#  SOFTWARE.
#
 
.PHONY: clean
.PHONY: build
.PHONY: run
.PHONY: copy

HEAP_SIZE      = 8388208
STACK_SIZE     = 61800

PRODUCT = modplayerdemo.pdx

# -- Locate the SDK
SDK = $(shell egrep '^\s*SDKRoot' ~/.Playdate/config | head -n 1 | cut -c9-)
SDKBIN = $(SDK)/bin

GAME=$(notdir $(CURDIR))
SIM=Playdate Simulator

VPATH += extension
VPATH += modplayer

# List C source files here
SRC = extension/main.c \
	  modplayer/modplayer.c \
	  modplayer/platform.c \
	  modplayer/lmp/littlemodplayer.c

# List all user directories here
UINCDIR = extension modplayer

# List user asm files
UASRC = 

# List all user C define here, like -D_DEBUG=1
UDEFS = 

# Define ASM defines here
UADEFS = 

# List the user directory to look for the libraries here
ULIBDIR =

# List all user libraries here
ULIBS =

include $(SDK)/C_API/buildsupport/common.mk

# Make sure we compile a universal binary for M1 macs
DYLIB_FLAGS += -arch x86_64 -arch arm64

build: clean compile run

run: open

clean:
	rm -rf '$(GAME).pdx'

compile: Source/main.lua
	"$(SDKBIN)/pdc" 'Source' '$(GAME).pdx'
	

open:
	open -a '$(SDKBIN)/$(SIM).app/Contents/MacOS/$(SIM)' '$(GAME).pdx'

test: open 
