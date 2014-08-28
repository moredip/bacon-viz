(function() {
  var BaconVis, d3Vis, trackClicks, visualizer;

  BaconVis = window.BaconVis;

  visualizer = BaconVis.createVisualizer();

  trackClicks = function() {
    return $('body').asEventStream('click').map('you clicked!!!').doAction(visualizer.recordBaconEvent).log();
  };

  d3Vis = function() {
    var data, height, line, margin, n, path, random, svg, tick, width, x, y;
    n = 40;
    random = d3.random.normal(0, .2);
    data = d3.range(n).map(random);
    margin = {
      top: 20,
      right: 20,
      bottom: 20,
      left: 40
    };
    width = 960 - margin.left - margin.right;
    height = 500 - margin.top - margin.bottom;
    x = d3.scale.linear().domain([0, n - 1]).range([0, width]);
    y = d3.scale.linear().domain([-1, 1]).range([height, 0]);
    line = d3.svg.line().x(function(d, i) {
      return x(i);
    }).y(function(d, i) {
      return y(d);
    });
    svg = d3.select("svg#marbles").attr("width", width + margin.left + margin.right).attr("height", height + margin.top + margin.bottom).append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");
    svg.append("defs").append("clipPath").attr("id", "clip").append("rect").attr("width", width).attr("height", height);
    svg.append("g").attr("class", "x axis").attr("transform", "translate(0," + (y(0)) + ")").call(d3.svg.axis().scale(x).orient("bottom"));
    svg.append("g").attr("class", "y axis").call(d3.svg.axis().scale(y).orient("left"));
    path = svg.append("g").attr("clip-path", "url(#clip)").append("path").datum(data).attr("class", "line").attr("d", line);
    tick = function() {
      data.push(random());
      path.attr("d", line).attr("transform", null).transition().duration(500).ease("linear").attr("transform", "translate(" + (x(-1)) + ",0)").each("end", tick);
      return data.shift();
    };
    return tick();
  };

  $(d3Vis);

}).call(this);

