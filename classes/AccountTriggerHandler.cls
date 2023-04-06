public without sharing class AccountTriggerHandler implements TriggerHandler {
    public static Integer loopCount = 0;
    public AccountTriggerHelper helper;
    public AccountTriggerHandler() {
        this.helper = new AccountTriggerHelper();
    }
    public void beforeInsert(List<Account> newAccounts) {
        TriggerHandlerUtility.handleEvent('Account','BEFORE_INSERT', new Map<String, Object> {'TriggerNew' => newAccounts} );
    }
    
    public void beforeUpdate(List<Account> oldAccounts, List<Account> newAccounts, Map<ID, SObject> oldAccountMap, Map<ID, SObject> newAccountMap) {}
    public void beforeDelete(List<Account> oldAccounts, Map<ID, SObject> oldAccountMap) {}
    public void afterInsert(List<Account> newAccounts, Map<ID, SObject> newAccountMap) {}
    public void afterUpdate(List<Account> oldAccounts, List<Account> newAccounts, Map<ID, SObject> oldAccountMap, Map<ID, SObject> newAccountMap) {}
    public void afterDelete(List<Account> oldAccounts, Map<ID, SObject> oldAccountMap) {}
    public void afterUndelete(List<Account> newAccounts, Map<ID, SObject> newAccountMap) {}
    
    
}