*** Settings ***
Documentation    This is a resource file, that can contain variables and keywords.
...              Keywords defined here can be used where this user_account_balance.resource in loaded.

Resource    user_transaction.resource


*** Keywords ***
Loop To Make A Transaction And Verify Account Balance
    [Arguments]                            ${action}=${EMPTY}           ${current_balance}=0    ${loop}=1
    ${action}=                             Verify Transaction Action                            action=${action}
    FOR   ${i}  IN RANGE  ${loop}
        Run Keyword If  '${action}' == 'deposit'   Navigate To Deposit Form
        Run Keyword If  '${action}' == 'withdraw'  Navigate To Withdraw Form
        Make A Valid Transaction Amount    action=${action}      amount=1000      current_balance=${current_balance}
        ${current_balance}=    Get Current Account Balance
    END