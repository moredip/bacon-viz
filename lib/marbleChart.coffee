BaconViz = this.BaconViz ?= {}

MARBLE_RADIUS = 20

prepRootNode = (rootSvgNode)->
  height = 60;
  width = 960;

  root = d3.select(rootSvgNode)
      .attr("width", width)
      .attr("height", height)

  container = root.append("g")

  container.append('line')
    .attr("x1", 0)
    .attr("y1", height/2)
    .attr("x2", width-MARBLE_RADIUS)
    .attr("y2", height/2)
    .attr("class", "marble-line")

  marbleGroup = container.append("g")
  {root,marbleGroup}

refreshMarbles = ({marbleGroup,eventData,x,height})->
  fadeScale = x.copy().range([0,1])
  colorScale = d3.scale.category10()

  marbles = marbleGroup
    .selectAll(".marble")
    .data(eventData)

  marbles.enter().append("circle")
    .attr("class","marble")
    .attr("r", MARBLE_RADIUS)
    .attr("cy", height/2)

  marbles.exit().remove()

  marbles
    .attr("cx", (d)-> x(d) )
    .attr("opacity", (d)-> fadeScale(d) )
    .style("fill", (d,i)-> colorScale(i) )
    .style("stroke", (d,i)-> d3.rgb(colorScale(i)).darker() )

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
      .range([0, width-MARBLE_RADIUS])

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

