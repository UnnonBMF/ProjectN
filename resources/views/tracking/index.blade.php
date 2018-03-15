@extends('welcome')
@section('content')
<style>
   #map {
    height:100vh;
   /* width: 100%;*/
   }
   .duration{
    position: absolute;
    bottom: 10px;
    z-index: 999;
    padding: 15px;
   }
   .my-icon{
     position: absolute;
     right: 10px;
      bottom: 10px;
      z-index: 999;
   }
</style>
<div class="row">
  <div class="col-sm-2" id="nav">
    <ul class="nav flex-column">
      <li class="nav-item"><a class="nav-link text-center"  href="{{ route('tracking.index') }}/1">BUS 1</a></li>
      <li class="nav-item"><a class="nav-link text-center"  href="{{ route('tracking.index') }}/2">BUS 2</a></li>
      <li class="nav-item"><a class="nav-link text-center"  href="{{ route('tracking.index') }}/3">BUS 3</a></li>
      <li class="nav-item"><a class="nav-link text-center"  href="{{ route('tracking.index') }}/4">BUS 4</a></li>
      <li class="nav-item"><a class="nav-link text-center"  href="{{ route('tracking.index') }}/5">BUS 5</a></li>
      <li class="nav-item"><a class="nav-link text-center"  href="#" onclick="initMapAll()" >All Bus</a></li>
    </ul>
    <div class="duration">
      <ul class="nav flex-column">
        <li class="nav-item"><a class="nav-link disabled" href="#" id='duration'></a></li>
        <li class="nav-item"><a class="nav-link disabled" href="#" id='distance'></a></li>
      </ul>
    </div>
  </div>

  <div id="map" class="col-sm-10">

  </div>
 {{--  <div class="my-icon">
    <button type="button" onclick="MenuToggle()"></button>">
      <span class="oi oi-grid-two-up">aa</span>
    </button>
  </div> --}}
</div>

  <script type="text/javascript">
    var MenuToggle = function(){
      $('#nav').toggle("slow", function() {
        // Animation complete.
      });
    }
  </script>

  <script type="text/javascript">
      var flightPath;
      var flightPlanCoordinates;
      var last;
      var markerLast;
      var center;
      var map;
      var zoom;

      var distance = $('#distance');
      var duration = $('#duration');

      function initMap() {
      	//13.876571, 100.411027

        center = {lat: 13.739965 , lng: 100.538277 };

        @if(count($data) > 0)
          <?php $first = $data->first();?>
           center = {lat: {{ $first->latitude }} , lng: {{ $first->longitude }} };
        @endif

        map = new google.maps.Map(document.getElementById('map'), {
          zoom: 13,
          center:center
        });
         @if(count($data) > 0)
        var marker = new google.maps.Marker({
            position: center,
            title:'Start',
            label: 'S',
            map: map
        });
        @endif

        flightPlanCoordinates = [
           @foreach($data as $item)
            { lat: {{ $item->latitude }}, lng: {{ $item->longitude }} , id: {{ $item->check_id or '' }} },
           @endforeach
        ];

        flightPath = new google.maps.Polyline({
          path: flightPlanCoordinates,
          geodesic: true,
          strokeColor: '#FF0000',
          strokeOpacity: 1.0,
          strokeWeight: 2
        });

        flightPath.setMap(map);

        @if(count($data)>0)
        <?php
$last = $data->last();
?>

        last = {lat: {{ $last->latitude }} , lng: {{ $last->longitude }} , id: {{ $item->check_id or '' }}  }
        duration.html('{{ $last->duration }}');
        distance.html('{{ $last->distance }}');
        markerLast = new google.maps.Marker({
          position: last ,
           label: 'L',
           title:'Last',
          map: map
        });
        @endif

      }

      setInterval(function () {
          updateLatLng(last , map , markerLast , duration , distance);
      },(1000*30)*1);

      function updateLatLng(last, map, markerLast, duration , distance){
        var id = last.id;
        $.ajax({
          url: '{{ route('tracking.index') }}/'+id+'/update',
          method: 'GET',
          success : function(data){
            console.log('success', data);
            if(data == null){
              return
            }
            addLatLng(data, map, markerLast, duration , distance);
          },
          error: function(err){
            console.log('error' , err);
          }
        })
      }

        // Handles click events on a map, and adds a new point to the Polyline.
      function addLatLng(locations , map, markerLast, duration , distance) {
        if(locations.length == 0) {
          return
        }

        var lastindex = locations.length-1;
        locations.forEach(function(location , index){
          // var center = {lat: 13.739965 , lng: 100.538277 };
          var point = {lat: parseFloat(location.latitude) , lng: parseFloat(location.longitude) , id: parseInt(location.check_id)};

          flightPlanCoordinates.push(point);

          if(index == lastindex){
            last = {lat: parseFloat(location.latitude) , lng: parseFloat(location.longitude), id: parseInt(location.check_id)};
            center = {lat: parseFloat(location.latitude) , lng: parseFloat(location.longitude), id: parseInt(location.check_id)};
            duration.html(location.duration);
            distance.html(location.distance);
          }
        })

        // zoom = map.getZoom();
        // var map = new google.maps.Map(document.getElementById('map'), {
        //   zoom: zoom,
        //   center:center
        // });


        // Because path is an MVCArray, we can simply append a new coordinate
        // and it will automatically appear.
        var flightPath = new google.maps.Polyline({
          path: flightPlanCoordinates,
          geodesic: true,
          strokeColor: '#FF0000',
          strokeOpacity: 1.0,
          strokeWeight: 2
        });

        flightPath.setMap(map);

        markerLast.setPosition(last);

      }

  </script>
  <!-- All -->
  <script type="text/javascript">
    var map;
    var polylines = [];
    var last = 0;

    function initMapAll() {
      map = new google.maps.Map(document.getElementById('map'), {
        center : {lat: 13.739965 , lng: 100.538277 },
        mapTypeId: 'terrain',
        zoom: 13,
      });

      getDataAll(last, map, polylines);
    }

    function getDataAll(last, map, polylines){
      $.ajax({
         url: '{{ route('tracking.json') }}?id='+last,
          method: 'GET',
          success : function(resp){
            if(resp == null) return
            last = resp.last;
            setInterval(function () {
              updateDataAll(last, map, polylines);
            },(1000*30)*1);

            displayAll(resp.data, map, polylines);
          },
          error: function(err){
            console.log('error' , err);
          }
      });
    }

    function updateDataAll(last, map, polylines){
      $.ajax({
         url: '{{ route('tracking.json') }}?id='+last,
          method: 'GET',
          success : function(resp){
            if(resp == null) return
            last = resp.last;
            displayAll(resp.data, map, polylines);
          },
          error: function(err){
            console.log('error' , err);
          }
      });
    }

    function displayAll(data, map, polylines){
      data.forEach(function(ele,index){
        console.log('index' , index , 'ele', ele);
        polylines[index] = new google.maps.Polyline({
          path: ele.checkpoints,
          geodesic: true,
          strokeColor: ele.bus_data.color,
          strokeOpacity: 1.0,
          strokeWeight: 2
        });
      })

      data.forEach(function(ele,index){
         polylines[index].setMap(map);
      })

      //map.panTo(data[0].checkpoints[0]);
    }

  </script>

  <script  async defer
  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDuppx3pVRSTT42JcTKumOxK0AMcD3ATNg&callback=initMap">
  </script>

@endsection