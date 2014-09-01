visualize = (streamName)->
  vis = BaconViz.createStreamVisualization(streamName)
  this.subscribe (event)->
    vis.chart.addNewMarble( event )
  this


if Bacon? and Bacon.Observable?
  Bacon.Observable.prototype.visualize = visualize
