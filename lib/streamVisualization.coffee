BaconViz = this.BaconViz ?= {}

BaconViz.createStreamVisualization = (streamName)->
  $streamsContainer = $('article.streams')

  $newStream = $("""
    <section class="marble-stream">
      <h2/>
      <svg class="marbles"/>
    </section>
  """)
  $newStream.find('h2').text(streamName)
  $newStream.appendTo($streamsContainer)

  $svg = $newStream.find("svg")
  chart = BaconViz.createMarbleChartWithin($svg[0])
  

  {
    chart
  }
  

