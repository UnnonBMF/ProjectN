<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class TrackingController extends Controller
{
 	/**
     * index main.
     *
     * @param  Request  $request
     * @return Response
     */
    public function index(Request $reqeust){
    	return view('tracking.index');
    }
}
