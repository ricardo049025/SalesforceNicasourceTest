trigger MyAccountTrigger on Account (before Delete) {

    if(Trigger.isBefore)
    {
        if(Trigger.isDelete)
        {
            // is before delete trigger, the triggers acces to the records that will be
            //deleted with the trigger.old list.
            
            for(Account a : Trigger.old)
            {
                if(a.Name != 'okToDelete')
                    a.addError('You can not delete this account record');
                
            }
            
        }
    }

}