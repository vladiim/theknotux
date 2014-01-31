VISITOR_DEFINITIONS = """
acceptInvite=>condition: Accept invite
addComment=>condition: Add comment
addLink=>condition: Add link to Look Book
addFriendsEmail=>condition: Manually add friend's email
addsToLookBook=>condition: Adds to Look Book
addedToXLookBooks=>condition: Added to (X) Look Books
alreadyAUser=>condition: Already a user
askFriendsToComment=>condition: Ask friends to comment
changePasswordEmailSent=>inputoutput: Change password email sent
checkItem=>condition: Check item as done
clickedLookBook=>condition: Clicked 'Look Book'?
clickAddToSeatingPlan=>condition: Click 'add to seating plan'?
clickInviteGuests=>condition: Click 'invite guests'?
clickManageMyGuests=>condition: Clicked 'manage my guests'?
clickManageMyToDoList=>condition: Clicked 'manage my todo list'?
clickMyWebSite=>condition: Clicks 'my website'
clicksContentItem=>condition: Clicks content item
clicksContentCategory=>condition: Clicks content category
clicksContent=>condition: Clicks content
clickForgotDetails=>condition: Click forgot details
clicksImage=>condition: Clicks image
clicksInspNav=>condition: Clicks inspiration nav
clickSignUp=>condition: Click sign up
clicksVote=>condition: Click vote
clickViewInvites=>condition: Click 'view invites'?
contactsSupplier=>condition: Contacts supplier
commentAccepted=>inputoutput: Comment accepted
copyLookBook=>condition: Copy Look Book
correctTodoItem=>condition: Correct todo item
detailsEditor=>inputoutput: #UJ Details editor
detailsEdited=>inputoutput: Details edited
detailsValid=>condition: Details valid
e=>end:>
e2=>end:>
editMyDetails=>condition: Edit my details
editDetails=>condition: Edit details (theme, budget etc)
editItemDate=>condition: Edit item date
editSeatingPlan=>inputoutput: #UJ Edit Seating Plan
emailBelongsToUser=>condition: Email belongs to existing user
emailMessage=>operation: Writes & submits message + email
errorMessage=>end: Error message
fillInDetails=>operation: Fill in details
fillInLoginDetails=>condition: Fill in email/password
finishesContent=>condition: Finishes content
forgotDetailsForm=>inputoutput: #UJ Forgot Details Form
friendsInvited=>inputoutput: #UJ Friends Invited
hasSocialProfile=>condition: Has social profile (Facebook)?
importedContacts=>condition: Imported contacts (GMail, Facebook etc)
importContacts=>inputoutput: Import contacts
interactsWithComments=>condition: Interacts with comments
itemAdded=>inputoutput: Item added to list
itemChecked=>inputoutput: Item checked
itemDateEdited=>inputoutput: Item date edited
itemsRemoved=>inputoutput: Items removed
invitedToJoinLookBook=>inputoutput: #UJ Invited to Join Look Book
linkAdded=>inputoutput: Link added
loggedIn=>condition: Logged in
loggedIn2=>condition: Logged in
logInForm=>inputoutput: #UJ Log in
logInForm2=>inputoutput: #UJ Log in
lookBookCopied=>operation: Look Book copied
lookBookRepopulated=>inputoutput: Look Book repopulated
manageMyGuests=>inputoutput: #UJ Manage My Guests
manageMyTodoList=>inputoutput: #UJ Manage My ToDo List
messageSent=>operation: Message Sent to Supplier
messageSent2=>operation: Message Sent to Supplier
myWebsite=>inputoutput: #UJ My Website
moreContentLoaded=>operation: More content loaded
navigateThroughImages=>condition: Navigate through images
passValidation=>condition: Pass validation
phoneNumberShown=>operation: Phone # shown
readsContent=>condition: Reads content
reEnterDetails=>condition: Re enter details
removeItems=>condition: Remove items
requestsPhoneNumber=>condition: Requests phone #
scrollsDown=>condition: Scrolls down
seeSimilarLookBooks=>condition: See similar look books
selectOneOrMoreFriends=>condition: Select one or more friends
sendInvite=>inputoutput: Send invite
signUpForm=>inputoutput: #UJ Sign up form
signedIn=>inputoutput: Signed in
slideShowPopUp=>inputoutput: #UJ Slide Share Pop Up
signsInWithSocialProfile=>condition: Signs in with social profile (Facebook)?
simpleMessage=>condition: Writes & submits simple message
socialProfileAuthValid=>condition: Social profile authenticated?
startAddingToDoItem=>condition: Start adding item
submitEmail=>operation: Submit email
successMessage=>inputoutput: Success message
todo=>inputoutput: #TODO!!
todoAutoSuggestion=>operation: Todo auto-suggestion
togglePrivate=>condition: Toggle private
toogles=>inputoutput: Toggles
typeInTodoItem=>operation: Type in todo item
validEmail=>condition: Valid email
viewsContentIndex=>inputoutput: #UJ Views Content Index
viewsContent=>inputoutput: #UJ Views Content
viewsComments=>inputoutput: #UJ View Comments
viewExsistingComments=>operation: View existing comments
viewFriendsLookBook=>inputoutput: View friend's Look Book
viewMyLookBook=>inputoutput: #UJ Manage my Look Book
viewMyProfile=>inputoutput: #UJ View My Profile
viewOtherContentImages=>condition: View other content images
vote=>condition: Vote
voteAccepted=>inputoutput: Vote accepted
"""

