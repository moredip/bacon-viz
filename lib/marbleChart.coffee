BaconViz = this.BaconViz ?= {}

prepRootNode = (rootSvgNode)->
  margin = {top: 6, right: 40, bottom: 20, left: 40}
  height = 120 - margin.top - margin.bottom
  width = 960 - margin.right - margin.left

  root = d3.select(rootSvgNode)
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
      .style("margin-left", -margin.left + "px")

  container = root.append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")")

  container.append('rect')
    .attr("width", width)
    .attr("height", height)
    .attr("class", "border")

  marbleGroup = container.append("g")
  {root,marbleGroup}

refreshMarbles = ({marbleGroup,eventData,x,height})->
  fade = x.copy().range([0,1])

  marbles = marbleGroup
    .selectAll(".marble")
    .data(eventData)

  marbles.enter().append("circle")
    .attr("class","marble")
    .attr("r", 20)
    .attr("cy", height/2)

  marbles.exit().remove()

  marbles
    .attr("cx", (d)-> x(d) )
    .attr("opacity", (d)-> fade(d) )

BaconViz.createMarbleChartWithin = (rootSvgNode)->
  updateInterval = 50
  timeRange = 1000 * 10 # 10 seconds
  now = new Date()

  {marbleGroup,root} = prepRootNode(rootSvgNode)
  width = root.attr("width")
  height = root.attr("height")
  
  eventData = []

  x = d3.time.scale()
      .domain([now - timeRange, now])
      .range([0, width])

  tick = ->
    now = new Date()
    x.domain([now - timeRange, now])

    # re-position marbles
    refreshMarbles({marbleGroup,eventData,x,height})

    # set up a transition to keep everything sliding until the next tick
    marbleGroup
      .attr("transform",null)
      .transition()
        .duration(updateInterval)
        .ease("linear")
        .attr("transform", "translate(" + x(now - timeRange - updateInterval) + ")")
        .each("end", tick)

  tick()

  addNewMarble = ()->
    eventTimestamp = new Date()
    eventData.push(eventTimestamp)
    #tick()

  {addNewMarble}

