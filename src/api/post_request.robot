** Settings **
Resource    ${CURDIR}${/}..\\..\\common\\global_file_path.robot
Resource    ..\\resources\\keywords\\api_register_keywords.robot
Suite Setup    Generate TestData For Registration

** Test Cases **
Customer Registers To Parabank
    #Potential Customer Fills Out The Registration Form
    Potential Customer Fills Out Prequalification "Step-1" Form With Valid Data