HOLDER        = "holder"
JQUERY        = "jquery"
BOOTSTRAP     = "bootstrap"
DRAG          = "dragable"
USER_JOURNEYS = "user_journeys"

LIBRARIES = [ JQUERY, BOOTSTRAP, HOLDER, USER_JOURNEYS, DRAG]

require.config
  paths:
    "jquery": JQUERY
    "bootstrap": BOOTSTRAP

  shim:
  	"bootstrap":
      deps: [JQUERY]

require LIBRARIES, ( $ ) ->
  jQuery = $

  contentIconGenerator = (icon, title) ->
    views = $(".title_content_icon > .glyphicon-#{icon}")
    value = views.data('value')
    views.tooltip({ "title": "#{value} #{title}" })

  showIconAction = (event, icon) ->
    if $(event.target).hasClass("glyphicon-#{icon}") then $(".icon_action.#{icon}").toggleClass("hidden")

  generateContentIcons = ->
    contentIconGenerator("eye-open", "Views")
    contentIconGenerator("heart", "Saved to Look Book")
    contentIconGenerator("comment", "Comments")
    contentIconGenerator("share-alt", "shares")

  navTabListener = ->
    $(".nav-tabs a").on "click", (e) ->
      e.preventDefault()
      $(@).tab('show')

  contentIconListener = ->
    $(".title_content_icon").on "click", (event) ->
      showIconAction(event, "eye-open")
      showIconAction(event, "heart")
      showIconAction(event, "comment")
      showIconAction(event, "share-alt")

  watchOrderByPopover = ->
    $(".popover-link").popover()
    $(".popover-link").on 'click', (event) -> event.preventDefault()
    $(document).on 'click', "a.popover-link", (event) ->
      old_link = $(event.target)
      $(".popover-content > ul > li a").on 'click', (event) ->
        event.preventDefault()
        new_link = $(event.target)
        $(old_link).text(new_link.text())


  watchNav = ->
    $(window).scroll ->
      if $(document).scrollTop() >= 176 then $("nav.navbar-default").addClass("navbar-fixed-top") and $("#main").addClass("scroll")
      if $(document).scrollTop() <= 176 then $("nav.navbar-default").removeClass("navbar-fixed-top") and $("#main").removeClass("scroll")

  watchOrderByFilter = ->
    $(window).scroll ->
      if $(document).scrollTop() >= 748 then $("#order-by-filter h3").addClass("sticky-order-by-filter")
      if $(document).scrollTop() <= 748 then $("#order-by-filter h3").removeClass("sticky-order-by-filter")

  watchContentStats = ->
    $(window).scroll ->
      if $(document).scrollTop() >= 480 then $(".content-stats").addClass("sticky-side-bar")
      if $(document).scrollTop() <= 480 then $(".content-stats").removeClass("sticky-side-bar")
      if $(document).scrollTop() >= 1410 then $(".content-stats").hide()
      if $(document).scrollTop() <= 1410 then $(".content-stats").show()

  watchLookBook = ->
    $(".theme").on "click", (event) -> $(event.target).parent().toggleClass("checked")
    $(".budget a").popover()
    $(".toggle-look-book").on "click", (event)->
      panel = "#{$(event.target).data('toggle')}-panel"
      $("##{panel}").toggleClass("hidden")

  advertisersMessageListener = ->
    advertisersClickMessageListener()
    advertisersRespondMessageListener()
    advertisersSendMessageListener()

  advertisersClickMessageListener = ->
    $("#message-list").on "click", (event) ->
      event.preventDefault()
      $("#message-list").addClass("hidden")
      $("#read-message").removeClass("hidden")

  advertisersRespondMessageListener = ->
    $("#respond-to-message").on "click", (event) ->
      event.preventDefault()
      $("#read-message").addClass("hidden")
      $("#compose-message").removeClass("hidden")

  advertisersSendMessageListener = ->
    $("#send-message").on "click", (event) ->
      event.preventDefault()
      $("#compose-message").addClass("hidden")
      $("#message-list").removeClass("hidden")
      $("#message-sent-alert").removeClass("hidden")

  contentStatsListeners = ->
    contentStatsLookBookListener()
    contentStatsCommentListener()

  contentStatsLookBookListener = ->
    $("#show-look-book a").on "click", (event) ->
      event.preventDefault()
      $("#stats-list").addClass("hidden")
      $("#look-book-stats-show").removeClass("hidden")
    $("#look-book-stats-close").on "click", (event) ->
      $("#stats-list").removeClass("hidden")
      $("#look-book-stats-show").addClass("hidden")

  contentStatsCommentListener = ->
    $("#show-comments a").on "click", (event) ->
      event.preventDefault()
      $("#stats-list").addClass("hidden")
      $("#comments-stats-show").removeClass("hidden")
    $("#comment-stats-close").on "click", (event) ->
      $("#stats-list").removeClass("hidden")
      $("#comments-stats-show").addClass("hidden")

  $(".guest-drag").drags()

  init = ->
    generateContentIcons()
    contentIconListener()
    watchNav()
    watchOrderByPopover()
    watchOrderByFilter()
    watchContentStats()
    watchLookBook()
    navTabListener()
    advertisersMessageListener()
    contentStatsListeners()

  init()