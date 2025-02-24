*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}       http://192.168.2.11:5000/is_prime

*** Keywords ***
Test Is_Prime Endpoint
    [Arguments]    ${num1}    ${expected_status}
    ${response}=    GET    ${BASE_URL}/${num1}    expected_status=${expected_status}
    Run Keyword If    ${response.status_code} == ${expected_status}    Return From Keyword    ${response.json()}
    Fail    Unexpected status code: ${response.status_code}

*** Test Cases ***
Test Integer Addition
    ${json}=    Test Is_Prime Endpoint    17    200
    Should Be Equal    ${json}[result]    ${true}

Test Decimal Addition
    ${json}=    Test Is_Prime Endpoint    36    200
    Should Be Equal    ${json}[result]    ${false}

Test Negative Number
    ${json}=    Test Is_Prime Endpoint    13219    200
    Should Be Equal    ${json}[result]    ${true}

Test Charector
    ${json}=    Test Is_Prime Endpoint    abc    400

Test Empty String
    ${json}=    Test Is_Prime Endpoint    ""    400
    
