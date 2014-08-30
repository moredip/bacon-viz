visualizeIn = (chart)->
  this.subscribe (event)->
    chart.addNewMarble( event )
  this

if Bacon? and Bacon.Observable?
  Bacon.Observable.prototype.visualizeIn = visualizeIn
