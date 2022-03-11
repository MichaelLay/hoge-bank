*** Settings ***
Documentation    This is a resource file, that can contain variables and keywords.
...              Keywords defined here can be used where this user_signup.resource in loaded.

*** Variables ***
${password_pattern_number}       [0-9]
${password_pattern_uppercase}    [A-Z]

${fee_rate}    0.3

${deposit_key}     I8N.AFTER_TRANSACTION_FINAL_DEPOSIT_KEY       
${withdraw_key}    I8N.AFTER_TRANSACTION_FINAL_WITHDRAWAL_KEY

*** Keywords ***
Sign Up Account
    Navigate To Sign Up Form
    Fill In Username                 username=${predefined_username}
    Fill In Password                 password=${predefined_password}
    Click Button                     //button[text()='SIGNUP']
    Wait Until Element Is Visible    //th[text()='${predefined_username}']

Navigate To Sign Up Form
    Click Button    //button[text()='SIGNUP']

Fill In Username
    [Arguments]    ${username}=${EMPTY}
    Input Text     (//input)[1]            ${username}

Fill In Password
    [Arguments]    ${password}=${EMPTY}
    Input Text     //input[@type='password']    ${password}

Verify Sign Up With Blank Username
    Click Button                 //button[text()='SIGNUP']
    Element Should Be Visible    //span[text()='User name cannot be blank']

Verify Sign Up Username Contain WhiteSpace
    Click Button                 //button[text()='SIGNUP']
    Element Should Be Visible    //span[text()='User name cannot contain whitespaces']

Verify Password Length
    [Arguments]                  ${password}=${EMPTY}
    ${password_length}=          Get Length                                                       ${password}
    Click Button                 //button[text()='SIGNUP']
    IF                           ${password_length} < 8
    Element Should Be Visible    //span[text()='Password cannot be less than 8 characters']
    ELSE IF                      ${password_length} > 32
    Element Should Be Visible    //span[text()='Password cannot be longer than 32 characters']
    END

Verify Password Pattern
    [Arguments]                     ${password}=${EMPTY}
    Verify Password Length          password=${password}
    ${contain_number}=              Run Keyword And Return Status                               Should Match Regexp    string=${password}    pattern=${password_pattern_number}
    IF                              not ${contain_number}
    Element Should Be Visible       //span[text()='Password must contain numbers']
    END
    ${contain_uppercase_letter}=    Run Keyword And Return Status                               Should Match Regexp    string=${password}    pattern=${password_pattern_uppercase}
    IF                              not ${contain_uppercase_letter}
    Element Should Be Visible       //span[text()='Password must contain uppercase letters']
    END


