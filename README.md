Address Book Privacy
====================

This MobileSubstrate Tweak hooks ABAddressBookCopyArrayOfAllPeople to prevent apps like Path from jacking your Address Book contacts without your permission.

When a non-Apple app accesses this method, a UIAlert will appear documenting the attempted access and the hooked function will return an empty array.

TODO
====

Obviously, save prefs on a per-app basis to allow certain apps to access ABAddressBookCopyArrayOfAllPeople and not others.

Prevent leaks: Support other methods for Address Book access; because ABAddressBookCopyArrayOfAllPeople is both the easiest and the most documented way to do this, 99% of apps use it, but a few don't.

Test more for stability.

Eventually, to sate my curiosity, figure out why Apple apps crash when MSHookFunction is used.
