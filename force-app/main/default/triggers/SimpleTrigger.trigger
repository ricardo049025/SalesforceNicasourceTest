trigger SimpleTrigger on Account (after insert) {

    List<Contact> contactList = new List<Contact>();
    
    for(Account a : Trigger.New)
    {
        
        Contact contact = new Contact();
        contact.lastName = a.Name;
        
        contactList.add(contact);
    }
    
    insert contactList;

}