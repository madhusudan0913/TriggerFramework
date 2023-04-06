# TriggerFramework

Installation Link
https://login.salesforce.com/packaging/installPackage.apexp?p0=04t6F000001ZMe6

To Create new trigger, follow below steps.

1. Configure Trigger Handler settings(Custom Metadata type) as shown in the below screenshot.

![image](https://user-images.githubusercontent.com/56514944/230506100-a77f5f6c-03fb-4f08-9178-e3034f34d74f.png)

2. Create a trigger on the target object as shown below

```java
trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    TriggerHandler handler = new AccountTriggerHandler();
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            handler.beforeInsert(Trigger.new);
        }
        when BEFORE_UPDATE {
            handler.beforeUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);
        }
        when BEFORE_DELETE {
            handler.beforeDelete(Trigger.old, Trigger.oldMap);
        }
        when AFTER_INSERT {
            handler.afterInsert(Trigger.new, Trigger.newMap);
        }
        when AFTER_UPDATE {
            handler.afterUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);
        }
        when AFTER_DELETE {
            handler.afterDelete(Trigger.old, Trigger.oldMap);
        }
        when AFTER_UNDELETE {
            handler.afterUndelete(Trigger.new, Trigger.newMap);
        }
    }
}
```

2. Create Trigger Handler Class
```java
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
```
3. Create helper class
```java
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
```

Please note that action enum should be same as what you configured in custom metadata type
