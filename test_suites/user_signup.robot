*** Settings ***
Documentation    A test suite for user sign up an account.
...
...               Keywords are imported from the resource files
Resource          ../keywords/common.resource
Resource          ../keywords/user_signup.resource
Test Teardown     Close Browser
Suite Setup       Set Screenshot Directory              path=${EXECDIR}/signup_screenshots
Suite Teardown    Close All Browsers


*** Test Cases ***
Username Cannot Be Blank
    Navigate to AnyLogi Website           browser=${browser}
    Navigate To Sign Up Form
    Fill In Username                      username=${EMPTY}
    Verify Sign Up With Blank Username

Username Cannot Contain WhiteSpace
    Navigate to AnyLogi Website                   browser=${browser}
    Navigate To Sign Up Form
    Fill In Username                              username=abc 123
    Verify Sign Up Username Contain WhiteSpace

Password Cannot Be Less Than 8 Characters
    Navigate to AnyLogi Website    browser=${browser}
    Navigate To Sign Up Form
    Fill In Username               username=abc123            
    Fill In Password               password=321cba
    Verify Password Length         password=321cba

Password Cannot Be Larger Than 32 Characters
    Navigate to AnyLogi Website    browser=${browser}
    Navigate To Sign Up Form
    Fill In Username               username=abc123                               
    Fill In Password               password=abcdefghijklmnopqrstuvwxyz1234567
    Verify Password Length         password=abcdefghijklmnopqrstuvwxyz1234567

Password Must Contain Numbers
    Navigate to AnyLogi Website    browser=${browser}
    Navigate To Sign Up Form
    Fill In Username               username=abc123
    Fill In Password               password=abcdefghijklmnopqrstuvwxyz
    Verify Password Pattern        password=abcdefghIJKlmnopqrstuvwxyz

Password Must Contain Uppercase Letters
    Navigate to AnyLogi Website    browser=${browser}
    Navigate To Sign Up Form
    Fill In Username               username=abc123                            
    Fill In Password               password=abcdefghijklmnopqrstuvwxyz1234
    Verify Password Pattern        password=abcdefghijklmnopqrstuvwxyz1234