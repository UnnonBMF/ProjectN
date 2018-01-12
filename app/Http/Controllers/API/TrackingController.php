<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Checkpoint;
use App\User;
use App\Bus;
use App\Schedules;

class TrackingController extends Controller
{

	private $checkpoint;
	private $user;
	private $bus;
	private $schedules;


	public function __construct(Checkpoint $checkpoint,User $user,Bus $bus,Schedules $schedules)
	{
		$this->checkpoint = $checkpoint;
		$this->user = $user;
		$this->bus = $bus;
		$this->schedules = $schedules;
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

    	$schedules = $this->schedules->where('bus_id',$busId)->whereDate('real_active_date',date('Y-m-d'))->first();
    	if(!isset($schedules)){
    		return response()->json([
    			'status' => false,
    			'message' =>'schedules not found',
    			'data' => $request->all()
    		]);
    	}


    	$requestAll = $request->all();
    	$requestAll['map_id'] = $schedules->map_id;
    	$requestAll['schedules_id'] = $schedules->schedules_id;

    	// match data to model


    	$newCheckpoint = $this->checkpoint->fill($requestAll);

    	// save data into database

    	if(!$newCheckpoint->save()){
    		// fail 
    		return response()->json([
    			'status' => false,
    			'message' =>'',
    			'data' => $newCheckpoint
    		]);
    	}

    	return response()->json([
			'status' => true,
			'message' =>'insert completed',
			'data' => $newCheckpoint
		]);

    }


}
