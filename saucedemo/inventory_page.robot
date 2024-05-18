*** Settings ***
Documentation    Test suite for saucedemo.com inventory page testing
Library          SeleniumLibrary
Test Setup       Login
Test Teardown    Close Browser

*** Variables ***
${BROWSER}        Chrome
${URL}            https://www.saucedemo.com/
${valid_username}    standard_user
${valid_password}    secret_sauce

*** Keywords ***
Login
    Open Browser    ${URL}    ${BROWSER}
    Input Text       //div//input[@placeholder='Username']       ${valid_username}
    Input Text       //div//input[@placeholder='Password']       ${valid_password}
    Click Button     //input[@type='submit']

*** Test Cases ***
Number Of Shopping Items
    [Documentation]    Number of shopping items on inventory page must be 6
    ${items_count}=    Get Element Count    //div[@class='inventory_item']
    Should Be Equal As Integers    ${items_count}    6