VISITOR_UJS = [
  { title: "Get Inspired From Home",
    logic: """
st=>start: GET /home:>
#{ VISITOR_DEFINITIONS }

st->clicksInspNav
clicksInspNav(yes, right)->clicksContentCategory
clicksInspNav(no)->clicksContentItem
clicksContentCategory(yes, right)->viewsContentIndex
clicksContentCategory(no)->e
clicksContentItem(yes, right)->viewsContent
clicksContentItem(no)->e
    """
   },
  { title: "Views Content Index",
    logic: """
st=>start: GET /content/cat:>
#{ VISITOR_DEFINITIONS }

st->scrollsDown
scrollsDown(yes, right)->moreContentLoaded
scrollsDown(no)->clicksContent
moreContentLoaded->clicksContent
clicksContent(yes, right)->viewsContent
clicksContent(no)->e
    """
  },
  { title: "Views Content (Editorial)",
    logic: """
st=>start: GET /content/cat/#:>
#{ VISITOR_DEFINITIONS }

st->clicksImage->readsContent
clicksImage(yes, right)->slideShowPopUp
clicksImage(no)->readsContent
readsContent(yes, right)->finishesContent
readsContent(no)->addsToLookBook
addsToLookBook(yes, right)->successMessage
addsToLookBook(no)->e
finishesContent(yes, right)->clicksContentItem
finishesContent(no)->e
clicksContentItem(yes, right)->viewsContent
clicksContentItem(no)->scrollsDown
scrollsDown(yes, right)->moreContentLoaded
scrollsDown(no)->e2
    """
  },
  { title: "Views Content (Supplier)",
    logic: """
st=>start: GET /content/suppliers/#:>
#{ VISITOR_DEFINITIONS }

st->addsToLookBook
addsToLookBook(yes, right)->successMessage
addsToLookBook(no)->addedToXLookBooks
addedToXLookBooks(yes, right)->viewsContentIndex
addedToXLookBooks(no)->contactsSupplier
contactsSupplier(yes, right)->loggedIn
contactsSupplier(no)->requestsPhoneNumber
loggedIn(yes, right)->simpleMessage
loggedIn(no)->emailMessage
simpleMessage(yes, right)->messageSent
simpleMessage(no)->e
emailMessage->validEmail
validEmail(no, right)->emailMessage
validEmail(yes)->messageSent2
requestsPhoneNumber(yes, right)->phoneNumberShown
requestsPhoneNumber(no)->e
    """
  },
  { title: "Views Content (Look Book)",
    logic: """
st=>start: GET /look-books/#:>
#{ VISITOR_DEFINITIONS }

st->clicksVote
clicksVote(yes, right)->loggedIn
clicksVote(no)->copyLookBook
loggedIn(yes, right)->voteAccepted
loggedIn(no)->logInForm
copyLookBook(yes, right)->loggedIn2
loggedIn2(yes, right)->lookBookCopied
loggedIn2(no)->logInForm2
lookBookCopied->viewMyLookBook
copyLookBook(no)->clicksContentItem
clicksContentItem(yes, right)->viewsContent
clicksContentItem(no)->seeSimilarLookBooks
seeSimilarLookBooks(yes, right)->viewsContentIndex
seeSimilarLookBooks(no)->interactsWithComments
interactsWithComments(yes, right)->viewsComments
interactsWithComments(no)->e
    """
  },
  { title: "Manage my Profile",
    logic: """

st=>start: LogedIn /#:>
#{ VISITOR_DEFINITIONS }

st->clickedLookBook
clickedLookBook(yes, right)->viewMyLookBook
clickedLookBook(no)->clickManageMyGuests
clickManageMyGuests(yes, right)->manageMyGuests
clickManageMyGuests(no)->clickManageMyToDoList
clickManageMyToDoList(yes, right)->manageMyTodoList
clickManageMyToDoList(no)->clickMyWebSite
clickMyWebSite(yes, right)->myWebsite
clickMyWebSite(no)->editMyDetails
editMyDetails(yes, right)->detailsEditor
editMyDetails(no)->e

"""
  },
  { title: "Manage my Look Book",
    logic: """
st=>start: PUT /look-books/#:>
#{ VISITOR_DEFINITIONS }

st->editMyDetails
editMyDetails(yes, right)->detailsEditor
editMyDetails(no)->clicksContentItem
clicksContentItem(yes, right)->viewsContent
clicksContentItem(no)->togglePrivate
togglePrivate(yes, right)->toogles
togglePrivate(no)->removeItems
removeItems(yes, right)->itemsRemoved
removeItems(no)->interactsWithComments
interactsWithComments(yes, right)->viewsComments
interactsWithComments(no)->askFriendsToComment
askFriendsToComment(yes, right)->friendsInvited
askFriendsToComment(no)->addLink
addLink(yes, right)->linkAdded
addLink(no)->seeSimilarLookBooks
seeSimilarLookBooks(yes, right)->viewsContentIndex
seeSimilarLookBooks(no)->e
    """
  },
  { title: "Manage my Guests",
    logic: """

st=>start: /guests#:>
#{ VISITOR_DEFINITIONS }

st->importedContacts
importedContacts(yes, right)->clickInviteGuests
importedContacts(no)->importContacts
clickInviteGuests(yes, right)->friendsInvited
clickInviteGuests(no)->clickViewInvites
clickViewInvites(yes, right)->friendsInvited
clickViewInvites(no)->clickAddToSeatingPlan
clickAddToSeatingPlan(yes, right)->editSeatingPlan
clickAddToSeatingPlan(no)->e
"""
  },
  { title: "Manage my ToDo List",
    logic: """

st=>start: /todo-list#:>
#{ VISITOR_DEFINITIONS }

st->startAddingToDoItem
startAddingToDoItem(yes, right)->todoAutoSuggestion->correctTodoItem
startAddingToDoItem(no)->editItemDate
editItemDate(yes, right)->itemDateEdited
editItemDate(no)->checkItem
correctTodoItem(yes, right)->itemAdded
correctTodoItem(no)->typeInTodoItem->itemAdded
checkItem(yes, right)->itemChecked
checkItem(no)->e
"""
  },
  { title: "Edit Seating Plan",
    logic: """

st=>start: POST /seating-plan#:>
#{ VISITOR_DEFINITIONS }

editTableNumbers=>condition: Edit table numbers
tableNumberEdited=>inputoutput: Table numbers edited
addGuestsToTable=>condition: Add guest to table
guestAddedToTable=>inputoutput: Guest added to table
editGuestsOnTable=>condition: Edit guests on table
guestsOnTableEdited=>inputoutput: Guests on table edited

st->editTableNumbers
editTableNumbers(yes, right)->tableNumberEdited
editTableNumbers(no)->editGuestsOnTable
editGuestsOnTable(yes, right)->guestsOnTableEdited
editGuestsOnTable(no)->addGuestsToTable
addGuestsToTable(yes, right)->guestAddedToTable
addGuestsToTable(no)->e
"""
  },
  { title: "My Website",
    logic: """

st=>start: /guests#:>
#{ VISITOR_DEFINITIONS }

unchanged=>inputoutput: Unchanged from current

st->unchanged
"""
  },
  { title: "View comments",
    logic: """
st=>start: Clicked on comments:>
#{ VISITOR_DEFINITIONS }

st->viewExsistingComments->loggedIn
loggedIn(yes, right)->vote
loggedIn(no)->logInForm
vote(yes, right)->voteAccepted
vote(no)->addComment
addComment(yes, right)->commentAccepted
addComment(no)->e
    """
  },
  { title: "Details Editor",
    logic: """
st=>start: Details editor:>
#{ VISITOR_DEFINITIONS }

st->editDetails
editDetails(yes, right)->detailsEdited
editDetails(no)->e
    """
    },
  { title: "Friends Invited",
    logic: """
st=>start: Clicked invite:>
#{ VISITOR_DEFINITIONS }

viewFriends=>operation: View friends (invited, accepted etc)

st->viewFriends->importedContacts
importedContacts(yes, right)->selectOneOrMoreFriends
importedContacts(no)->addFriendsEmail
selectOneOrMoreFriends(yes, right)->sendInvite->invitedToJoinLookBook
selectOneOrMoreFriends(no)->e
addFriendsEmail(yes, right)->sendInvite
addFriendsEmail(no)->e
    """
  },
  { title: "Slide Share Popup",
    logic: """
st=>start: Clicked content image:>
#{ VISITOR_DEFINITIONS }

st->navigateThroughImages
navigateThroughImages(yes, right)->viewOtherContentImages
navigateThroughImages(no)->addsToLookBook
addsToLookBook(yes, right)->successMessage
addsToLookBook(no)->interactsWithComments
interactsWithComments(yes, right)->viewsComments
interactsWithComments(no)->e
    """
  },
  { title: "Log in",
    logic: """
st=>start: POST /session:>
#{ VISITOR_DEFINITIONS }

signedInWithSocial=>condition: Signed in with social profile?

st->signedInWithSocial
signedInWithSocial(yes, right)->signsInWithSocialProfile
signedInWithSocial(no)->alreadyAUser
signsInWithSocialProfile(yes, right)->socialProfileAuthValid
socialProfileAuthValid(yes, right)->viewMyProfile
socialProfileAuthValid(no)->errorMessage
alreadyAUser(yes, right)->clickForgotDetails
alreadyAUser(no)->clickSignUp
clickForgotDetails(yes, right)->forgotDetailsForm
clickForgotDetails(no)->fillInDetails->passValidation
clickSignUp(yes, right)->signUpForm
clickSignUp(no)->fillInDetails
passValidation(yes, right)->viewMyProfile
passValidation(no)->fillInDetails
    """
  },
  { title: "Sign up form",
    logic: """
st=>start: POST /signup:>
#{ VISITOR_DEFINITIONS }

st->hasSocialProfile
hasSocialProfile(yes, right)->signsInWithSocialProfile
hasSocialProfile(no)->fillInLoginDetails
signsInWithSocialProfile(yes, right)->socialProfileAuthValid
socialProfileAuthValid(yes, right)->viewMyLookBook
socialProfileAuthValid(no)->errorMessage
fillInLoginDetails(yes, right)->detailsValid
fillInLoginDetails(no)->e
detailsValid(yes, right)->viewMyProfile
detailsValid(no)->reEnterDetails->detailsValid
    """
  },
  { title: "Invited to Join Look Book",
    logic: """
st=>start: Receive invite (email/FB etc):>
#{ VISITOR_DEFINITIONS }

st->acceptInvite
acceptInvite(yes, right)->viewFriendsLookBook
acceptInvite(no)->e
    """
  },
  { title: "Forgot Details Form",
    logic: """
st=>start: POST /forgot-details:>
#{ VISITOR_DEFINITIONS }

st->submitEmail->emailBelongsToUser
emailBelongsToUser(yes, right)->changePasswordEmailSent
emailBelongsToUser(no)->e
    """
  }
]