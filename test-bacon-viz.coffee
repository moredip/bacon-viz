BaconViz = window.BaconViz
visualizer = BaconViz.createVisualizer()

trackClicks = ->
  $('body')
    .asEventStream('click')
    .map( 'you clicked!!!' )
    .doAction( visualizer.recordBaconEvent )
    .log()

#$(trackClicks)
#$(d3Vis)

$ ->
  clicksVis = BaconViz.createStreamVisualization("all clicks")
  $('body')
    .asEventStream('click')
    .visualizeIn(clicksVis.chart)

  mouseMoves = $('body > h1')
    .asEventStream('mousemove')

  mouseMoves
    .throttle(100)
    .visualizeIn(
      BaconViz.createStreamVisualization("moves throttled to 100ms").chart
    )

  mouseMoves
    .throttle(1000)
    .visualizeIn(
      BaconViz.createStreamVisualization("moves throttled to 1000ms").chart
    )

  #chart = BaconViz.createMarbleChartWithin("svg#marbles")

  #$('body')
    #.asEventStream('click')
    #.visualizeIn(chart)
