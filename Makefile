THEOS_DEVICE_IP=le-carote
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ActionsBank
$(TWEAK_NAME)_FILES = $(wildcard Actions/*.xm)
$(TWEAK_NAME)_LIBRARIES = powercuts

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
