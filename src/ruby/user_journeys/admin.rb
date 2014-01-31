ADMIN_DEFINITIONS = """
articleSubmited=>inputoutput: Article submitted for editing
clickCreateArticle=>condition: Click create new article
clickEditArticle=>condition: Click edit article
clickMessage=>condition: Click on supplier message
clickViewSupplierMessages=>condition: Click view supplier messages
createArticle=>inputoutput: #UJ Create Article
clickViewArticleIndex=>condition: Click view article index
continueEditingArticle=>end: Continue editing article
e=>end:>
editArticle=>inputoutput: #UJ Edit Article
editListOrderBy=>condition: Edit list order by
enteredAllArticleInfo=>condition: Entered all article details
listingRevised=>inputoutput: Listing revised (supplier notified)
listReOrdered=>inputoutput: List reordered
invalidMessage=>end: Invalid edit message
isEditor=>condition: Is editor?
manageSupplierMessage=>inputoutput: #UJ Manage Supplier Message
publishesArticle=>inputoutput: Publishes article
readyToPublish=>condition: Ready to publish?
responseSaved=>inputoutput: Response saved
reviseListing=>condition: Revise listing
revisionCommentAdded=>condition: Revision comment added
submitArticle=>condition: Submit article
submitEdits=>inputoutput: Submits edits
todo=>end: TODO
viewArticleIndex=>inputoutput: #UJ View Article Index
viewMyStats=>inputoutput: View my key stats
viewSupplierMessages=>inputoutput: #UJ View Supplier Messages
writeResponse=>condition: Write response
"""

ADMIN_UJS = [
  { title: "View Profile",
    logic: """
st=>start: /content/cat:>
#{ ADMIN_DEFINITIONS }

st->viewMyStats->clickViewArticleIndex
clickViewArticleIndex(yes, right)->viewArticleIndex
clickViewArticleIndex(no)->clickCreateArticle
clickCreateArticle(yes, right)->createArticle
clickCreateArticle(no)->clickEditArticle
clickEditArticle(yes, right)->editArticle
clickEditArticle(no)->clickViewSupplierMessages
clickViewSupplierMessages(yes, right)->viewSupplierMessages
clickViewSupplierMessages(no)->e
    """
  },
  { title: "View Article Index",
    logic: """
st=>start: /admin/articles:>
#{ ADMIN_DEFINITIONS }

st->editListOrderBy
editListOrderBy(yes, right)->listReOrdered
editListOrderBy(no)->clickEditArticle
clickEditArticle(yes, right)->editArticle
clickEditArticle(no)->e
    """
  },
  { title: "Create Article",
    logic: """
st=>start: POST /admin/articles/#:>
#{ ADMIN_DEFINITIONS }

st->enteredAllArticleInfo
enteredAllArticleInfo(yes, right)->submitArticle
enteredAllArticleInfo(no)->continueEditingArticle
submitArticle(yes, right)->articleSubmited
submitArticle(no)->continueEditingArticle
    """
  },
  { title: "Edit Article",
    logic: """
st=>start: /admin/articles:>
#{ ADMIN_DEFINITIONS }

st->isEditor
isEditor(yes, right)->readyToPublish
isEditor(no)->submitEdits
readyToPublish(yes, right)->publishesArticle
readyToPublish(no)->submitEdits
    """
  },
  { title: "View Supplier Messages",
    logic: """
st=>start: GET /messages:>
#{ ADMIN_DEFINITIONS }

st->editListOrderBy
editListOrderBy(yes, right)->listReOrdered
editListOrderBy(no)->clickMessage
clickMessage(yes, right)->manageSupplierMessage
clickMessage(no)->e
    """
  },
  { title: "Manage Supplier Message",
    logic: """
st=>start: POST /messages/#:>
#{ ADMIN_DEFINITIONS }

st->writeResponse
writeResponse(yes, right)->responseSaved
writeResponse(no)->e
    """
  },
  { title: "Create/edit Supplier Listing",
    logic: """
st=>start: POST /listing/#:>
#{ ADMIN_DEFINITIONS }

st->reviseListing
reviseListing(yes, right)->revisionCommentAdded
reviseListing(no)->e
revisionCommentAdded(yes, right)->listingRevised
revisionCommentAdded(no)->invalidMessage
    """
  }
]