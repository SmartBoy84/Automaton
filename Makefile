TARGET := iphone:clang:latest:12.2
INSTALL_TARGET_PROCESSES = SpringBoard

ARCHS = arm64 arm64e

THEOS_DEVICE_IP = le-carote
DEBUG = 0
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Automaton

$(TWEAK_NAME)_FILES = $(shell find Sources/Automaton -name '*.swift') $(shell find Sources/AutomatonC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
$(TWEAK_NAME)_SWIFTFLAGS = -ISources/AutomatonC/include
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -ISources/AutomatonC/include
$(TWEAK_NAME)_LIBRARIES = powercuts activator
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = SpringBoard MediaRemote FrontBoard

include $(THEOS_MAKE_PATH)/tweak.mk
