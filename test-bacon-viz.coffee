$ ->
  $('body')
    .asEventStream('click')
    .map("POP!")
    .visualize("all clicks")

  mouseMoves = $('body > h1')
    .asEventStream('mousemove')

  mouseMoves
    .throttle(100)
    .visualize("moves throttled to 100ms")

  mouseMoves
    .throttle(1000)
    .visualize("moves throttled to 1000ms")
