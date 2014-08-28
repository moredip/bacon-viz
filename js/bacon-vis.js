(function() {
  var createVisualizer, global, openPopup, popuper;

  global = this;

  openPopup = function() {
    var appendContent, popup;
    popup = window.open('', 'Bacon-Vis', 'width=400,height=300');
    if (popup == null) {
      return void 0;
    }
    appendContent = function(content) {
      var p;
      p = popup.document.createElement("p");
      p.innerText = content;
      return popup.document.body.appendChild(p);
    };
    return {
      appendContent: appendContent
    };
  };

  popuper = function() {
    var popup;
    popup = void 0;
    return function() {
      if (popup == null) {
        popup = openPopup();
      }
      return popup;
    };
  };

  createVisualizer = function() {
    var recordBaconEvent, withPopup;
    withPopup = popuper();
    console.log("creating visualizer");
    recordBaconEvent = function(event) {
      return withPopup().appendContent("event! - " + event);
    };
    return {
      recordBaconEvent: recordBaconEvent
    };
  };

  if (global.BaconVis == null) {
    global.BaconVis = {};
  }

  global.BaconVis.createVisualizer = createVisualizer;

}).call(this);

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbInZpc3VhbGl6ZXIuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FBQUEsTUFBQSw0Q0FBQTs7QUFBQSxFQUFBLE1BQUEsR0FBUyxJQUFULENBQUE7O0FBQUEsRUFFQSxTQUFBLEdBQVcsU0FBQSxHQUFBO0FBQ1QsUUFBQSxvQkFBQTtBQUFBLElBQUEsS0FBQSxHQUFRLE1BQU0sQ0FBQyxJQUFQLENBQWEsRUFBYixFQUFpQixXQUFqQixFQUE4QixzQkFBOUIsQ0FBUixDQUFBO0FBQ0EsSUFBQSxJQUF3QixhQUF4QjtBQUFBLGFBQU8sTUFBUCxDQUFBO0tBREE7QUFBQSxJQUdBLGFBQUEsR0FBZ0IsU0FBQyxPQUFELEdBQUE7QUFDZCxVQUFBLENBQUE7QUFBQSxNQUFBLENBQUEsR0FBSSxLQUFLLENBQUMsUUFBUSxDQUFDLGFBQWYsQ0FBNkIsR0FBN0IsQ0FBSixDQUFBO0FBQUEsTUFDQSxDQUFDLENBQUMsU0FBRixHQUFjLE9BRGQsQ0FBQTthQUVBLEtBQUssQ0FBQyxRQUFRLENBQUMsSUFBSSxDQUFDLFdBQXBCLENBQWdDLENBQWhDLEVBSGM7SUFBQSxDQUhoQixDQUFBO1dBUUE7QUFBQSxNQUNFLGVBQUEsYUFERjtNQVRTO0VBQUEsQ0FGWCxDQUFBOztBQUFBLEVBZ0JBLE9BQUEsR0FBVSxTQUFBLEdBQUE7QUFDUixRQUFBLEtBQUE7QUFBQSxJQUFBLEtBQUEsR0FBUSxNQUFSLENBQUE7V0FDQSxTQUFBLEdBQUE7QUFDRSxNQUFBLElBQU8sYUFBUDtBQUNFLFFBQUEsS0FBQSxHQUFRLFNBQUEsQ0FBQSxDQUFSLENBREY7T0FBQTthQUVBLE1BSEY7SUFBQSxFQUZRO0VBQUEsQ0FoQlYsQ0FBQTs7QUFBQSxFQXVCQSxnQkFBQSxHQUFtQixTQUFBLEdBQUE7QUFDakIsUUFBQSwyQkFBQTtBQUFBLElBQUEsU0FBQSxHQUFZLE9BQUEsQ0FBQSxDQUFaLENBQUE7QUFBQSxJQUNBLE9BQU8sQ0FBQyxHQUFSLENBQVkscUJBQVosQ0FEQSxDQUFBO0FBQUEsSUFHQSxnQkFBQSxHQUFtQixTQUFDLEtBQUQsR0FBQTthQUNqQixTQUFBLENBQUEsQ0FBVyxDQUFDLGFBQVosQ0FBMEIsV0FBQSxHQUFjLEtBQXhDLEVBRGlCO0lBQUEsQ0FIbkIsQ0FBQTtXQU9BO0FBQUEsTUFDRSxrQkFBQSxnQkFERjtNQVJpQjtFQUFBLENBdkJuQixDQUFBOzs7SUFvQ0EsTUFBTSxDQUFDLFdBQVk7R0FwQ25COztBQUFBLEVBcUNBLE1BQU0sQ0FBQyxRQUFRLENBQUMsZ0JBQWhCLEdBQW1DLGdCQXJDbkMsQ0FBQTtBQUFBIiwiZmlsZSI6InZpc3VhbGl6ZXIuanMiLCJzb3VyY2VSb290IjoiL3NvdXJjZS8iLCJzb3VyY2VzQ29udGVudCI6WyJnbG9iYWwgPSB0aGlzXG5cbm9wZW5Qb3B1cD0gLT5cbiAgcG9wdXAgPSB3aW5kb3cub3BlbiggJycsICdCYWNvbi1WaXMnLCAnd2lkdGg9NDAwLGhlaWdodD0zMDAnIClcbiAgcmV0dXJuIHVuZGVmaW5lZCB1bmxlc3MgcG9wdXA/XG5cbiAgYXBwZW5kQ29udGVudCA9IChjb250ZW50KS0+XG4gICAgcCA9IHBvcHVwLmRvY3VtZW50LmNyZWF0ZUVsZW1lbnQoXCJwXCIpXG4gICAgcC5pbm5lclRleHQgPSBjb250ZW50XG4gICAgcG9wdXAuZG9jdW1lbnQuYm9keS5hcHBlbmRDaGlsZChwKVxuXG4gIHtcbiAgICBhcHBlbmRDb250ZW50XG4gIH1cblxuXG5wb3B1cGVyID0gLT5cbiAgcG9wdXAgPSB1bmRlZmluZWRcbiAgLT5cbiAgICB1bmxlc3MgcG9wdXA/XG4gICAgICBwb3B1cCA9IG9wZW5Qb3B1cCgpIFxuICAgIHBvcHVwXG5cbmNyZWF0ZVZpc3VhbGl6ZXIgPSAtPlxuICB3aXRoUG9wdXAgPSBwb3B1cGVyKClcbiAgY29uc29sZS5sb2cgXCJjcmVhdGluZyB2aXN1YWxpemVyXCJcblxuICByZWNvcmRCYWNvbkV2ZW50ID0gKGV2ZW50KS0+XG4gICAgd2l0aFBvcHVwKCkuYXBwZW5kQ29udGVudChcImV2ZW50ISAtIFwiICsgZXZlbnQgKVxuXG5cbiAge1xuICAgIHJlY29yZEJhY29uRXZlbnRcbiAgfVxuXG5cbmdsb2JhbC5CYWNvblZpcyA/PSB7fVxuZ2xvYmFsLkJhY29uVmlzLmNyZWF0ZVZpc3VhbGl6ZXIgPSBjcmVhdGVWaXN1YWxpemVyXG4iXX0=