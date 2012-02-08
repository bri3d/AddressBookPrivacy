#import <AddressBook/AddressBook.h>
#import <substrate.h>

CFArrayRef (*original_ABAddressBookCopyArrayOfAllPeople)(ABAddressBookRef addressBook);
CFArrayRef hooked_ABAddressBookCopyArrayOfAllPeople(ABAddressBookRef addressBook) {
	NSLog(@"GOT ABAddressBookCopyArrayOfAllPeople, BLOCKING");
    	dispatch_async(dispatch_get_main_queue(), ^{
        	NSString *applicationIdentifier = [[NSBundle mainBundle] bundleIdentifier];
        	NSString *messageText = [NSString stringWithFormat:@"Prevented %@ from accessing the address book.", applicationIdentifier];
        	UIAlertView *alert =
        		[[UIAlertView alloc] initWithTitle: @"Address Privacy"
                        		           message: messageText
                                  		  delegate: nil
                         		 cancelButtonTitle: @"OK"
                         		 otherButtonTitles: nil];
	        [alert show];
   	        [alert release];
    	});
        return CFArrayCreate(NULL,NULL,0,NULL);
}
CFIndex (*original_ABAddressBookGetPersonCount)(ABAddressBookRef addressBook);
CFIndex hooked_ABAddressBookGetPersonCount(ABAddressBookRef addressBook) {
  NSLog(@"GOT ABAddressBookGetPersonCount, BLOCKING");
  return 0;
}
%ctor {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSString *applicationIdentifier = [[NSBundle mainBundle] bundleIdentifier];
        if (![applicationIdentifier hasPrefix:@"com.apple"])
        { // Not an Apple app; safe to hook.
        	MSHookFunction((void *)ABAddressBookCopyArrayOfAllPeople, (void *)hooked_ABAddressBookCopyArrayOfAllPeople, (void **)&original_ABAddressBookCopyArrayOfAllPeople);
                MSHookFunction((void *)ABAddressBookGetPersonCount, (void *)hooked_ABAddressBookGetPersonCount, (void **)&original_ABAddressBookGetPersonCount);    
        }
        [pool drain];
}
