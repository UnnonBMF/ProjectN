@extends('welcome')


@section('content')
   <style>
       #map {
        height:100vh;
        width: 100%;
       }
    </style>
    <div id="map"></div>
   
   <script type="text/javascript">
      function initMap() {
      	//13.876571, 100.411027
        var center = {lat: 13.876571, lng: 100.411027};
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 15,
          center: center
        });

        var marker = new google.maps.Marker({
          position: center,
          map: map
        });


        var flightPlanCoordinates = [
           {lat: 13.874458, lng: 100.412022},
           {lat: 13.876171, lng: 100.409840},
           {lat: 13.880360, lng: 100.409172},
           {lat: 13.878609, lng: 100.409364}
        ];

        var flightPath = new google.maps.Polyline({
          path: flightPlanCoordinates,
          geodesic: true,
          strokeColor: '#FF0000',
          strokeOpacity: 1.0,
          strokeWeight: 2
        });

        flightPath.setMap(map);



        var marker = new google.maps.Marker({
          position:   {lat: 13.874448, lng: 100.413860},
           label: 'A',
           title:'This is title',
          map: map
        });

      }
    </script>

<script type="text/javascript">

      // This example creates a 2-pixel-wide red polyline showing the path of
      // the first trans-Pacific flight between Oakland, CA, and Brisbane,
      // Australia which was made by Charles Kingsford Smith.
      // function initMap() {
      //   var map = new google.maps.Map(document.getElementById('map'), {
      //     zoom: 3,
      //     center: {lat: 0, lng: -180},
      //     mapTypeId: 'terrain'
      //   });

      //   var flightPlanCoordinates = [
      //     {lat: 37.772, lng: -122.214},
      //     {lat: 21.291, lng: -157.821},
      //     {lat: -18.142, lng: 178.431},
      //     {lat: -27.467, lng: 153.027}
      //   ];
      //   var flightPath = new google.maps.Polyline({
      //     path: flightPlanCoordinates,
      //     geodesic: true,
      //     strokeColor: '#FF0000',
      //     strokeOpacity: 1.0,
      //     strokeWeight: 2
      //   });

      //   flightPath.setMap(map);
      // }
 	
    </script>

     <script  async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuppx3pVRSTT42JcTKumOxK0AMcD3ATNg&callback=initMap">
    </script>

@endsection