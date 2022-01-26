** Settings **
Library    SeleniumLibrary
Suite Teardown    Close Browser
** Settings **
Resource   ..\\..\\resources\\common\\keywords\\login_keywords.robot


** Test Cases **
Customer Fills Out OB Step-1
    Given Customer Access To Onboarding Form
    #When Customer Fills Out Step-1 Form With Valid Data
    #Then Data Is Saved To Database