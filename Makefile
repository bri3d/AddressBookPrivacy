include theos/makefiles/common.mk

TWEAK_NAME = AddressBookPrivacy
AddressBookPrivacy_FILES = Tweak.xm
AddressBookPrivacy_FRAMEWORKS = UIKit AddressBook
include $(THEOS_MAKE_PATH)/tweak.mk
