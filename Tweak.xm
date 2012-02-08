#import <AddressBook/AddressBook.h>
#import <substrate.h>

CFArrayRef (*original_ABAddressBookCopyArrayOfAllPeople)(ABAddressBookRef addressBook);
CFArrayRef hooked_ABAddressBookCopyArrayOfAllPeople(ABAddressBookRef addressBook) {
  NSLog(@"GOT ABAddressBookCopyArrayOfAllPeople, BLOCKING");
  return CFArrayCreate(NULL,NULL,0,NULL);
}


%ctor {
    MSHookFunction((void *)ABAddressBookCopyArrayOfAllPeople, (void *)hooked_ABAddressBookCopyArrayOfAllPeople, (void **)&original_ABAddressBookCopyArrayOfAllPeople);
}
