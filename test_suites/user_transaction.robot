*** Settings ***
Documentation    A test suite for user transactions.
...
...               Keywords are imported from the resource file
Resource          ../keywords/common.resource
Resource          ../keywords/user_signup.resource
Resource          ../keywords/user_transaction.resource
Test Teardown     Close Browser
Suite Setup       Set Screenshot Directory                     path=${EXECDIR}/transaction_screenshots
Suite Teardown    Close All Browsers

*** Test Cases ***
User Should Be Able To Deposit Money
    Navigate to AnyLogi Website    browser=${browser}
    Sign Up Account
    Logout From Account
    Login To Account
    Make A Transaction             action=deposit             amount=1000

User Should Be Able To Withdraw Money
    Navigate to AnyLogi Website    browser=${browser}
    Sign Up Account
    Logout From Account
    Login To Account
    Make A Transaction             action=withdraw            amount=1000
