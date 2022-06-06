public class CustomerTriggerHelper
{
    
    public static void isAfterUpdateCall(List<APEX_Customer__c> customerList, Map<id,APEX_Customer__c> newMapCustomer ,Map<id,APEX_Customer__c> oldMapCustomer)
    {
        
        createInvoiceRecord(customerList,oldMapCustomer);
        updateInvoiceDesc(customerList, newMapCustomer);
    
    }
    
    public static void createInvoiceRecord(List<APEX_Customer__c> customerList, Map<id,APEX_Customer__c> oldMapCustomer)
    {
        List<APEX_Invoice__c> invoiceList = new List<APEX_Invoice__c>();
        
        for(APEX_Customer__c c : customerList)
        {
            if(c.APEX_Customer_Status__c == 'Active' && oldMapCustomer.get(c.Id).APEX_Customer_Status__c == 'Inactive')
            {
                APEX_Invoice__c invoice = new APEX_Invoice__c();
                invoice.APEX_Status__c = 'Pending';
                invoice.APEX_Customer__c = c.Id;
                
                invoiceList.add(invoice);
            }
        }
        
        insert invoiceList;
        
    }
    
    public static void updateInvoiceDesc(List<APEX_Customer__c> customerList,Map<id,APEX_Customer__c> newMapCustomer)
    {
        List<APEX_Customer__c> customerListWithInvoice = [SELECT Id, Name,(SELECT Id, Name, APEX_Description__c FROM Invoices__r) 
                                                          FROM APEX_Customer__c
                                                          WHERE Id In :newMapCustomer.keySet()];
                                                          
        List<APEX_Invoice__c> invoiceToUpdate = new List<APEX_Invoice__c>();
        List<APEX_Invoice__c> invList = customerListWithInvoice[0].Invoices__r;
        
        for(APEX_Invoice__c c : invList)
        {
            c.APEX_Description__c = 'OK TO PAY';
            invoiceToUpdate.add(c);
        }
        
        update invoiceToUpdate;
    }

}