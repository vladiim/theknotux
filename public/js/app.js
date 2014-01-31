(function() {
  var BOOTSTRAP, DRAG, HELPERS, HOLDER, JQUERY, LIBRARIES, USER_JOURNEYS;

  HELPERS = "/helpers";

  HOLDER = "holder";

  JQUERY = "jquery";

  BOOTSTRAP = "bootstrap";

  DRAG = "dragable";

  USER_JOURNEYS = "user_journeys";

  LIBRARIES = [JQUERY, BOOTSTRAP, "" + HELPERS + "/" + HOLDER, USER_JOURNEYS, DRAG];

  require.config({
    paths: {
      "jquery": "" + HELPERS + "/" + JQUERY,
      "bootstrap": "" + HELPERS + "/" + BOOTSTRAP
    },
    shim: {
      "bootstrap": {
        deps: [JQUERY]
      }
    }
  });

  require(LIBRARIES, function($) {
    var advertisersClickMessageListener, advertisersMessageListener, advertisersRespondMessageListener, advertisersSendMessageListener, contentIconGenerator, contentIconListener, contentStatsCommentListener, contentStatsListeners, contentStatsLookBookListener, generateContentIcons, init, navTabListener, showIconAction, watchContentStats, watchLookBook, watchNav, watchOrderByFilter, watchOrderByPopover;
    contentIconGenerator = function(icon, title) {
      var value, views;
      views = $(".title_content_icon > .glyphicon-" + icon);
      value = views.data('value');
      return views.tooltip({
        "title": "" + value + " " + title
      });
    };
    showIconAction = function(event, icon) {
      if ($(event.target).hasClass("glyphicon-" + icon)) {
        return $(".icon_action." + icon).toggleClass("hidden");
      }
    };
    generateContentIcons = function() {
      contentIconGenerator("eye-open", "Views");
      contentIconGenerator("heart", "Saved to Look Book");
      contentIconGenerator("comment", "Comments");
      return contentIconGenerator("share-alt", "shares");
    };
    navTabListener = function() {
      return $(".nav-tabs a").on("click", function(e) {
        e.preventDefault();
        return $(this).tab('show');
      });
    };
    contentIconListener = function() {
      return $(".title_content_icon").on("click", function(event) {
        showIconAction(event, "eye-open");
        showIconAction(event, "heart");
        showIconAction(event, "comment");
        return showIconAction(event, "share-alt");
      });
    };
    watchOrderByPopover = function() {
      $(".popover-link").popover();
      $(".popover-link").on('click', function(event) {
        return event.preventDefault();
      });
      return $(document).on('click', "a.popover-link", function(event) {
        var old_link;
        old_link = $(event.target);
        return $(".popover-content > ul > li a").on('click', function(event) {
          var new_link;
          event.preventDefault();
          new_link = $(event.target);
          return $(old_link).text(new_link.text());
        });
      });
    };
    watchNav = function() {
      return $(window).scroll(function() {
        if ($(document).scrollTop() >= 176) {
          $("nav.navbar-default").addClass("navbar-fixed-top") && $("#main").addClass("scroll");
        }
        if ($(document).scrollTop() <= 176) {
          return $("nav.navbar-default").removeClass("navbar-fixed-top") && $("#main").removeClass("scroll");
        }
      });
    };
    watchOrderByFilter = function() {
      return $(window).scroll(function() {
        if ($(document).scrollTop() >= 748) {
          $("#order-by-filter h3").addClass("sticky-order-by-filter");
        }
        if ($(document).scrollTop() <= 748) {
          return $("#order-by-filter h3").removeClass("sticky-order-by-filter");
        }
      });
    };
    watchContentStats = function() {
      return $(window).scroll(function() {
        if ($(document).scrollTop() >= 480) {
          $(".content-stats").addClass("sticky-side-bar");
        }
        if ($(document).scrollTop() <= 480) {
          $(".content-stats").removeClass("sticky-side-bar");
        }
        if ($(document).scrollTop() >= 1410) {
          $(".content-stats").hide();
        }
        if ($(document).scrollTop() <= 1410) {
          return $(".content-stats").show();
        }
      });
    };
    watchLookBook = function() {
      $(".theme").on("click", function(event) {
        return $(event.target).parent().toggleClass("checked");
      });
      $(".budget a").popover();
      return $(".toggle-look-book").on("click", function(event) {
        var panel;
        panel = "" + ($(event.target).data('toggle')) + "-panel";
        return $("#" + panel).toggleClass("hidden");
      });
    };
    advertisersMessageListener = function() {
      advertisersClickMessageListener();
      advertisersRespondMessageListener();
      return advertisersSendMessageListener();
    };
    advertisersClickMessageListener = function() {
      return $("#message-list").on("click", function(event) {
        event.preventDefault();
        $("#message-list").addClass("hidden");
        return $("#read-message").removeClass("hidden");
      });
    };
    advertisersRespondMessageListener = function() {
      return $("#respond-to-message").on("click", function(event) {
        event.preventDefault();
        $("#read-message").addClass("hidden");
        return $("#compose-message").removeClass("hidden");
      });
    };
    advertisersSendMessageListener = function() {
      return $("#send-message").on("click", function(event) {
        event.preventDefault();
        $("#compose-message").addClass("hidden");
        $("#message-list").removeClass("hidden");
        return $("#message-sent-alert").removeClass("hidden");
      });
    };
    contentStatsListeners = function() {
      contentStatsLookBookListener();
      return contentStatsCommentListener();
    };
    contentStatsLookBookListener = function() {
      $("#show-look-book a").on("click", function(event) {
        event.preventDefault();
        $("#stats-list").addClass("hidden");
        return $("#look-book-stats-show").removeClass("hidden");
      });
      return $("#look-book-stats-close").on("click", function(event) {
        $("#stats-list").removeClass("hidden");
        return $("#look-book-stats-show").addClass("hidden");
      });
    };
    contentStatsCommentListener = function() {
      $("#show-comments a").on("click", function(event) {
        event.preventDefault();
        $("#stats-list").addClass("hidden");
        return $("#comments-stats-show").removeClass("hidden");
      });
      return $("#comment-stats-close").on("click", function(event) {
        $("#stats-list").removeClass("hidden");
        return $("#comments-stats-show").addClass("hidden");
      });
    };
    $(".guest-drag").drags();
    init = function() {
      generateContentIcons();
      contentIconListener();
      watchNav();
      watchOrderByPopover();
      watchOrderByFilter();
      watchContentStats();
      watchLookBook();
      navTabListener();
      advertisersMessageListener();
      return contentStatsListeners();
    };
    return init();
  });

}).call(this);
