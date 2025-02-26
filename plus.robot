*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    http://192.168.2.13:5000


*** Test Cases ***
Test Prime Number Returns True
    Create Session    prime_api    ${BASE_URL}
    ${response}=    GET On Session    prime_api    /is_prime/7
    Status Should Be    200    ${response}
    ${result}=    Set Variable    ${response.json()}[result]
    Should Be True    ${result}

Test Non-Prime Number Returns False
    Create Session    prime_api    ${BASE_URL}
    ${response}=    GET On Session    prime_api    /is_prime/4
    Status Should Be    200    ${response}
    ${result}=    Set Variable    ${response.json()}[result]
    Should Not Be True    ${result}