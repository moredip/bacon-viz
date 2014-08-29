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
  BaconViz.createMarbleChartWithin("svg#marbles")
