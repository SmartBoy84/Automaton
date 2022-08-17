TARGET := iphone:clang:latest
ARCHS = arm64 arm64e

THEOS_DEVICE_IP=le-carote

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Automaton
$(TWEAK_NAME)_FILES = Tweak.xm $(wildcard Actions/*.xm)
$(TWEAK_NAME)_FRAMEWORKS = Foundation
$(TWEAK_NAME)_LIBRARIES = powercuts activator
$(TWEAK_NAME)_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
