*** Settings ***
Documentation    This is a resource file, that can contain variables and keywords.
...              Keywords defined here can be used where this user_transaction.resource in loaded.

*** Variables ***
${defined_fee_rate}    0.3

${deposit_key}         I8N.AFTER_TRANSACTION_FINAL_DEPOSIT_KEY       
${withdraw_key}        I8N.AFTER_TRANSACTION_FINAL_WITHDRAWAL_KEY

*** Keywords ***
Make A Transaction
    [Arguments]                                       ${action}=${EMPTY}                    ${amount}=0
    ${action}=                                        Verify Transaction Action             ${action}
    ${original_balance}=                              Get Text                              //tbody//tr[1]//td[@class="side-header" and text() = 'Balance']/following::td[1]
    IF                                                '${action}' == 'deposit'
    #Click deposit link - the element dose not has id or class attribute, we have to select it by index
    Click Link                                        (//a)[1]
    Wait Until Element Is Visible                     //span[text() = '${deposit_key}']
    ELSE IF                                           '${action}' == 'withdraw'
    #Click deposit link - the element dose not has id or class attribute, we have to select it by index
    Click Link                                        (//a)[2]
    Wait Until Element Is Visible                     //span[text() = '${withdraw_key}']
    END
    Wait Until Element Is Visible                     //input
    Input Text                                        //input                               ${amount}
    ${trans_fee}=                                     Verify And Return Transaction Fee     action=${action}                                                                    amount=${amount}          
    Confirm Transaction and Verify Account Balance    action=${action}                      amount=${amount}                                                                    trans_fee=${trans_fee}    original_balance=${original_balance}

Verify Transaction Action
    [Arguments]            ${action}=${EMPTY}
    Should Not Be Empty    ${action}
    ${action}=             Convert To Lower Case    ${action}
    [Return]               ${action}

Verify And Return Transaction Fee
    [Arguments]                  ${fee_rate}=${defined_fee_rate}                                                                     ${action}=${EMPTY}                           ${amount}=0
    ${action}=                   Verify Transaction Action                                                                           action=${action}
    ${trans_fee}=                Evaluate                                                                                            ${amount} * ${fee_rate}
    ${trans_fee_text}            Evaluate                                                                                            "{:.2f}".format(${trans_fee})
    IF                           '${action}' == 'deposit'
    Element Should Be Visible    //span[text()='${deposit_key}']/preceding::br[1]/preceding::span[1][text()='${trans_fee_text}']
    ELSE IF                      '${action}' == 'withdraw'
    Element Should Be Visible    //span[text()='${withdraw_key}']/preceding::br[1]/preceding::span[1][text()='${trans_fee_text}']
    END
    [Return]                     ${trans_fee} 

Verify Account Balance After Transaction Processed
    [Arguments]           ${action}=${EMPTY}           ${amount}=0                                                                         ${original_balance}=0
    ${action_text}=       Verify Transaction Action    ${action}
    IF                    '${action}' == 'deposit'
    ${new_balance}=       Evaluate                     "{:.2f}".format(${original_balance} + ${amount})
    ELSE IF               '${action}' == 'withdraw'
    ${new_balance}=       Evaluate                     "{:.2f}".format(${original_balance} - ${amount})
    END
    ${latest_balance}=    Get Text                     //tbody//tr[1]//td[@class="side-header" and text() = 'Balance']/following::td[1]
    Should Be Equal       ${new_balance}               ${latest_balance}

Verify Latest Transaction Record
    [Arguments]               ${action}=${EMPTY}                                                                                                ${trans_amount}=0
    IF                        '${action}' == 'deposit'
    ${trans_amount}=          Evaluate                                                                                                          "{:.2f}".format(${trans_amount})
    ELSE IF                   '${action}' == 'withdraw'
    ${trans_amount}=          Evaluate                                                                                                          "-{:.2f}".format(${trans_amount})
    END
    Element Text Should Be    //tbody//tr[2]//td[@class="side-header" and text() = 'Transactions']/following::td//table//tbody//tr[1]//td[2]    ${trans_amount}

Confirm Transaction and Verify Account Balance
    [Arguments]                                           ${action}=${EMPTY}                   ${amount}=0                     ${trans_fee}=0                          ${original_balance}=0
    ${action_text}=                                       Verify Transaction Action            ${action}
    ${action_text}=                                       Convert To Title Case    ${action}
    IF                                                    '${action}' == 'deposit'
    ${trans_amount}                                       Evaluate                             ${amount} - ${trans_fee}
    ELSE IF                                               '${action}' == 'withdraw'
    ${trans_amount}                                       Evaluate                             ${amount} + ${trans_fee}
    END
    Click Button                                          //button[text()='${action_text}']
    Sleep                                                 10s
    Verify Account Balance After Transaction Processed    action=${action}                     amount=${trans_amount}          original_balance=${original_balance}
    Verify Latest Transaction Record                      action=${action}                     trans_amount=${trans_amount}