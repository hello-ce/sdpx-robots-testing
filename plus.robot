*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}       http://localhost:5000/plus

*** Keywords ***
Test Plus Endpoint
    [Arguments]    ${num1}    ${num2}    ${expected_status}
    ${response}=    GET    ${BASE_URL}/${num1}/${num2}    expected_status=${expected_status}
    Run Keyword If    ${response.status_code} == ${expected_status}    Return From Keyword    ${response.json()}
    Fail    Unexpected status code: ${response.status_code}

*** Test Cases ***
Test Integer Addition
    ${json}=    Test Plus Endpoint    3    5    200
    Should Be Equal    ${json}[result]    ${8}

Test Floating Point Addition
    ${json}=    Test Plus Endpoint    3.5    2.5    200
    Should Be Equal    ${json}[result]    ${6.0}

Test Integer Result From Float Addition
    ${json}=    Test Plus Endpoint    2.5    2.5    200
    Should Be Equal    ${json}[result]    ${5}

Test Negative Numbers
    ${json}=    Test Plus Endpoint    -3    -7    200
    Should Be Equal    ${json}[result]    ${-10}

Test Mixed Positive And Negative
    ${json}=    Test Plus Endpoint    -3    5    200
    Should Be Equal    ${json}[result]    ${2}

Test Zero Values
    ${json}=    Test Plus Endpoint    0    0    200
    Should Be Equal    ${json}[result]    ${0}

Test Invalid First Number
    ${json}=    Test Plus Endpoint    abc    5    400
    Should Be Equal    ${json}[error_msg]    Inputs must be valid numbers

Test Invalid Second Number
    ${json}=    Test Plus Endpoint    5    xyz    400
    Should Be Equal    ${json}[error_msg]    Inputs must be valid numbers

Test Both Invalid Numbers
    ${json}=    Test Plus Endpoint    abc    xyz    400
    Should Be Equal    ${json}[error_msg]    Inputs must be valid numbers

Test Special Characters
    ${json}=    Test Plus Endpoint    @    ()    400
    Should Be Equal    ${json}[error_msg]    Inputs must be valid numbers
