** Settings **
Resource    ..\\variables\\variables.robot

** Keywords **
Customer Access To Onboarding Form
    open browser    ${URL}    ${BROWSER}
    wait until location contains    ${url_ext_step1}
    wait until element is visible    ${contact_information_form}

Customer Fills Out Step-1 Form With Valid Data

Data Is Saved To Database