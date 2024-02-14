*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${BROWSER}   chrome
${SELSPEED}  0.0s

*** Test Cases ***
robotframework-testing_selenium
    [Setup]  Run Keywords  Open Browser  http://127.0.0.1:5000/  ${BROWSER}
    ...              AND   Set Selenium Speed  ${SELSPEED}
    # open    http://127.0.0.1:5000/
    Maximize Browser Window
    click    link=Login
    click    id=username
    type    id=username    admin
    type    id=password    admin
    click    id=submit
    Sleep    2s
    Page Should Contain    Success! You are logged in as: admin
    click    link=Admin Panel
    Sleep    2s
    Page Should Contain    Welcome to Admin Panel
 
    Sleep    2s
    click    xpath=(.//*[normalize-space(text()) and normalize-space(.)='IPhone 15'])[1]/following::button[1]
    ${element_present}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//div[@class='alert alert-success']
    Run Keyword If    not ${element_present}    Log    Rien ne se passe après le clic

    Sleep    2s
    click    xpath=(.//*[normalize-space(text()) and normalize-space(.)='Update'])[1]/following::button[1]
    ${element_present}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//div[@class='alert alert-success']
    Run Keyword If    not ${element_present}    Log    Rien ne se passe après le clic

    Sleep    2s
    click    xpath=(.//*[normalize-space(text()) and normalize-space(.)='Empty'])[1]/following::button[1]
    ${element_present}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//div[@class='alert alert-success']
    Run Keyword If    not ${element_present}    Log    Rien ne se passe après le clic

    Sleep    2s
    click    link=Market
    Page Should Contain    Available Items
 
    click    xpath=(.//*[normalize-space(text()) and normalize-space(.)='IPhone 15'])[4]/following::button[1]
    Sleep    2s
    click    xpath=//div[@id='Info-1']/div/div/div[3]/button
    Sleep    2s
    click    xpath=(.//*[normalize-space(text()) and normalize-space(.)='Info'])[1]/following::button[1]
    Sleep    2s
    click    id=submit
    Page Should Contain    Unfortunately, you don't have enough money to purchase

    Sleep    2s
    click    link=Logout
    [Teardown]  Close Browser

*** Keywords ***
open
    [Arguments]    ${element}
    Go To          ${element}

clickAndWait
    [Arguments]    ${element}
    Click Element  ${element}

click
    [Arguments]    ${element}
    Click Element  ${element}

sendKeys
    [Arguments]    ${element}    ${value}
    Press Keys     ${element}    ${value}

submit
    [Arguments]    ${element}
    Submit Form    ${element}

type
    [Arguments]    ${element}    ${value}
    Input Text     ${element}    ${value}

selectAndWait
    [Arguments]        ${element}  ${value}
    Select From List   ${element}  ${value}

select
    [Arguments]        ${element}  ${value}
    Select From List   ${element}  ${value}

verifyValue
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

verifyText
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

verifyElementPresent
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

verifyVisible
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

verifyTitle
    [Arguments]                  ${title}
    Title Should Be              ${title}

verifyTable
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

assertConfirmation
    [Arguments]                  ${value}
    Alert Should Be Present      ${value}

assertText
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

assertValue
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

assertElementPresent
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

assertVisible
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

assertTitle
    [Arguments]                  ${title}
    Title Should Be              ${title}

assertTable
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

waitForText
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

waitForValue
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

waitForElementPresent
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

waitForVisible
    [Arguments]                  ${element}
    Page Should Contain Element  ${element}

waitForTitle
    [Arguments]                  ${title}
    Title Should Be              ${title}

waitForTable
    [Arguments]                  ${element}  ${value}
    Element Should Contain       ${element}  ${value}

doubleClick
    [Arguments]           ${element}
    Double Click Element  ${element}

doubleClickAndWait
    [Arguments]           ${element}
    Double Click Element  ${element}

goBack
    Go Back

goBackAndWait
    Go Back

runScript
    [Arguments]         ${code}
    Execute Javascript  ${code}

runScriptAndWait
    [Arguments]         ${code}
    Execute Javascript  ${code}

setSpeed
    [Arguments]           ${value}
    Set Selenium Timeout  ${value}

setSpeedAndWait
    [Arguments]           ${value}
    Set Selenium Timeout  ${value}

verifyAlert
    [Arguments]              ${value}
    Alert Should Be Present  ${value}
