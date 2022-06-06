public class AccountCustomController
{
    //Varible to use
    private final Account account;
    
    //constructor for the class
    public AccountCustomController()
    {
        this.account = [SELECT Id, Name, Site FROM Account WHERE Id =: ApexPages.currentPage().getParameters().get('id')];
    }
    
    //Method for return account
    public Account getAccount()
    {
        return this.account;
    }
    
    //Method for save and update record
    public PageReference save()
    {
        update account;
                
        return null;
    }
}