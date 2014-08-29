BaconViz = window.BaconViz
visualizer = BaconViz.createVisualizer()

trackClicks = ->
  $('body')
    .asEventStream('click')
    .map( 'you clicked!!!' )
    .doAction( visualizer.recordBaconEvent )
    .log()


d3Vis = ->
  updateInterval = 70
  timeRange = 1000 * 60 # 60 seconds
  now = Date.now()
  
  data = [ now - 10000, now - 11000 ]

  margin = {top: 6, right: 0, bottom: 20, left: 40}
  width = 960 - margin.right
  height = 120 - margin.top - margin.bottom

  x = d3.time.scale()
      .domain([now - timeRange, now])
      .range([0, width])

  svg = d3.select("svg#marbles")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
      .style("margin-left", -margin.left + "px")
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")")

  svg.append("defs").append("clipPath")
      .attr("id", "clip")
    .append("rect")
      .attr("width", width)
      .attr("height", height);

  #axis = svg.append("g")
      #.attr("class", "x axis")
      #.attr("transform", "translate(0," + height + ")")
      #.call(x.axis = d3.svg.axis().scale(x).orient("bottom"))

  marbleGroup = svg.append("g")

  tick = ->
    now = new Date()
    x.domain([now - timeRange, now])

    marbles = marbleGroup
      .selectAll(".marble")
      .data(data)

    marbles.enter().append("circle")
      .attr("class","marble")
      .attr("r", 20)
      .attr("cy", height/2)

    marbles.exit().remove()

    marbles
      .attr("cx", (d)-> x(d) )

    # slide the x-axis left
    #axis.transition()
        #.duration(updateInterval)
        #.ease("linear")
        #.call(x.axis)

    # slide the marbles left
    marbleGroup
      .attr("transform",null)
      .transition()
        .duration(updateInterval)
        .ease("linear")
        .attr("transform", "translate(" + x(now - timeRange - updateInterval) + ")")
        .each("end", tick)

  tick()


#$(trackClicks)
#$(d3Vis)

$ ->
  BaconViz.createMarbleChartWithin("svg#marbles")
