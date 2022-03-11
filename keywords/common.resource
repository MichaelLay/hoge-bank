*** Settings ***
Documentation    This is a resource file, that can contain variables and keywords.
...              Keywords defined here can be used where this common.resource in loaded.

Library    SeleniumLibrary
Library    String


*** Variables ***
${base_url}          https://anylogi-recruitment.web.app
${browser_width}     1280
${browser_height}    720

#For valid sigup and login
${predefined_username}    anylogi-robot
${predefined_password}    tobor1g0Lyna

*** Keywords ***
Navigate to AnyLogi Website
    [Arguments]                      ${browser}
    Open Browser                     url=${base_url}                browser=${browser}
    Set Window Size                  width=${browser_width}         height=${browser_height}
    Wait Until Element Is Visible    //h1[text() = 'Hoge Bank']
    Wait Until Element Is Visible    //input
    Wait Until Element Is Visible    //button[text() = 'SIGNUP']
    Wait Until Element Is Visible    //button[text() = 'LOGIN']

Login To Account
    [Arguments]                      ${username}=${predefined_username}                     ${password}=${predefined_password}
    Input Text                       (//input)[1]                             ${username}
    Input Text                       //input[@type='password']                ${password}
    Click Button                     //button[text()='LOGIN']
    Wait Until Element Is Visible    //th[text()='${predefined_username}']

Logout From Account
    Click Button                     //button[text()='Logout']
    Wait Until Element Is Visible    //button[text()='LOGIN']