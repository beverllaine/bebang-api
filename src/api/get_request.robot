** Settings **
Resource    ${CURDIR}\\..\\..\\resources\\global_setup.robot

** Variables **
${base_url}           https://mirror.onboarding.firstcircle.ph


** Test Cases **
Get OB Step-1 Form
    create session    mysession    ${base_url}
    ${response} =    get on session    mysession    /pre-qualification-form/step-1
    log to console    ${response.status_code}
    log    ${response.status_code}
    log to console    ${response.content}
    log    ${response.content}
    log to console    ${response.headers}
    log    ${response.headers}

** Keywords **