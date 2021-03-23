public with sharing class AddMultipleRowCtrl{
    
   
    @AuraEnabled
    public static string AddNewRow(string lstMultiRow){
        system.debug('lstMultiRow....'+lstMultiRow);
        WrappMain objWrap=new WrappMain();
        try{
            objWrap.success = false;
            objWrap.lstDFA = (List<DFAwrap>)JSON.deserialize(lstMultiRow, List<DFAwrap>.class);
            system.debug(objWrap.lstDFA+'...objWrap.lstDFA....'+objWrap.lstDFA.size());
            DFAwrap objWDI = new DFAwrap();
            objWDI.objDFA = new DFA__c();
            objWrap.lstDFA.add(objWDI);
            objWrap.success=true;
            objWrap.errorMessage='';
        }catch(exception e){
            objWrap.success=false;
            objWrap.errorMessage=e.getMessage();
        }
        return Json.serialize(objWrap);
    }
    
    @AuraEnabled 
    public static string RemoveRowIndex(string lstMultiRow)
    {
        WrappMain objWrap=new WrappMain();
       // objWrap =(WrappMain)Json.deserialize(strobjWrap, WrappMain.class);
        try{
            if(lstMultiRow !=null && lstMultiRow !='')
            {
                List<DFAwrap> lstDFA = (List<DFAwrap>)JSON.deserialize(lstMultiRow, List<DFAwrap>.class);
                objWrap.lstDFA = lstDFA;
                objWrap.success = true;
                objWrap.errorMessage = '';
            }
        }catch(exception e){
            objWrap.success = false;
            objWrap.errorMessage = e.getMessage();
        }
        return Json.serialize(objWrap);
    }
    
    Public class WrappMain{
        public boolean success;
        public string errorMessage;
        public string SuccessMessage;
        public Application_Form__c objApp;
        public List<String> lstConstitution;
        public list<DFAwrap>lstDFA;
    }
    public class DFAwrap{
        @AuraEnabled public DFA__c objDFA;
    }
}