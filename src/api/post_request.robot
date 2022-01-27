** Settings **
Resource    ${CURDIR}${/}..\\..\\common\\global_file_path.robot
Resource    ..\\resources\\keywords\\api_register_keywords.robot
Suite Setup    Generate TestData For Registration

** Test Cases **
#Customer Registers To Parabank
    #Potential Customer Fills Out The Registration Form
    #Jsessionid needs update

Customer Fills Out Onboarding Form - Step 1
    When Potential Customer Fills Out Prequalification "Step-1" Form With Valid Data
    Then New Record With Prequalification "Step-1" Details Should Be Saved

Customer Fills Out Onboarding Form - Step 2
    [Setup]    sleep    3s
    When Potential Customer Fills Out Prequalification "Step-2" Form With Valid Data
    Then Onboarding Prequalification Details Should Be Saved

Customer Fills Out Onboarding Form - Step 3
    [Setup]    sleep    3s
    When Potential Customer Fills Out Prequalification "Step-3" Form With Valid Data
    Then Onboarding Prequalification Details Should Be Saved

Customer Fills Out Onboarding Form - Step 4
    [Setup]    sleep    3s
    When Potential Customer Fills Out Prequalification "Step-4" Form With Valid Data
    Then Onboarding Prequalification Details Should Be Saved

Customer Fills Out Onboarding Form - Step 5
    [Setup]    sleep    3s
    When Potential Customer Fills Out Prequalification "Step-5" Form With Valid Data
    Then Onboarding Prequalification Details Should Be Saved

Customer Fills Out Onboarding Form - Step 6
    [Setup]    sleep    3s
    When Potential Customer Fills Out Prequalification "Step-6" Form With Valid Data
    Then Onboarding Prequalification Details Should Be Saved