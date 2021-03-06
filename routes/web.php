<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
 */

Route::get('/', function () {
	return view('welcome');
});

Route::get('/check', function () {
	//$users = \DB::table('user')->where('user_id',1)->get();
	$users = App\User::where('user_id', 1)->get();
	$locations = [];
//  $locations = App\Location::all();
	return response()->json([
		'user' => $users,
		'location' => $locations,
	]);
});

Route::get('/tracking', 'TrackingController@index')->name('tracking.index');

Route::get('/tracking/{bus_id}', 'TrackingController@show')->name('tracking.show');

Route::get('/tracking/json/all', 'TrackingController@json')->name('tracking.json');

Route::get('/tracking/{check_id}/update', 'TrackingController@update')->name('tracking.update');