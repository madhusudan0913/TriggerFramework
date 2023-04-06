@isTest
public class AccountTriggerTest {
    @isTest
    static void createAccount(){
        Account acc = new Account();
        acc.Name = 'test account';
        insert acc;
        update acc;
        delete acc;
    }
}