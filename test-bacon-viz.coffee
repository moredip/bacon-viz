eventToVal = (e)-> $(e.target).val()

wireUpBasicDemo = ->
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

wireUpSlider = ->
  sliderVal = $('.slider-to-label input')
    .asEventStream( 'input', eventToVal )
    #.toProperty( $('.slider-to-label input').val() )


  throttled = sliderVal
    .throttle(100)
    .visualize("slider value, throttled at 100ms ...")

  parsed = throttled
    .map(parseFloat)
    .visualize("... then parsed as a float ...")

  rounded = parsed
    .map (v)-> Number(v.toFixed(1))
    .visualize("... then rounded to 1 decimal place ...")

wireUpColors = ->
  randomColor = ->
    tinycolor(
      h: Math.random() * 360,
      s: 1
      l: 0.5
    ).toString("rgb")

  stream = Bacon
    .interval(800)
    .map(randomColor)

  stream.visualize('random colors')

$( wireUpBasicDemo )

