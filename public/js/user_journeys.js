(function() {
  var APP, FILES, FLOWCHART, OPTIONS, RAPHAEL;

  APP = "app";

  RAPHAEL = 'helpers/raphael';

  FLOWCHART = 'helpers/flowchart';

  OPTIONS = 'data/flowchartOptions';

  FILES = [APP, RAPHAEL, FLOWCHART, OPTIONS];

  require(FILES, function() {
    var changeTitle, drawFlowchart, highlightCurrent, init, loadUserJourney, removeOldUJ, updateUJPage;
    init = function() {
      return $(".user_journey_item").on("click", loadUserJourney);
    };
    loadUserJourney = function(event) {
      var code, title, uj;
      event.preventDefault();
      uj = event.target;
      title = $(uj).data('title');
      code = $(uj).data('code');
      return updateUJPage(uj, title, code);
    };
    updateUJPage = function(uj, title, code) {
      removeOldUJ();
      highlightCurrent(uj);
      changeTitle(title);
      return drawFlowchart(code);
    };
    removeOldUJ = function() {
      var current, instructions;
      current = $(".current_user_journey");
      instructions = $("h4.user_journey_instructions");
      if (current) {
        current.removeClass("current_user_journey");
      }
      if (instructions) {
        instructions.remove();
      }
      if ($("svg")) {
        return $("svg").remove();
      }
    };
    highlightCurrent = function(uj) {
      return $(uj).parent().addClass('current_user_journey');
    };
    changeTitle = function(title) {
      return $("h3.user_journey_name").text(title);
    };
    drawFlowchart = function(code) {
      var chart;
      chart = window.flowchart.parse(code);
      return chart.drawSVG('canvas', flowchartOptions);
    };
    return init();
  });

}).call(this);
