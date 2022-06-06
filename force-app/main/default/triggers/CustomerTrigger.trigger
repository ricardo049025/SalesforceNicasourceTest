trigger CustomerTrigger on APEX_Customer__c (before Update) {

    List<APEX_Customer__c> customerList = new List<APEX_Customer__c>();
    
    for(APEX_Customer__c c : Trigger.New)
    {
        System.Debug('Current value c: ' + c);
        
        if(c.APEX_Active__c == true)
        {
            c.APEX_Customer_Description__c = 'Updated';
            System.Debug('The record which has satisfied the if condition' + c);
        }
    
    }

}