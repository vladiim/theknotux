SUPPLIER_DEFINITIONS = """

addDetails=>condition: Add details
addListingComms=>inputoutput: Add listing email communication
addListingForm=>inputoutput: #UJ Add Listing Form
chooseFreeMonth=>condition: Choose free month
choosePaidPackage=>condition: Choose paid package
clickAddListing=>condition: Click add listing?
clickAdvertiseInNav=>condition: Click 'advertise' in nav
clickAskQuestion=>condition: Click ask question?
clickEditField=>condition: Click edit field?
clickEnquire=>condition: Click 'enquire'
clickListing=>condition: Click listing?
clickManageAccountDetails=>condition: Click manage account details?
clickMessages=>condition: Click messages?
clickSkipOnboarding=>condition: Click skip onboarding
clickViewCaseStudy=>condition: Click view case study
clickViewListings=>condition: Click view listings?
clickViewSimilarCaseStudy=>condition: Click view similar case study
completedListingFormField=>condition: Completed listing form field?
continueEditing=>subroutine: Continue editing
createCustomerForm=>inputoutput: #UJ Create Customer Form
createNewListing=>inputoutput: Create new listing
createNewMessage=>inputoutput: #UJ Create New Message
e=>end:>
e2=>end:>
editFieldForm=>inputoutput: Dynamic edit field form
enquiryForm=>inputoutput: #UJ Enquiry Form
enquiryFormSubmitted=>inputoutput: #UJ Enquiry Form Submitted
enquireWithLinkedIn=>condition: Enquire with LinkedIn
errorMessage=>end: Error message
deleteListing=>condition: Delete listing
deleteListingConfirmation=>condition: Delete listing confirmation
fillInMessageBody=>operation: Fill in message body
fillsInForm=>condition: Fills in form
firstListing=>condition: First listing?
firstLogin=>condition: First log in?
formValid=>condition: Form valid?
freeMonthTrial=>inputoutput: #UJ Free Month Trial
hasLinkedInAccount=>condition: Has LinkedIn account
helpOnboarding=>inputoutput: #UJ Supplier Help Onboarding
leadAddedToCRM=>operation: Lead added to CRM
leadConverted=>condition: Lead converted to customer
linkedInAuthSucceeds=>condition: LinkedIn auth succeeds
listingAdded=>condition: Listing added
listingDeleteMessage=>inputoutput: Listing deleted message (account updated)
listingFormCompleted=>condition: Listing form completed?
listingOptimised=>operation: Listing optimised for lead
manageAccountDetails=>inputoutput: #UJ Manage Account Details
onboardingViewed=>inputoutput: Onboarding content viewed
paymentDetailsProcessed=>inputoutput: Payment details processed
salesTeamResponds=>inputoutput: Sales team responds to message
submitMessage=>inputoutput: Submit message
todo=>operation: TODO
trialEnded=>condition: Trial ended
trialEndedComms=>inputoutput: Trial ended communication
viewAdSalesPage=>operation: View ad sales page
viewCaseStudy=>inputoutput: #UJ View Case Study
viewListing=>inputoutput: #UJ View Listing
viewListings=>inputoutput: #UJ View Listings
viewMessages=>inputoutput: #UJ View Messages
viewOnBoarding=>condition: View all onboarding tips
viewProfile=>inputoutput: #UJ View Profile
"""

