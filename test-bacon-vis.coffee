BaconVis = window.BaconVis
visualizer = BaconVis.createVisualizer()

trackClicks = ->
  $('body')
    .asEventStream('click')
    .map( 'you clicked!!!' )
    .doAction( visualizer.recordBaconEvent )
    .log()


d3Vis = ->
  n = 243
  duration = 750
  now = new Date(Date.now() - duration)
  #count = 0
  #data = d3.range(n).map( -> 0 )
  
  data = [ Date.now() - (10*duration), Date.now() - (150*duration) ]

  margin = {top: 6, right: 0, bottom: 20, left: 40}
  width = 960 - margin.right
  height = 120 - margin.top - margin.bottom

  x = d3.time.scale()
      .domain([now - (n - 2) * duration, now - duration])
      .range([0, width])

  y = d3.scale.linear()
      .range([height, 0])

  #line = d3.svg.line()
      #.interpolate("basis")
      #.x( (d, i)-> x(now - (n - 1 - i) * duration) )
      #.y( (d, i)-> y(d) )

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

  axis = svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(x.axis = d3.svg.axis().scale(x).orient("bottom"))

  marbleGroup = svg.append("g")
      #.attr("clip-path", "url(#clip)")
    #.append("path")
      #.data([data])
      #.attr("class", "line")

  #d3.select(window)
    #.on("scroll", -> ++count )

  tick = ->
    #// update the domains
    now = new Date()
    x.domain([now - (n - 2) * duration, now - duration])
    #y.domain([0, d3.max(data)])

    #// push the accumulated count onto the back, and reset the count
    # data.push(Math.min(30, count))
    # count = 0;

    #// redraw the line
    #svg.select(".line")
        #.attr("d", line)
        #.attr("transform", null);
    
    marbleGroup.attr("transform",null)

    marbles = marbleGroup.selectAll(".marble")
      .data(data)

    marbles.enter().append("circle")
      .attr("class","marble")
      .attr("r", 20)

    marbles.exit().remove()

    marbles
      .attr("cx", (d)-> x(d) )
      .attr("cy", y(0))

    #// slide the x-axis left
    axis.transition()
        .duration(duration)
        .ease("linear")
        .call(x.axis)

    #// slide the line left
    marbleGroup.transition()
        .duration(duration)
        .ease("linear")
        .attr("transform", "translate(" + x(now - (n - 1) * duration) + ")")
        .each("end", tick)
        
    console.log("translate(" + x(now - (n - 1) * duration) + ")")

    #// pop the old data point off the front
    #data.shift()

  tick()


#$(trackClicks)
$(d3Vis)
