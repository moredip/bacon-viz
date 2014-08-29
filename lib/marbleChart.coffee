BaconViz = this.BaconViz ?= {}

prepRootNode = (rootSvgNode)->
  margin = {top: 6, right: 0, bottom: 20, left: 40}
  height = 120 - margin.top - margin.bottom
  width = 960 - margin.right

  root = d3.select(rootSvgNode)
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
      .style("margin-left", -margin.left + "px")

  container = root.append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")")

  marbleGroup = container.append("g")
  {root,marbleGroup}

refreshMarbles = ({marbleGroup,data,x,height})->
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

BaconViz.createMarbleChartWithin = (rootSvgNode)->
  updateInterval = 1000  
  timeRange = 1000 * 60 # 60 seconds
  now = Date.now()

  {marbleGroup,root} = prepRootNode(rootSvgNode)
  width = root.attr("width")
  height = root.attr("height")
  
  data = [ now - 10000, now - 11000 ]

  x = d3.time.scale()
      .domain([now - timeRange, now])
      .range([0, width])


  tick = ->
    now = new Date()
    x.domain([now - timeRange, now])

    refreshMarbles({marbleGroup,data,x,height})

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

  updateData = (newData)->
    data = newData
    #tick()

  {updateData}
