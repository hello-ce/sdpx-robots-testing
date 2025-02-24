*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    http://192.168.2.11:5000


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

Test Number One Returns False
    Create Session    prime_api    ${BASE_URL}
    ${response}=    GET On Session    prime_api    /is_prime/1
    Status Should Be    200    ${response}
    ${result}=    Set Variable    ${response.json()}[result]
    Should Not Be True    ${result}

Test Zero Returns False
    Create Session    prime_api    ${BASE_URL}
    ${response}=    GET On Session    prime_api    /is_prime/0
    Status Should Be    200    ${response}
    ${result}=    Set Variable    ${response.json()}[result]
    Should Not Be True    ${result}

Test Large Prime Number Returns True
    Create Session    prime_api    ${BASE_URL}
    ${response}=    GET On Session    prime_api    /is_prime/97
    Status Should Be    200    ${response}
    ${result}=    Set Variable    ${response.json()}[result]
    Should Be True    ${result}

Test Invalid Input Returns 400
    Create Session    prime_api    ${BASE_URL}
    ${response}=    GET On Session    prime_api    /is_prime/abc    expected_status=400
    Status Should Be    400    ${response}
    Dictionary Should Contain Value    ${response.json()}    Input must be a valid integer