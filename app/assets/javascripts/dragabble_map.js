  
    var geocoder;
    var map;
    var marker;
    var infowindow = new google.maps.InfoWindow({size: new google.maps.Size(150,50)});
    var loc;
  function clone(obj){
      if(obj == null || typeof(obj) != 'object') return obj;
      var temp = new obj.constructor(); 
      for(var key in obj) temp[key] = clone(obj[key]);
      return temp;
  }

  chineese_address = null;

  function geocodePosition(pos) {
    geocoder.geocode({
      latLng: pos
    }, function(responses) {
      console.log(pos);
      loc = responses ;
      console.log(responses) ;
      if (responses && responses.length > 0) {
        marker.formatted_address = responses[0].formatted_address;
      } else {
        marker.formatted_address = 'Cannot determine address at this location.';
      }
      infowindow.setContent(marker.formatted_address);
      infowindow.open(map, marker);
     
      /*$("#address").val( marker.formatted_address);
      if( responses[responses.length - 2] != undefined ) {
        $("#property_city").val( responses[responses.length - 2].formatted_address);
      }
      if( responses[responses.length - 1] != undefined ) {
        $("#property_district").val( responses[responses.length - 1].formatted_address);
      }else{
        $("#property_district").val( '');
      }*/
    });
  }

  function codeAddress() {
    var address = document.getElementById('address').value;
    geocoder.geocode( { 'address': address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {

        map.setCenter(results[0].geometry.location);
        map.setZoom(15);

        if (marker) {
          marker.setMap(null);
          if (infowindow) infowindow.close();
        }
        marker = new google.maps.Marker({
          map: map,
          draggable: true,
          position: results[0].geometry.location
        });
        $.get("/properties/translate_to_chinese?address=" + results[0].formatted_address, function(result){
          $("#property_chinese_address").val(result);
          $("#property_english_address").val(results[0].formatted_address);
        }) 
        google.maps.event.addListener(marker, 'dragend', function() {
          // updateMarkerStatus('Drag ended');
          //current_zoom_level = map.getZoom();
          //if( current_zoom_level > 15 ){
         //  current_zoom_level = 18;
         //}else{
         //  current_zoom_level = current_zoom_level + 2;
         //}
         //map.setZoom(current_zoom_level);

          geocodePosition(marker.getPosition());

        });
        google.maps.event.addListener(marker, 'click', function() {
          if (marker.formatted_address) {
            infowindow.setContent(marker.formatted_address);
          } else  {
            infowindow.setContent(address);
          }
          infowindow.open(map, marker);
        });
        google.maps.event.trigger(marker, 'click');
      } else {
        alert('Geocode was not successful for the following reason: ' + status);
      }
    });
  }
  $(document).ready(function(){
    if( $("#map_canvas").length != 0 ){
      geocoder = new google.maps.Geocoder();
      var latlng = new google.maps.LatLng(22.263872, 114.180904);
      var mapOptions = {
        zoom: 12,
        minZoom: 12,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      }
      map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);


     google.maps.event.addListener(map, 'click', function() {
       infowindow.close();
     });
    }
  })
