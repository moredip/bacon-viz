global = this

openPopup= ->
  popup = window.open( '', 'Bacon-Viz', 'width=400,height=300' )
  return undefined unless popup?

  appendContent = (content)->
    p = popup.document.createElement("p")
    p.innerText = content
    popup.document.body.appendChild(p)

  {
    appendContent
  }


popuper = ->
  popup = undefined
  ->
    unless popup?
      popup = openPopup() 
    popup

createVisualizer = ->
  withPopup = popuper()
  console.log "creating visualizer"

  recordBaconEvent = (event)->
    withPopup().appendContent("event! - " + event )


  {
    recordBaconEvent
  }


global.BaconViz ?= {}
global.BaconViz.createVisualizer = createVisualizer
