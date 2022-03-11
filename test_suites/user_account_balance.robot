*** Settings ***
Documentation    A test suite for user account blance.
...
...         Keywords are imported from the resource files
Resource    ../keywords/common.resource
Resource    ../keywords/user_signup.resource

Resource          ../keywords/user_account_balance.resource
Test Teardown     Close Browser
Suite Setup       Set Screenshot Directory                     path=${EXECDIR}/signup_screenshots
Suite Teardown    Close All Browsers


*** Test Cases ***
Account Balance Should Update Every 10 Seconds After Deposit
    Navigate to AnyLogi Website                              browser=${browser}
    Sign Up Account
    Logout From Account
    Login To Account
    Loop To Make A Transaction And Verify Account Balance    action=deposit        loop=5

Account Balance Should Update Every 10 Seconds After Withdraw
    Navigate to AnyLogi Website                              browser=${browser}
    Sign Up Account
    Logout From Account
    Login To Account
    Loop To Make A Transaction And Verify Account Balance    action=withdraw       loop=5