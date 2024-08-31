// Named Credentials as Callout Endpoints (HTTP Callout with basic authentication)
public class AnimalListController {
    public static void makeGetCallout(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Animal_Callout/api/animals');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        if(res.getStatusCode() == 200){
            List<Object> responseData =  (List<Object>) JSON.deserializeUntyped(res.getBody());
            System.debug('responseData -> ' + responseData);
            List<Animal__c> recordstoUpsert = new List<Animal__c>();
            
            for(Object record: responseData){
                Map<String, Object> animalData = (Map<String, Object>)record;
                System.debug('animalData -> ' + animalData);
                Integer animalExternalId = (Integer) animalData.get('id');
                String animalName = (String) animalData.get('name');
                String foodCategory = (String) animalData.get('food-category');
                String parkName = (String) animalData.get('park-name');
                Integer count = (Integer) animalData.get('count');
                
                recordstoUpsert.add(new Animal__c(External_ID__c = animalExternalId,
                                                  Animal_Name__c = animalName,
                                                  Food_Category__c = foodCategory,
                                                  Count__c = count,
                                                  Park_Name__c = parkName));
                try{
                    upsert recordstoUpsert External_ID__c;
                } catch(DmlException ex){
                    System.debug(ex.getMessage());
                }
            }
        }
    }
}