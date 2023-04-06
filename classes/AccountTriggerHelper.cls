public without sharing class AccountTriggerHelper implements Callable {
    public AccountTriggerHelper() {
        System.debug('Inside AccountTriggerHelper Constructor');
    }
    public static Object doTask1(List<Account> newAccounts) {
        System.debug('Inside Task 1'+newAccounts);
        return true;
    }
    public static Object doTask2(List<Account> newAccounts) {
        System.debug('Inside Task 2'+newAccounts);
        return true;
    }
   
   
   public static Object call(String action, Map<String, Object> args) {
        switch on action {            
           when 'doTask1' {
                return doTask1(
                    (List<Account>)args.get('TriggerNew')
                );
            }
			when 'doTask2' {
                return doTask2(
                    (List<Account>)args.get('TriggerNew')
                );
            }
            when else {
                return false;
            }
        }
    }
   
}