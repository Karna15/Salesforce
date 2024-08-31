public class JobSharing {
   
   public static boolean manualShareRead(Id recordId, Id userOrGroupId){
      Income__Share incomeShr  = new Income__Share();
      incomeShr.ParentId = recordId;
      incomeShr.UserOrGroupId = userOrGroupId;
      incomeShr.AccessLevel = 'Read';
      incomeShr.RowCause = Schema.Income__Share.RowCause.Manual;
      Database.SaveResult sr = Database.insert(incomeShr,false);

      if(sr.isSuccess()){
         return true;
      }
      else {
         Database.Error err = sr.getErrors()[0];
         
         if(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  &&  
                  err.getMessage().contains('AccessLevel')){
            return true;
         }
         else{
            return false;
         }
       }
   }
   
}