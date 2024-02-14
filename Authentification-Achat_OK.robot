*** Settings ***
Library    SeleniumLibrary
Library    DatabaseLibrary
Library    OperatingSystem
Library    String
Library    sqlite3


# Library SQLess    ?

# Resource  ../Resources/Common.robot
# Test Setup  Common.Open test browser
# Test Teardown  Common.Close test browser

*** Variables ***
${BROWSER}   chrome
${SELSPEED}  0.0s
${USER}    stephane
${PASSWORD}    Stephane
${DB_TYPE}    SQLite
${DB_PATH}    C:/SB-TEMP/poec antibes/0 - Fil rouge/siteweb-ecommerce-for-testing/Market/e-commerce.db
${DB_FILE}    ../Market/e-commerce.db



*** Test Cases ***
robotframework-testing_selenium
    [Setup]  Run Keywords  Open Browser  http://127.0.0.1:5000/  ${BROWSER}
    ...              AND   Set Selenium Speed  ${SELSPEED}
    # open    http://127.0.0.1:5000/
    Maximize Browser Window
    Sleep     2s
    Capture Page Screenshot    screenshot1.png
    click    link=Login
    click    id=username
    type    id=username    ${USER}
    type    id=password    ${PASSWORD}
    click    id=submit
    Capture Page Screenshot    screenshot2.png

    [Documentation]    Vérifie que le message de connexion est affiché sur la page
    [Tags]    connexion
    Page Should Contain    Success! You are logged in as: ${USER}
    Element Should Be Visible    xpath=//*[@class='alert alert-success']

    Count Items in Catalog
    Achat User OK
    Sleep    2s
    Count Items in Cart After


    Sleep    2s
    click    link=Logout
    [Teardown]  Close Browser

# Connect to SQLite Database
#     Connect To Database    sqlite3    ../Market/e-commerce.db
#     ${result}    Query    SELECT COUNT(*) FROM user
#     Log    Nombre total d'utilisateurs dans la base de données : ${result}
#     Disconnect From Database


*** Keywords ***
Count Items in Catalog
    ${total_items}    Set Variable    0
    ${items_elements}    Get WebElements    xpath=//body/div[@class="row"]/div[@class="col-8"]/table/tbody/tr/td[1]

    FOR    ${element}    IN    @{items_elements}
       ${total_items}    Evaluate    ${total_items} + 1
    END
    [Documentation]    Vérifie le nombre item=${total_items}
    [Tags]    catalog item nb
 
    Log    Nombre total d'items dans le catalog: ${total_items}
    Should Be Equal As Numbers    ${total_items}    20
    
Achat User OK
    ${prix}=    Get Text    xpath=//tbody/tr[1]/td[3]
    Should Be Equal As Strings  ${prix}    3,000 $
    # ${prix}=    Set Variable    3,000
    ${prix}=    Replace String    ${prix}    ,    ${EMPTY}
    ${prix}=    Replace String    ${prix}    $    ${EMPTY}

    # ${prix} =    Replace String    ${prix}    ,    ${EMPTY}    # Remplacer la virgule par une chaîne vide
    # ${prix} =    Replace String    ${prix}    $    ${EMPTY}    # Remplacer le dollar par une chaîne vide
    ${prix}=    Convert To Number    ${prix}    # Convertir la chaîne en nombre

    ${credit_avant}=     Get Text    xpath=//body/nav/div/ul[@class='navbar-nav'][1]/li[@class='nav-item'][1]/a[@class='nav-link'][1]

    Should Be Equal As Strings   ${credit_avant}    10,000 $
    ${credit_avant}=    Replace String    ${credit_avant}    ,    ${EMPTY}
    ${credit_avant}=    Replace String    ${credit_avant}    $    ${EMPTY}
    ${credit_avant}=    Convert To Number    ${credit_avant}    # Convertir la chaîne en nombre


    click    xpath=(.//*[normalize-space(text()) and normalize-space(.)='Info'])[1]/following::button[1]
    Sleep    2s
    click    id=submit
    Sleep    2s
    ${credit_apres}=     Get Text    xpath=//body/nav/div/ul[@class='navbar-nav'][1]/li[@class='nav-item'][1]/a[@class='nav-link'][1]
    Should Be Equal As Strings   ${credit_apres}    7,000 $
    ${credit_apres}=    Replace String    ${credit_apres}    ,    ${EMPTY}
    ${credit_apres}=    Replace String    ${credit_apres}    $    ${EMPTY}
    ${credit_apres}=    Convert To Number    ${credit_apres}    # Convertir la chaîne en nombre

    ${resultat_attendu}=    Evaluate    ${credit_avant} - ${prix}
    Should Be Equal As Numbers    ${credit_apres}    ${resultat_attendu}




    #Should Be Equal As Numbers    ${credit_apres}    ${credit_avant} - ${prix}

 
 
    #Connect To Database   sqlite3:'C:/SB-TEMP/poec antibes/0 - Fil rouge/siteweb-ecommerce-for-testing/Market/e-commerce.db'
    # @{query_result}=    Query    SELECT * FROM your_table
    # Log    ${query_result}
    # Disconnect From Database

    # Connect To Database    sqlite:${DB Path}
    # ${result}    Query    SELECT COUNT(*) FROM item
    # Log    ${result}

Count Items in Cart After

    ${total_items_cart}    Set Variable    0
    # ${items_cart_elements}    Get WebElements    xpath=//body/div[@class="row"]/div[@class="col-8"]/table/tbody/tr/td[1]
    # ${items_cart_elements}    Get WebElements    xpath=//body/div[@class='col-4']/div[class='row']/div[class='col-md-6']/div/div/h5[@class='card-title'][1]
    ${items_cart_elements}    Get WebElements    xpath=//body/div[2]/div[2]/div[1]/div[2]/div[1]/div[1]/h5

    FOR    ${element_cart_apres}    IN    @{items_cart_elements}
        ${total_items_cart}    Evaluate    ${total_items_cart} + 1
    END
    [Documentation]    Vérifie le nombre item cart apres=${total_items_cart}
    [Tags]    catalog item cart apres nb
 
    Log    Nombre total d'items dans le cart apres: ${total_items_cart}
    Should Be Equal As Numbers    ${total_items_cart}    1
    ${cart_item}=    Get Text    xpath=//body/div[2]/div[2]/div[1]/div[2]/div[1]/div[1]/h5
    Should Be Equal As Strings  ${cart_item}    IPhone 15


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
