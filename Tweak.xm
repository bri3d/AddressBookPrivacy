#import <AddressBook/AddressBook.h>
#import <substrate.h>

ABAddressBookRef (*original_ABAddressBookCreate)();
ABAddressBookRef hooked_ABAddressBookCreate() {
  NSLog(@"Got ABAddressBookCreate");
  return original_ABAddressBookCreate();
}
CFArrayRef (*original_ABAddressBookCopyArrayOfAllPeople)(ABAddressBookRef addressBook);
CFArrayRef hooked_ABAddressBookCopyArrayOfAllPeople(ABAddressBookRef addressBook) {
  NSLog(@"Got ABAddressBookCopyArrayOfAllPeople");
  return CFArrayCreate(NULL,NULL,0,NULL);
  //return original_ABAddressBookCopyArrayOfAllPeople(addressBook);
}


%ctor {
    MSHookFunction((void *)ABAddressBookCreate, (void *)hooked_ABAddressBookCreate, (void **)&original_ABAddressBookCreate);
    MSHookFunction((void *)ABAddressBookCopyArrayOfAllPeople, (void *)hooked_ABAddressBookCopyArrayOfAllPeople, (void **)&original_ABAddressBookCopyArrayOfAllPeople);
}
