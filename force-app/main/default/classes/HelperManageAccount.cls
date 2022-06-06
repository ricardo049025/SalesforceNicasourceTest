public with sharing class HelperManageAccount {
    
    @AuraEnabled
    public static String CreateAccount(String account)
    {
        try {
            
            Account acc = (Account)JSON.deserialize(account, Account.class);
            insert acc;
            
            return (String)acc.Id;
        } catch (Exception ex) {
            return '';    
        }
          
    }

    @AuraEnabled
    public static String CreateContract(String con)
    {
        try {

            //insertin contract
            Contract contract = (Contract)JSON.deserialize(con, Contract.class);
            insert contract;

            //get Account
            Account account = [select Id,Name FROM Account Where Id =: contract.AccountId];

            //Inserting renewal contract
            Renewal_contract__c c = new Renewal_contract__c();
            c.Account__c = account.Id;
            c.Contract__c = contract.Id;
            c.Renewal_Completed__c = Date.today();
            c.Stept2__c = true;
            
            insert c;

            return 'Ok'; 

        } catch (Exception ex) {
            System.debug('error aqui ricardo: ' + ex.getMessage());
            return 'failed: ' + ex.getMessage(); 
        }
          
    }

}
