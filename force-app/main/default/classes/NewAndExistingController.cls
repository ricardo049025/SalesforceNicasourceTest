public class NewAndExistingController 
{
    //variable to use
    public Account account{get; private set;}
    
    //Constructor
    public NewAndExistingController()
    {
        Id id = ApexPages.currentPage().getParameters().get('id');
        account = (id == null ? new Account() : [SELECT Id, Name, Industry,Phone FROM Account WHERE Id =: id]);
        
    }
    
    //Methods
    public PageReference save()
    {
        try
        {
            upsert account;
        }catch(System.DMLException ex)
        {
            ApexPages.addMessages(ex);
            return null;
        }
        
        PageReference redirectSuccess = new ApexPages.StandardController(Account).view();
        return redirectSuccess;
    }
}