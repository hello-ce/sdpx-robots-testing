*** Settings ***
Library           RequestsLibrary

*** Variables ***

${BASE_URL}       http://192.168.2.11:5000/cir_sur

*** Keywords ***
Test Is_Prime Endpoint
    [Arguments]    ${num1}    ${expected_status}
    ${response}=    GET    ${BASE_URL}/${num1}    expected_status=${expected_status}
    Run Keyword If    ${response.status_code} == ${expected_status}    Return From Keyword    ${response.json()}
    Fail    Unexpected status code: ${response.status_code}

*** Test Cases ***
Test Integer Addition
    ${json}=    Test Is_Prime Endpoint    1    200
    Should Be Equal    ${json}[result]    ${12.56}

Test Decimal Addition
    ${json}=    Test Is_Prime Endpoint    -10    200
    Should Be Equal    ${json}[result]    ${0}

Test Negative Number
    ${json}=    Test Is_Prime Endpoint    1.5    200
    Should Be Equal    ${json}[result]    ${28.26}