//# sourceMappingURL=data:application/json;base64,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QSxJQUFJLENBQUMsSUFBTCxDQUFVLE1BQUEsQ0FBQSxDQUFWLENBQUEsQ0FBQTtBQUFBLE1BR0EsSUFDSSxDQUFDLElBREwsQ0FDVSxHQURWLEVBQ2UsSUFEZixDQUVJLENBQUMsSUFGTCxDQUVVLFdBRlYsRUFFdUIsSUFGdkIsQ0FHRSxDQUFDLFVBSEgsQ0FBQSxDQUlJLENBQUMsUUFKTCxDQUljLEdBSmQsQ0FLSSxDQUFDLElBTEwsQ0FLVSxRQUxWLENBTUksQ0FBQyxJQU5MLENBTVUsV0FOVixFQU13QixZQUFBLEdBQVcsQ0FBQSxDQUFBLENBQUUsQ0FBQSxDQUFGLENBQUEsQ0FBWCxHQUFrQixLQU4xQyxDQU9JLENBQUMsSUFQTCxDQU9VLEtBUFYsRUFPaUIsSUFQakIsQ0FIQSxDQUFBO2FBYUEsSUFBSSxDQUFDLEtBQUwsQ0FBQSxFQWhCSztJQUFBLENBaERQLENBQUE7V0FrRUEsSUFBQSxDQUFBLEVBbkVNO0VBQUEsQ0FYUixDQUFBOztBQUFBLEVBaUZBLENBQUEsQ0FBRSxLQUFGLENBakZBLENBQUE7QUFBQSIsImZpbGUiOiJ0ZXN0LWJhY29uLXZpcy5qcyIsInNvdXJjZVJvb3QiOiIvc291cmNlLyIsInNvdXJjZXNDb250ZW50IjpbIkJhY29uVmlzID0gd2luZG93LkJhY29uVmlzXG52aXN1YWxpemVyID0gQmFjb25WaXMuY3JlYXRlVmlzdWFsaXplcigpXG5cbnRyYWNrQ2xpY2tzID0gLT5cbiAgJCgnYm9keScpXG4gICAgLmFzRXZlbnRTdHJlYW0oJ2NsaWNrJylcbiAgICAubWFwKCAneW91IGNsaWNrZWQhISEnIClcbiAgICAuZG9BY3Rpb24oIHZpc3VhbGl6ZXIucmVjb3JkQmFjb25FdmVudCApXG4gICAgLmxvZygpXG5cblxuZDNWaXMgPSAtPlxuICBuID0gNDBcbiAgcmFuZG9tID0gZDMucmFuZG9tLm5vcm1hbCgwLCAuMilcbiAgZGF0YSA9IGQzLnJhbmdlKG4pLm1hcChyYW5kb20pXG4gXG4gIG1hcmdpbiA9IHt0b3A6IDIwLCByaWdodDogMjAsIGJvdHRvbTogMjAsIGxlZnQ6IDQwfVxuICB3aWR0aCA9IDk2MCAtIG1hcmdpbi5sZWZ0IC0gbWFyZ2luLnJpZ2h0XG4gIGhlaWdodCA9IDUwMCAtIG1hcmdpbi50b3AgLSBtYXJnaW4uYm90dG9tXG4gXG4gIHggPSBkMy5zY2FsZS5saW5lYXIoKVxuICAgICAgLmRvbWFpbihbMCwgbiAtIDFdKVxuICAgICAgLnJhbmdlKFswLCB3aWR0aF0pXG4gXG4gIHkgPSBkMy5zY2FsZS5saW5lYXIoKVxuICAgICAgLmRvbWFpbihbLTEsIDFdKVxuICAgICAgLnJhbmdlKFtoZWlnaHQsIDBdKVxuICAgXG4gIGxpbmUgPSBkMy5zdmcubGluZSgpXG4gICAgICAueCggKGQsIGkpLT4geChpKSApXG4gICAgICAueSggKGQsIGkpLT4geShkKSApIFxuICAgXG4gIHN2ZyA9IGQzLnNlbGVjdChcInN2ZyNtYXJibGVzXCIpXG4gICAgICAuYXR0cihcIndpZHRoXCIsIHdpZHRoICsgbWFyZ2luLmxlZnQgKyBtYXJnaW4ucmlnaHQpXG4gICAgICAuYXR0cihcImhlaWdodFwiLCBoZWlnaHQgKyBtYXJnaW4udG9wICsgbWFyZ2luLmJvdHRvbSlcbiAgICAuYXBwZW5kKFwiZ1wiKVxuICAgICAgLmF0dHIoXCJ0cmFuc2Zvcm1cIiwgXCJ0cmFuc2xhdGUoI3ttYXJnaW4ubGVmdH0sI3ttYXJnaW4udG9wfSlcIilcbiAgIFxuICBzdmcuYXBwZW5kKFwiZGVmc1wiKS5hcHBlbmQoXCJjbGlwUGF0aFwiKVxuICAgICAgLmF0dHIoXCJpZFwiLCBcImNsaXBcIilcbiAgICAuYXBwZW5kKFwicmVjdFwiKVxuICAgICAgLmF0dHIoXCJ3aWR0aFwiLCB3aWR0aClcbiAgICAgIC5hdHRyKFwiaGVpZ2h0XCIsIGhlaWdodClcbiAgIFxuICBzdmcuYXBwZW5kKFwiZ1wiKVxuICAgICAgLmF0dHIoXCJjbGFzc1wiLCBcInggYXhpc1wiKVxuICAgICAgLmF0dHIoXCJ0cmFuc2Zvcm1cIiwgXCJ0cmFuc2xhdGUoMCwje3koMCl9KVwiKVxuICAgICAgLmNhbGwoZDMuc3ZnLmF4aXMoKS5zY2FsZSh4KS5vcmllbnQoXCJib3R0b21cIikpXG4gICBcbiAgc3ZnLmFwcGVuZChcImdcIilcbiAgICAgIC5hdHRyKFwiY2xhc3NcIiwgXCJ5IGF4aXNcIilcbiAgICAgIC5jYWxsKGQzLnN2Zy5heGlzKCkuc2NhbGUoeSkub3JpZW50KFwibGVmdFwiKSlcbiAgIFxuICBwYXRoID0gc3ZnLmFwcGVuZChcImdcIilcbiAgICAgIC5hdHRyKFwiY2xpcC1wYXRoXCIsIFwidXJsKCNjbGlwKVwiKVxuICAgIC5hcHBlbmQoXCJwYXRoXCIpXG4gICAgICAuZGF0dW0oZGF0YSlcbiAgICAgIC5hdHRyKFwiY2xhc3NcIiwgXCJsaW5lXCIpXG4gICAgICAuYXR0cihcImRcIiwgbGluZSlcbiAgIFxuICB0aWNrID0gLT5cbiAgIFxuICAgICMgcHVzaCBhIG5ldyBkYXRhIHBvaW50IG9udG8gdGhlIGJhY2tcbiAgICBkYXRhLnB1c2gocmFuZG9tKCkpXG4gICBcbiAgICAjIHJlZHJhdyB0aGUgbGluZSwgYW5kIHNsaWRlIGl0IHRvIHRoZSBsZWZ0XG4gICAgcGF0aFxuICAgICAgICAuYXR0cihcImRcIiwgbGluZSlcbiAgICAgICAgLmF0dHIoXCJ0cmFuc2Zvcm1cIiwgbnVsbClcbiAgICAgIC50cmFuc2l0aW9uKClcbiAgICAgICAgLmR1cmF0aW9uKDUwMClcbiAgICAgICAgLmVhc2UoXCJsaW5lYXJcIilcbiAgICAgICAgLmF0dHIoXCJ0cmFuc2Zvcm1cIiwgXCJ0cmFuc2xhdGUoI3t4KC0xKX0sMClcIilcbiAgICAgICAgLmVhY2goXCJlbmRcIiwgdGljayk7XG4gICBcbiAgICAjIHBvcCB0aGUgb2xkIGRhdGEgcG9pbnQgb2ZmIHRoZSBmcm9udFxuICAgIGRhdGEuc2hpZnQoKVxuICAgXG4gIHRpY2soKVxuXG4jJCh0cmFja0NsaWNrcylcbiQoZDNWaXMpXG4iXX0=