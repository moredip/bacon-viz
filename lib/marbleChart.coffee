BaconViz = this.BaconViz ?= {}

MARBLE_RADIUS = 30
TIME_RANGE_MS = 10 * 1000

RGB_REGEX = /^rgb\([\.\d]+,\s?[\.\d]+,\s?[\.\d]+\)$/
isColorString = (str)->
  !!RGB_REGEX.exec(str)

inspect = (val)->
  try
    JSON.stringify(val)
  catch 
    null

createCurrValueMarbleWithin = (container)->
  marble = container.append("svg:g")
      .attr("class","curr-value marble")

  # hide the marble until it gets its first value
  marble.style("visibility","hidden")

  marble
    .append("circle")
      .attr("r", MARBLE_RADIUS)

  marble
    .append("text")
     .attr("alignment-baseline","middle")
     .attr("text-anchor","middle")

  marble

prepRootNode = (root)->
  height = (MARBLE_RADIUS * 2) + 14

  width = root.attr("width")
  root.attr("height",height)

  container = root.append("g")

  container.append('line')
    .attr("x1", 0)
    .attr("y1", height/2)
    .attr("x2", width-MARBLE_RADIUS)
    .attr("y2", height/2)
    .attr("class", "marble-line")

  currValueMarble = createCurrValueMarbleWithin(container)
  currValueMarble.attr("transform", "translate(#{width-MARBLE_RADIUS-5},#{height/2})")

  marbleGroup = container.append("g")

  {marbleGroup,currValueMarble}

refreshCurrValueMarble = (currValueMarble,latestEvent)->
  currValueMarble
    .style("visibility","visible")
    .select("text").text( latestEvent.displayText )

colorScale = d3.scale.category10()
colorForData = (d,i)->
  d3.rgb( if d.displayColor then d.displayColor else colorScale(i) )

refreshMarbles = ({marbleGroup,eventData,x,height})->
  fadeScale = x.copy().range([0,1])
  yCenter = height/2;

  marbles = marbleGroup
    .selectAll(".marble")
    .data(eventData)

  newMarble = marbles
    .enter()
    .append("svg:g")
      .attr("class","marble")

  newMarble
    .append("circle")
      .attr("r", MARBLE_RADIUS)

  newMarble
    .append("text")
     .attr("alignment-baseline","middle")
     .attr("text-anchor","middle")

  marbles.exit().remove()

  marbles
    .attr("transform", (d)-> "translate(#{x(d.timestamp)},#{yCenter})")
    .attr("opacity", (d)-> fadeScale(d.timestamp) )

  marbles.select("circle")
      .style("fill", colorForData )
      .style("stroke", (d,i)-> colorForData(d,i).darker() )

  marbles.select("text")
    .text( (d)-> d.displayText )


trimEventData = ({timeRange,now,eventData})->
  ageLimit = now-timeRange

  trimmedEventData = []
  for event in eventData
    if event.timestamp > ageLimit
      trimmedEventData.push(event)

  trimmedEventData
  

BaconViz.createMarbleChartWithin = (rootSvgNode,containerWidth)->
  updateInterval = 50
  timeRange = TIME_RANGE_MS
  now = new Date()

  root = d3.select(rootSvgNode)
  root.attr("width",containerWidth - (MARBLE_RADIUS*2))

  {marbleGroup,currValueMarble} = prepRootNode(root)
  width = root.attr("width")
  height = root.attr("height")
  
  eventData = []

  x = d3.time.scale()
      .domain([now - timeRange, now])
      .range([0, width-MARBLE_RADIUS])

  tick = ->
    now = new Date()
    x.domain([now - timeRange, now])

    eventData = trimEventData({eventData,timeRange,now})

    # re-position marbles
    refreshMarbles({marbleGroup,eventData,x,height})

    if eventData.length
      latestEvent = eventData[ eventData.length - 1 ]
      refreshCurrValueMarble(currValueMarble,latestEvent)

    # set up a transition to keep everything sliding until the next tick
    marbleGroup
      .attr("transform",null)
      .transition()
        .duration(updateInterval)
        .ease("linear")
        .attr("transform", "translate(" + x(now - timeRange - updateInterval) + ")")
        .each("end", tick)

  tick()

  addNewMarble = (baconEvent)->
    if isColorString(baconEvent.value()) 
      displayText = undefined
      displayColor = baconEvent.value()
    else
      displayColor = undefined
      displayText = inspect(baconEvent.value())

    event = {
      backingEvent: baconEvent
      displayText: displayText
      displayColor: displayColor
      timestamp: new Date()
    }
    eventData.push(event)

  {addNewMarble}

