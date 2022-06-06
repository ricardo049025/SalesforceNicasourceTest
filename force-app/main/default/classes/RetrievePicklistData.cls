public class RetrievePicklistData {

    public List<SelectOption> getpickNames()
    {
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Schema.SObjectType.Opportunity.fields.StageName.getSObjectField().getDescribe();
        options.add(new SelectOption('---None---','---None---'));
        
        for(PicklistEntry p : fieldResult.getPicklistValues())
        {
			options.add(new SelectOption(p.getValue(),p.getLabel()));
        }
        
        return options;
    }
}