*** Settings ***
Documentation    A test suite for user transactions.
...
...               Keywords are imported from the resource file
Resource          ../keywords/common.resource
Resource          ../keywords/user_signup.resource
Resource          ../keywords/user_transaction.resource
Test Teardown     Close Browser
Suite Setup       Set Screenshot Directory                        path=${EXECDIR}/transaction_screenshots
Suite Teardown    Close All Browsers

*** Test Cases ***
User Should Be Able To Deposit With Valid Amount
    Navigate to AnyLogi Website        browser=${browser}
    Sign Up Account
    Logout From Account
    Login To Account
    ${current_balance}=                Get Current Account Balance
    Navigate To Deposit Form
    Make A Valid Transaction Amount    action=deposit                 amount=1000    current_balance=${current_balance}

User Should Not Be Able To Deposit With Invalid Amount
    Navigate to AnyLogi Website           browser=${browser}
    Sign Up Account
    Logout From Account
    Login To Account
    Navigate To Deposit Form
    Make An Invalid Transaction Amount    action=deposit        amount=123abc

User Should Be Able To Withdraw With Valid Amount
    Navigate to AnyLogi Website        browser=${browser}
    Sign Up Account
    Logout From Account
    Login To Account
    ${current_balance}=                Get Current Account Balance
    Navigate To Withdraw Form
    Make A Valid Transaction Amount    action=withdraw                amount=1000    current_balance=${current_balance}

User Should Not Be Able To Withdraw With Invalid Amount
    Navigate to AnyLogi Website           browser=${browser}
    Sign Up Account
    Logout From Account
    Login To Account
    Navigate To Withdraw Form
    Make An Invalid Transaction Amount    action=withdraw       amount=123abc

User Should Not Be Able To Withdraw More Than Current Balance
    Navigate to AnyLogi Website           browser=${browser}
    Sign Up Account
    Logout From Account
    Login To Account
    ${withdarw_amount}=                   Simulate Withdraw Amount
    Navigate To Withdraw Form
    Make An Invalid Transaction Amount    action=withdraw             amount=${withdarw_amount}