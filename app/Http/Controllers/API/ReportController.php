<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Report;
use Validator;

class ReportController extends Controller
{
    //
    private $report;


	public function __construct(Report $report)
	{
		$this->report = $report;
		
	}

    public function store(Request $request){

    	// $message = $request->input("message");
    	// $user_id = $request->input("user_id");
    	 $validator = Validator::make($request->all(), [
            'message' => 'required',
            'user_id' => 'required',
        ]);

        if ($validator->fails()) {
        	return response()->json([
	    		"status"=>false,
	    		//"message"=>"Request is invalid",
	    		'errors'=> $validator->errors()
	    	]);

           
        }

    	$newReport = $this->report->fill($request->all());
    	if(!$newReport->save()){
    		return response()->json([
	    		"status"=>false,
	    		"message"=>"Save Error"
	    	]);
    	}

    	return response()->json([
    		"status"=>true,
    		"message"=>"Success",
    		"data"=>$newReport
    	]);

    }
}
