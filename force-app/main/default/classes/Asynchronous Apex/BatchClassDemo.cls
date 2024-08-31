// Database.Stateful Demo
public class BatchClassDemo implements Database.Batchable<sObject>, Database.Stateful{
    
    public Decimal SummofallOppy = 0;
    
    public Database.QueryLocator start(Database.BatchableContext  bc){
        String query = 'Select Id, Amount From Opportunity';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext  bc, List<Opportunity> oppList){
        for(Opportunity op : oppList){
            if(op.Amount != null){
                SummofallOppy += op.Amount;
            }
        }
    }
    
    public void finish(Database.BatchableContext  bc){
        System.debug('Total sum : 6483100 --> ' + SummofallOppy);
    }

}