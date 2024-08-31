public class createCSVFile {
    public static void createCSV(){
        String csvColumnHeader = 'Id , Name , Phone';
        String csvRowVal;
        String csvString = 'Id , Name , Phone \n';
        List<String> csvRowValues = new List<String>();
        for(Account ac: [Select Id, Name, Phone From Account Limit 5]){
            csvRowVal = ac.Id + ',' + ac.Name + ',' + ac.Phone;
            csvString += csvRowVal + '\n';
            csvRowVal = null;
        }
        ContentVersion cv = new ContentVersion();
        cv.Title = 'Accounts.csv';
        cv.PathOnClient = 'Accounts.csv';
        cv.VersionData = Blob.valueOf(csvString);
        insert cv;
    }
    public static void createExcel(){
        String csvColumnHeader = 'Id , Name , Phone';
        String csvRowVal;
        String csvString = 'Id \t Name \t  Phone \n';
        List<String> csvRowValues = new List<String>();
        for(Account ac: [Select Id, Name, Phone From Account Limit 5]){
            csvRowVal = ac.Id + '\t ' + ac.Name + '\t ' + ac.Phone;
            csvString += csvRowVal + '\n';
            csvRowVal = null;
        }
        ContentVersion cv = new ContentVersion();
        cv.Title = 'Accounts.xls';
        cv.PathOnClient = 'Accounts.xls';
        cv.VersionData = Blob.valueOf(csvString);
        insert cv;
    }
}