@IsTest
public class CO_CheckInOutCT_test {
    
     @IsTest static void doset()  
     {
         Account acc  = new  Account();
         acc.Name = 'himanshu';
         insert acc;
        CO_CheckInOutCT.upsertRecord('Account',acc.id,12,10,'test'); 
         
         
         
         
         
     }

}