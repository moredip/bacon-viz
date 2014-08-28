BaconVis = window.BaconVis
visualizer = BaconVis.createVisualizer()

$ -> 
  $('body')
    .asEventStream('click')
    .map( 'you clicked!!!' )
    .doAction( visualizer.recordBaconEvent )
    .log()
