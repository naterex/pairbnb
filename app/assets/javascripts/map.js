function initMap() {
  // console.log("GOOGLE MAPS LAH");

  var myLatLng = {lat: 34.012197, lng: -117.859657};

  var map = new google.maps.Map(document.getElementById('map'), {
    center: myLatLng,
    zoom: 14,
    styles: [{
      featureType: 'poi',
      stylers: [{ visibility: 'off' }]  // Turn off points of interest.
    }, {
      featureType: 'transit.station',
      stylers: [{ visibility: 'off' }]  // Turn off bus stations, train stations, etc.
    }],
    disableDoubleClickZoom: true
  });

  var marker = new google.maps.Marker({
      position: myLatLng,
      map: map,
      title: '<%= @listing.address %>'
    });
}
