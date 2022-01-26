** Settings **
#Resource    ${CURDIR}\\..\\..\\global_setup.robot
#Resource    ${CURDIR}\\..\\resource\\keywords\\api_register_keywords.robot
#Resource    ${CURDIR}\\..\\..\\common\\variables\\testdata\\json\\

** Keywords **
Get SignUp Test Data
    ${first_name} =   FakerLibrary.First Name
    ${last_name} =   FakerLibrary.Last Name
    ${address_street} =   FakerLibrary.Address
    ${address_city} =   FakerLibrary.City
    ${zip_code} =   FakerLibrary.Postalcode
    ${phone_number} =   FakerLibrary.Phone Number
    ${ssn} =   FakerLibrary.Random Int    
    ${user_name} =   FakerLibrary.User Name
    ${password} =   FakerLibrary.Password    length=8
    ${repeat_password} =   set variable    ${password}
    [Return]     ${first_name}    ${last_name}     ${address_street}    ${address_city}    ${zip_code}    ${phone_number}    ${ssn}    ${user_name}    ${password}    ${repeat_password}

Generate TestData For Registration
    ${first_name}    ${last_name}     ${address_street}    ${address_city}    ${zip_code}    ${phone_number}    ${ssn}    ${user_name}    ${password}    ${repeat_password} =    Get SignUp Test Data
    set global variable    ${g_FIRST_NAME}    ${first_name}
    set global variable    ${g_LAST_NAME}    ${last_name}
    set global variable    ${g_ADDRESS}    ${address_street}
    set global variable    ${g_ADDRESS_CITY}    ${address_city}
    set global variable    ${g_ZIP_CODE}    ${zip_code}
    set global variable    ${g_PHONE_NUMBER}    ${phone_number}
    set global variable    ${g_SSN}    ${ssn}
    set global variable    ${g_USER_NAME}    ${user_name}
    set global variable    ${g_PASSWORD}    ${password}
    set global variable    ${g_REPEAT_PASSWORD}    ${repeat_password}

Potential Customer Fills Out The Registration Form
    ${json_file} =    load json from file   
    ${json_file} =    update value to json    ${json_file}    ${g_FIRST_NAME}
    ${json_file} =    update value to json    ${json_file}    ${g_LAST_NAME}
    ${json_file} =    update value to json    ${json_file}    ${g_ADDRESS}
    ${json_file} =    update value to json    ${json_file}    ${g_ADDRESS_CITY}
    ${json_file} =    update value to json    ${json_file}    ${g_ZIP_CODE}
    ${json_file} =    update value to json    ${json_file}    ${g_PHONE_NUMBER}
    ${json_file} =    update value to json    ${json_file}    ${g_SSN}
    ${json_file} =    update value to json    ${json_file}    ${g_USER_NAME}
    ${json_file} =    update value to json    ${json_file}    ${g_PASSWORD}
    ${json_file} =    update value to json    ${json_file}    ${g_REPEAT_PASSWORD}
    set headers   {"Cookie: ${parabank_cookie}"}
    POST    https://parabank.parasoft.com/parabank/register.htm    ${json_file}
    ${response}    Output
    log    ${response.status_code}
