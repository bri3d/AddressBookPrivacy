Update
======

A better implementation of the same concept is available at https://github.com/rpetrich/ContactPrivacy - please use rpetrich's version instead for now.

Address Book Privacy
====================

This MobileSubstrate Tweak hooks ABAddressBookCopyArrayOfAllPeople to prevent apps like Path from jacking your Address Book contacts without your permission.

When a non-Apple app accesses this method, a UIAlert will appear documenting the attempted access and the hooked function will return an empty array.

![Screenshot](http://i.imgur.com/wGcRVl.png)

(Don't worry, those are just the default "recommended" Hipster users - no friend disclosure here!)

TODO
====

Obviously, save prefs on a per-app basis to allow certain apps to access ABAddressBookCopyArrayOfAllPeople and not others.

Prevent leaks: Support other methods for Address Book access; because ABAddressBookCopyArrayOfAllPeople is both the easiest and the most documented way to do this, 99% of apps use it, but a few don't.

Test more for stability.

Eventually, to sate my curiosity, figure out why Apple apps crash when MSHookFunction is used.

Building
========

Clone; init and update submodules.

Obtain ldid for Theos. The instructions at the [iPhone Dev Wiki](http://iphonedevwiki.net/index.php/Theos/Getting_Started) tell you how.

Jailbreak and Install OpenSSH on your iPhone using Cydia.

export THEOS_DEVICE_IP = <your iPhone's IP>

make package; make install

This should automatically re-spring your iPhone and you should be ready to go. In some edge cases I've seen the phone require a reboot, especially if you have a previous version installed.
