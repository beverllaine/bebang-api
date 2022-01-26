** Settings **
Resource    ${CURDIR}${/}..\\..\\common\\global_file_path.robot
Resource    ${CURDIR}
Resource    ..\\resources\\keywords\\api_register_keywords.robot
Resource    ..\\resources\\variables\\testdata\\json\\*
#Suite Setup    Generate TestData For Registration

** Test Cases **
Customer Registers To Parabank
    log    e
    #Potential Customer Fills Out The Registration Form