*** Settings ***
Documentation    This is a resource file, that can contain variables and keywords.
...              Keywords defined here can be used where this account_balance.resource in loaded.

Resource         user_transaction.resource


*** Keywords ***
Loop To Make A Transaction And Verify Account Balance
    [Arguments]                    ${action}=${EMPTY}    ${loop}=1
    FOR  ${i}  IN RANGE  ${loop}
        Make A Transaction             action=${action}             amount=1000
    END