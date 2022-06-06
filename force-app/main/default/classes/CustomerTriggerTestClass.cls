@isTest
private class CustomerTriggerTestClass
{
    
    static testMethod void myUnitTest()
    {
        //Create the Data customer
        APEX_Customer__c customer = new APEX_Customer__c();
        customer.Name = 'Test Customer';
        customer.APEX_Customer_Status__c = 'Inactive';
        
        insert customer;
        
        // Update the statement for fire the trigger
        Test.startTest();
        
        customer.APEX_Customer_status__c = 'Active';
        update customer;
        
        Test.stopTest();
        
        //see if our expected result is equal to the actual result assert()
        List<APEX_Invoice__c> invList = [SELECT Id, APEX_Customer__c FROM APEX_Invoice__c WHERE APEX_Customer__c =: customer.Id];
        
        System.assertEquals(1, invList.size());
        
    }

}