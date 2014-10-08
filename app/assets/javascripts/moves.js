// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
  var handler;
  if ($('#map').length > 0) {
    handler = Gmaps.build('Google');
    return handler.buildMap({
      provider: {},
      internal: {
        id: 'map'
      }
    }, function() {
      var markers, places, polyline;
      markers = handler.addMarkers(gon.markers);
      places = handler.addMarkers(gon.places);
      polyline = handler.addPolyline(gon.track_points);
      handler.bounds.extendWith(places);
      return handler.fitMapToBounds();
    });
  }
});