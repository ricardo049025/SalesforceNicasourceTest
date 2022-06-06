public class accountlistcontr {
    
    public ApexPages.StandardSetController acct{
    
        get{
            if(acct == null){
                acct = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Name, AccountNumber FROM Account]));
            }
            return acct;
        }
        set;
    }

    public List<Account> getAccountlist() {
        return (List<Account>) acct.getRecords();
    }

}