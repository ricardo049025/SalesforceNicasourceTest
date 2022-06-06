public class myControllerExtension
{
    //variabler to use
    private final Account account;

    //constructor
    public myControllerExtension(ApexPages.StandardController controller)
    {
        this.account = (Account)controller.getRecord();
    }
    
    public string getGreeting()
    {
        return 'Hello ' + this.account.Name + ' (' + account.id + ')';
    }
    
}