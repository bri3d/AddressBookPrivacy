#import <AddressBook/AddressBook.h>
#import <substrate.h>

CFArrayRef (*original_ABAddressBookCopyArrayOfAllPeople)(ABAddressBookRef addressBook);
CFArrayRef hooked_ABAddressBookCopyArrayOfAllPeople(ABAddressBookRef addressBook) {
  NSLog(@"GOT ABAddressBookCopyArrayOfAllPeople, BLOCKING");
  NSString *applicationIdentifier = [[NSBundle mainBundle] bundleIdentifier];
  if ([applicationIdentifier hasPrefix:@"com.apple"])
  { // Apple app; safe; exit
    return original_ABAddressBookCopyArrayOfAllPeople(addressBook);
  }
  NSString *messageText = [NSString stringWithFormat:@"Prevented %@ from accessing the address book.", applicationIdentifier];
  UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle: @"Address Privacy"
                             message: messageText
                             delegate: nil
                             cancelButtonTitle: @"OK"
                             otherButtonTitles: nil];
   [alert show];
   [alert release];
  return CFArrayCreate(NULL,NULL,0,NULL);
}
CFIndex (*original_ABAddressBookGetPersonCount)(ABAddressBookRef addressBook);
CFIndex hooked_ABAddressBookGetPersonCount(ABAddressBookRef addressBook) {
  NSLog(@"GOT ABAddressBookGetPersonCount, BLOCKING");
  return 0;
}


%ctor {
  NSString *applicationIdentifier = [[NSBundle mainBundle] bundleIdentifier];
  if (![applicationIdentifier hasPrefix:@"com.apple"])
  { // Apple app; safe; exit
    MSHookFunction((void *)ABAddressBookCopyArrayOfAllPeople, (void *)hooked_ABAddressBookCopyArrayOfAllPeople, (void **)&original_ABAddressBookCopyArrayOfAllPeople);
    MSHookFunction((void *)ABAddressBookGetPersonCount, (void *)hooked_ABAddressBookGetPersonCount, (void **)&original_ABAddressBookGetPersonCount);    
  }
}