SUPPLIER_UJS = [
  { title: "Interested in Advertising",
    logic: """
st=>start: GET /home:>
#{ SUPPLIER_DEFINITIONS }

st->clickAdvertiseInNav
clickAdvertiseInNav(yes, right)->viewAdSalesPage->clickEnquire
clickAdvertiseInNav(no)->e
clickEnquire(yes, right)->enquiryForm
clickEnquire(no)->clickViewCaseStudy
clickViewCaseStudy(yes, right)->viewCaseStudy
clickViewCaseStudy(no)->e2
    """
  },
  { title: "Enquiry Form",
    logic: """
st=>start: GET /ad-enquiry:>
#{ SUPPLIER_DEFINITIONS }

st->hasLinkedInAccount
hasLinkedInAccount(yes, right)->enquireWithLinkedIn
hasLinkedInAccount(no)->fillsInForm
enquireWithLinkedIn(yes, right)->linkedInAuthSucceeds
enquireWithLinkedIn(no)->fillsInForm
fillsInForm(yes, right)->formValid
fillsInForm(no)->e
linkedInAuthSucceeds(yes, right)->enquiryFormSubmitted
linkedInAuthSucceeds(no)->errorMessage
formValid(yes, right)->enquiryFormSubmitted
formValid(no)->errorMessage
    """
  },
  { title: "View Case Study",
    logic: """
st=>start: GET /case-studies/#:>
#{ SUPPLIER_DEFINITIONS }

st->clickEnquire
clickEnquire(yes, right)->enquiryForm
clickEnquire(no)->clickViewSimilarCaseStudy
clickViewSimilarCaseStudy(yes, right)->viewCaseStudy
clickViewSimilarCaseStudy(no)->e
    """
  },
  { title: "Enquiry Form Submitted",
    logic: """
st=>start: POST /ad-enquiry:>
#{ SUPPLIER_DEFINITIONS }

st->leadAddedToCRM->leadConverted
leadConverted(yes, right)->createCustomerForm
leadConverted(no)->e
    """
  },
  { title: "Create Customer Form",
    logic: """
st=>start: POST /customer/#:>
#{ SUPPLIER_DEFINITIONS }

st->addDetails
addDetails(yes, right)->formValid
addDetails(no)->e
formValid(yes, right)->chooseFreeMonth
formValid(no)->addDetails
chooseFreeMonth(yes, right)->freeMonthTrial
chooseFreeMonth(no)->choosePaidPackage
choosePaidPackage(yes, right)->paymentDetailsProcessed
choosePaidPackage(no)->e2
    """
  },
  { title: "Free Month Trial",
    logic: """
st=>start: Free month trial:>
#{ SUPPLIER_DEFINITIONS }

st->listingAdded
listingAdded(yes, right)->listingOptimised
listingAdded(no)->addListingComms->trialEnded
trialEnded(yes, right)->trialEndedComms
    """
  },
  { title: "View Profile",
    logic: """
st=>start: GET /home:>
#{ SUPPLIER_DEFINITIONS }

st->firstLogin
firstLogin(yes, right)->helpOnboarding
firstLogin(no)->clickMessages
clickMessages(yes, right)->viewMessages
clickMessages(no)->clickAskQuestion
clickAskQuestion(yes, right)->createNewMessage
clickAskQuestion(no)->clickViewListings
clickViewListings(yes, right)->viewListings
clickViewListings(no)->clickAddListing
clickAddListing(yes, right)->addListingForm
clickAddListing(no)->clickManageAccountDetails
clickManageAccountDetails(yes, right)->manageAccountDetails
clickManageAccountDetails(no)->e
    """
  },
  { title: "Supplier Help Onboarding",
    logic: """
st=>start: Onboarding overlay:>
#{ SUPPLIER_DEFINITIONS }

st->viewOnBoarding
viewOnBoarding(yes, right)->onboardingViewed
viewOnBoarding(no)->clickSkipOnboarding
clickSkipOnboarding(yes, right)->viewProfile
clickSkipOnboarding(no)->e
    """
  },
  { title: "View Listings",
    logic: """
st=>start: GET /listings:>
#{ SUPPLIER_DEFINITIONS }

st->clickListing
clickListing(yes, right)->viewListing
clickListing(no)->clickAddListing
clickAddListing(yes, right)->addListingForm
clickAddListing(no)->e
    """
  },
  { title: "View Listing",
    logic: """
st=>start: GET /listings/#:>
#{ SUPPLIER_DEFINITIONS }

st->clickEditField
clickEditField(yes, right)->deleteListing
deleteListing(yes, right)->deleteListingConfirmation
deleteListing(no)->editFieldForm
deleteListingConfirmation(yes, right)->listingDeleteMessage
deleteListingConfirmation(no)->clickEditField
clickEditField(no)->e
    """
  },
  { title: "Create New Message",
    logic: """
st=>start: POST /messages/#:>
#{ SUPPLIER_DEFINITIONS }

st->fillInMessageBody->submitMessage->salesTeamResponds
    """
  },
  { title: "Create Listing",
    logic: """
st=>start: POST /listings/#:>
#{ SUPPLIER_DEFINITIONS }

st->firstListing
firstListing(yes, right)->onboardingViewed
firstListing(no)->continueEditing
continueEditing->completedListingFormField
completedListingFormField(yes, right)->formValid
completedListingFormField(no)->continueEditing
formValid(yes)->listingFormCompleted
listingFormCompleted(yes, right)->createNewListing
listingFormCompleted(no)->e
    """
  },
  { title: "Manage Account Details",
    logic: """
st=>start: GET /account:>
#{ SUPPLIER_DEFINITIONS }

changeMonthlyPackage=>condition: Change monthly package
monthlyPakackageChangedMessage=>inputoutput: Monthly package changed message

st->changeMonthlyPackage
changeMonthlyPackage(yes, right)->monthlyPakackageChangedMessage
changeMonthlyPackage(no)->e
    """
  }
]