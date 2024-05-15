*** Settings ***
Documentation    Test suite for saucedemo.com login page testing
Library          SeleniumLibrary
Test Setup    Open Browser    ${URL}    ${BROWSER}
Test Teardown    Close Browser

*** Variables ***
${BROWSER}        Chrome
${URL}            https://www.saucedemo.com/
${url_after_login}    https://www.saucedemo.com/inventory.html
${valid_username}    standard_user
${valid_password}    secret_sauce
${invalid_username}    invalid_user
${invalid_password}    blabla
${login_error_message}    Epic sadface: Username and password do not match any user in this service


*** Test Cases ***
Open Login Page
    [Documentation]    Login Page Validation
    [Tags]            Positive
    Title Should Be    Swag Labs
    Page Should Contain Element    //div//input[@placeholder='Username']
    Page Should Contain Element    //div//input[@placeholder='Password']
    Page Should Contain Button    //input[@type='submit']

Login Positive
    [Documentation]    Login with valid username and password
    [Tags]            Positive
    Input Text       //div//input[@placeholder='Username']       ${valid_username}
    Input Text       //div//input[@placeholder='Password']       ${valid_password}
    Click Button     //input[@type='submit']
    ${current_url}=    Get Location
    Title Should Be    Swag Labs
    Should Be Equal As Strings    ${current_url}    ${url_after_login}

Login With Incorrect Credentials
    [Documentation]    Login with incorrect username and password
    [Tags]            Negative
    Input Text       //div//input[@placeholder='Username']       ${invalid_username}
    Input Text       //div//input[@placeholder='Password']       ${invalid_password}
    Click Button     //input[@type='submit']
    Wait Until Page Contains Element    //div[@class='error-message-container error']
    Capture Page Screenshot    login_error_message.png
    Wait Until Page Contains    Epic sadface: Username and password do not match any user in this service
