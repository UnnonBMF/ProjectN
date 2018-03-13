<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Checkpoint;
use App\User;
use App\Bus;
use App\Schedules;
use App\Map;
use GuzzleHttp\Client;
class TrackingController extends Controller
{

	private $checkpoint;
	private $user;
	private $bus;
	private $schedules;
    private $map;


	public function __construct(Checkpoint $checkpoint,User $user,Bus $bus,Schedules $schedules,Map $map)
	{
		$this->checkpoint = $checkpoint;
		$this->user = $user;
		$this->bus = $bus;
		$this->schedules = $schedules;
        $this->map = $map;
	}

    //
    public function store(Request $request){
    	$newUser = $request->input('user_id');
    	// First() : select bus_id from bus where user_id = '$newUser' limit 1 => bus->bus_id
    	// Get() : select bus_id from bus where user_id = '$newUser'  => array 
    	$bus = $this->bus->where('user_id',$newUser)->first();
    	if(!isset($bus)){
    		return response()->json([
    			'status' => false,
    			'message' =>'bus not found',
    			'data' => $request->all()
    		]);
    	}

    	$busId = $bus->bus_id;

    	$schedules = $this->schedules->where('bus_id',$busId)
    								 ->whereDate('real_active_date',date('Y-m-d'))
    								 ->first();
    	if(!isset($schedules)){
    		return response()->json([
    			'status' => false,
    			'message' =>'schedules not found',
    			'data' => $request->all()
    		]);
    	}

        $mapdata = $this->map->where('map_id', $schedules->map_id)->first();
        $distance = $this->distancematrix($mapdata,$request->input('latitude'),$request->input('longitude'));
        //return response()->json( $distance);

    	$requestAll = $request->all();
    	$requestAll['map_id'] = $schedules->map_id;
    	$requestAll['schedules_id'] = $schedules->schedules_id;
        $requestAll['duration'] = $distance['duration'];
        $requestAll['distance'] = $distance['distance'];


    	// match data to model
    	$newCheckpoint = $this->checkpoint->fill($requestAll);

    	// save data into database

    	if(!$newCheckpoint->save()){
    		// fail 
    		return response()->json([
    			'status' => false,
    			'message' =>'failed checking save',
    			'data' => $newCheckpoint
    		]);
    	}

    	return response()->json([
			'status' => true,
			'message' =>'insert completed',
			'data' => $newCheckpoint
		]);

    }

    private function distancematrix($map,$latitude,$longitude){

        $output = [];
        $client = new Client([]);

        $request = new \GuzzleHttp\Psr7\Request('GET', 'https://maps.googleapis.com/maps/api/distancematrix/json');
        $response = $client->send($request, ['timeout' => 2,
                'query'=> [
                    'origins' =>$latitude.','.$longitude,
                    'destinations' =>$map->destination,
                    'key'=> 'AIzaSyCFHiWh9Ki23zYMDAN2u3At8qyEqRqgIKo'
                ]
        ]);

        $body = $response->getBody();

        $data = json_decode($body);

        $output['distance'] = $data->rows[0]->elements[0]->distance->text;
        $output['duration'] =$data->rows[0]->elements[0]->duration->text;
        return $output;
    }


}
    