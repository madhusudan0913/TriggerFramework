public class TriggerHandlerUtility {
    public static Map<String,Integer> metadataDeveloperNameVsMaxLoopCount = new Map<String,Integer>();
    public static Map<String,Integer> metadataDeveloperNameVsExecutedLoopCount = new Map<String,Integer>();
    public static List<Trigger_Handler_Setting__mdt> getTriggerHandlerSettings(String opjectAPIName, String operationType){
        List<Trigger_Handler_Setting__mdt> thsList = new List<Trigger_Handler_Setting__mdt>([SELECT Id,
                                                                                             DeveloperName,
                                                                                             Class_Name__c,
                                                                                             Method_Name__c, 
                                                                                             Max_Loop_Count__c,
                                                                                             Order_Of_Execution__c 
                                                                                             FROM Trigger_Handler_Setting__mdt
                                                                                             WHERE
                                                                                             Object_API_Name__c =:opjectAPIName
                                                                                             AND Operation_Type__c =:operationType
                                                                                             AND Active__c = true
                                                                                             ORDER BY Order_Of_Execution__c ASC]);
        for(Trigger_Handler_Setting__mdt ths :thsList){
            if(!metadataDeveloperNameVsMaxLoopCount.containsKey(ths.DeveloperName)){
                metadataDeveloperNameVsMaxLoopCount.put(ths.DeveloperName,ths.Max_Loop_Count__c.intValue());
            }
        }
        return thsList;
    }
    
    public static Object handleEvent(String objectAPIName, String eventType, Map<String,Object> args) {
        try{
            for(Trigger_Handler_Setting__mdt ths :TriggerHandlerUtility.getTriggerHandlerSettings(objectAPIName,eventType)){
                
                if(metadataDeveloperNameVsExecutedLoopCount.containsKey(ths.DeveloperName)) 
                {
                    if(metadataDeveloperNameVsExecutedLoopCount.get(ths.DeveloperName) >= metadataDeveloperNameVsMaxLoopCount.get(ths.DeveloperName))
                        continue;
                    else
                        metadataDeveloperNameVsExecutedLoopCount.put(ths.DeveloperName,metadataDeveloperNameVsExecutedLoopCount.get(ths.DeveloperName)+1);
                }
                else{
                    metadataDeveloperNameVsExecutedLoopCount.put(ths.DeveloperName,1);
                }
                
                Callable extension = (Callable) Type.forName(ths.Class_Name__c).newInstance();
                extension.call(ths.Method_Name__c, args); 
            }
            return true;
        }
        catch(Exception e){
            return false;   
        }
    }
}