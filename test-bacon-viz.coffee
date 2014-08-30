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
  chart = BaconViz.createMarbleChartWithin("svg#marbles")

  $('body')
    .asEventStream('click')
    .visualizeIn(chart)
