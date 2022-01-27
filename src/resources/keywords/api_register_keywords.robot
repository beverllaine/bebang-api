** Settings **
Resource     common\\global_setup.robot


** Variables **
${JSON_PATH_FILE}        common\\variables\\testdata\\json\\
${parabank_cookie}       5A0D696F425F48E43D306739B6FE5B1E
${fc_onboarding_cookie}  2daf3d77da505ad879e3f67fe69560ca8695e16c3ef394aeb43fc34251d2f9a5443c570781b92944cd111b6f17aa36bef81063a6eaa3039a62bb276446a54c4e   
${ENV_ONBOARDING_API}    mirror

** Keywords **
#============================
#         WHEN
#============================
Potential Customer Fills Out The Registration Form
    ${json_file} =    load json from file     ${JSON_PATH_FILE}api_register.json
    ${json_file} =    update value to json    ${json_file}    $.customer.firstName        ${g_FIRST_NAME}
    ${json_file} =    update value to json    ${json_file}    $.customer.lastName        ${g_LAST_NAME}
    ${json_file} =    update value to json    ${json_file}    $.customer.address.street        ${g_ADDRESS}
    ${json_file} =    update value to json    ${json_file}    $.customer.address.city        ${g_ADDRESS_CITY}
    ${json_file} =    update value to json    ${json_file}    $.customer.address.state        ${g_ADDRESS_STATE}
    ${json_file} =    update value to json    ${json_file}    $.customer.address.zipCode       ${g_ZIP_CODE}
    ${json_file} =    update value to json    ${json_file}    $.customer.address.phoneNumber        ${g_PHONE_NUMBER}
    ${json_file} =    update value to json    ${json_file}    $.customer.ssn        ${g_SSN}
    ${json_file} =    update value to json    ${json_file}    $.customer.username        ${g_USER_NAME}
    ${json_file} =    update value to json    ${json_file}    $.customer.password        ${g_PASSWORD}
    ${json_file} =    update value to json    ${json_file}    $.repeatedPassword        ${g_REPEAT_PASSWORD}
    SET HEADERS    {"Cookie":"JSESSIONID=${parabank_cookie}"}
    POST    https://parabank.parasoft.com/parabank/register.htm    ${json_file}
    ${response}    Output
    Integer    response status    200

Potential Customer Fills Out Prequalification "Step-1" Form With Valid Data
    ${json_file} =    load json from file    ${JSON_PATH_FILE}api_onboarding_qualification_step_1.json
    ${json_file} =    update value to json    ${json_file}    $.first_name    ${g_FIRST_NAME}
    ${json_file} =    update value to json    ${json_file}    $.mobile_number   ${g_PHONE_NUMBER}
    ${json_file} =    update value to json    ${json_file}    $.email_address   "email@f.com"
    ${json_file} =    update value to json    ${json_file}    $.token    ${fc_onboarding_cookie}
    SET HEADERS    {"Referer": "https://${ENV_ONBOARDING_API}.onboarding.firstcircle.ph/"}
    POST    https://${ENV_ONBOARDING_API}.api.onboarding.firstcircle.ph/leads    ${json_file}
    ${response}    Output
    Get Onboarding ID From Step 1 Response

Potential Customer Fills Out Prequalification "Step-2" Form With Valid Data
    ${json_file} =    load json from file    ${JSON_PATH_FILE}api_onboarding_qualification_step_2.json
    ${json_file} =    update value to json    ${json_file}    $.token    ${fc_onboarding_cookie}
    SET HEADERS    {"Referer": "https://${ENV_ONBOARDING_API}.onboarding.firstcircle.ph/"}
    PATCH    https://${ENV_ONBOARDING_API}.api.onboarding.firstcircle.ph/leads/${g_ONBOARDING_API_ID}   ${json_file}
    ${response}    Output
    Integer    response status    200

#============================
#         THEN
#============================
New Record With Prequalification "Step-1" Details Should Be Saved
    Integer    response status    201
    ${expect_response_1} =    Expect Response    ${JSON_PATH_FILE}api_onboarding_qualification_default.json
    ${expect_response_2} =    Expect Response    {"seconds":{"maximum":".001"}}
    log    ${expect_response_1}
    log    ${expect_response_2}
    ${clear_ec} =    clear expectations

Onboarding Prequalification Details Should Be Saved
    Integer   response status    200
    ${expect_response_1} =    Expect Response    ${JSON_PATH_FILE}api_onboarding_qualification_default.json
    ${expect_response_2} =    Expect Response    {"seconds":{"maximum":".001"}}
    log    ${expect_response_1}
    log    ${expect_response_2}
    ${clear_ec} =    clear expectations

#============================
#         INTERNAL KEYWORDS
#============================
Get SignUp Test Data
    ${first_name} =   FakerLibrary.First Name
    ${last_name} =   FakerLibrary.Last Name
    ${address_street} =   FakerLibrary.Address
    ${address_city} =   FakerLibrary.City
    ${address_state} =   FakerLibrary.Postalcode
    ${zip_code} =   FakerLibrary.Postalcode
    ${phone_number} =   FakerLibrary.Postalcode
    ${ssn} =   FakerLibrary.Random Int    
    ${user_name} =   FakerLibrary.User Name
    ${password} =   FakerLibrary.Password    length=8
    ${repeat_password} =   set variable    ${password}
    [Return]     ${first_name}    ${last_name}     ${address_street}    ${address_city}    ${address_state}    ${zip_code}    ${phone_number}    ${ssn}    ${user_name}    ${password}    ${repeat_password}

Generate TestData For Registration
    ${first_name}    ${last_name}     ${address_street}    ${address_city}    ${address_state}    ${zip_code}    ${phone_number}    ${ssn}    ${user_name}    ${password}    ${repeat_password} =    Get SignUp Test Data
    set global variable    ${g_FIRST_NAME}    ${first_name}
    set global variable    ${g_LAST_NAME}    ${last_name}
    set global variable    ${g_ADDRESS}    ${address_street}
    set global variable    ${g_ADDRESS_CITY}    ${address_city}
    set global variable    ${g_ADDRESS_STATE}    ${address_state}
    set global variable    ${g_ZIP_CODE}    ${zip_code}
    set global variable    ${g_PHONE_NUMBER}    ${phone_number}
    set global variable    ${g_SSN}    ${ssn}
    set global variable    ${g_USER_NAME}    ${user_name}
    set global variable    ${g_PASSWORD}    ${password}
    set global variable    ${g_REPEAT_PASSWORD}    ${repeat_password}

Get Onboarding ID From Step 1 Response
    ${onboarding_api_id} =    Output    $.data.id
    set global variable    ${g_ONBOARDING_API_ID}    ${onboarding_api_id}
