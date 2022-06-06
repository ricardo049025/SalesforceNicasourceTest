global class CustomerProcessingBatch implements Database.Batchable<SObject>
{
    global string[] email = new String[]{'ricardom0490@icloud.com'};
    
    //START Method
    //here we retrieve all the records to be proccess
    global Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator('SELECT Id, Name,APEX_Customer_Status__c, APEX_Customer_Description__c FROM APEX_Customer__c WHERE APEX_Active__c = True');
    }
    
    //Execute Method
    global void execute(Database.BatchableContext bc, List<SObject> scope)
    {
        List<APEX_Customer__c> customerList = new List<APEX_Customer__c>();

        for(SObject o : scope)
        {
			APEX_Customer__c customer = (APEX_Customer__c) o;
            customer.APEX_Customer_Description__c = 'Updated via Batch job';
			customer.APEX_Customer_Status__c = 'Paid';
            
            customerList.add(customer);
            System.debug('records updated: ' + customerList);
        }
        
        if(customerList != null && customerList.size() > 0)
        {
            Database.update(customerList);
            System.debug('Records are successfully updated ' + customerList);
        }
        
    }
    
    //FINISH METHOD
    global void finish(Database.BatchableContext bc)
    {
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        AsyncApexJob a = [SELECT a.TotalJobItems, a.Status, a.NumberOfErrors, 
				          a.JobType,a.JobItemsProcessed,a.ExtendedStatus,a.createdById, a.completedDate 
				  		  FROM AsyncApexJob a 
					      WHERE id = :bc.getJobId()];
        
        System.debug('Job id:' + bc.getJobId());
        mail.setToAddresses(email);
        mail.setReplyTo('ricardom0490@gmail.com');
        mail.setSenderDisplayName('APEX BATCH Proccessing Module');
        mail.setSubject('Batch Proccessing ' + a.Status);
        mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems + 'batches with ' + a.NumberOfErrors + 
                              'failures' + 'Job proccessed are ' + a.JobItemsProcessed);
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage [] {mail});
    }
}