<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});



Route::get('/tracking', function(){
	return response()->json(['a' => 'b']);
} );

Route::post('/tracking', 'API\TrackingController@store' );

Route::post('/account', 'API\LoginController@store' );

Route::post('/report', 'API\ReportController@store' );

