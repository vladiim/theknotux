APP       = "app"
RAPHAEL   = 'helpers/raphael'
FLOWCHART = 'helpers/flowchart'
OPTIONS   = 'data/flowchartOptions'

FILES     = [APP, RAPHAEL, FLOWCHART, OPTIONS]

require FILES, ->
  init = ->
    $(".user_journey_item").on("click", loadUserJourney)

  loadUserJourney = (event) ->
    event.preventDefault()
    uj    = event.target
    title = $(uj).data('title')
    code  = $(uj).data('code')
    updateUJPage(uj, title, code)

  updateUJPage = (uj, title, code) ->
    removeOldUJ()
    highlightCurrent(uj)
    changeTitle(title)
    drawFlowchart(code)

  removeOldUJ = ->
    current      = $(".current_user_journey")
    instructions = $("h4.user_journey_instructions")
    if current then current.removeClass("current_user_journey")
    if instructions then instructions.remove()
    if $("svg") then $("svg").remove()

  highlightCurrent = (uj) ->
    $(uj).parent().addClass('current_user_journey')

  changeTitle = (title) ->
    $("h3.user_journey_name").text(title)

  drawFlowchart = (code) ->
    chart = window.flowchart.parse(code)
    chart.drawSVG('canvas', flowchartOptions)

  init()