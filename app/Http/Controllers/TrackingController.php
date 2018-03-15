<?php

namespace App\Http\Controllers;

use App\Checkpoint;
use App\Map;
use App\Schedules;
use GuzzleHttp\Client;
use Illuminate\Http\Request;

class TrackingController extends Controller {
	private $checkpoint;
	private $schedules;
	private $map;

	public function __construct(Checkpoint $checkpoint, Schedules $schedules, Map $map) {
		$this->checkpoint = $checkpoint;
		$this->schedules = $schedules;
		$this->map = $map;
	}

	public function all(Request $request) {

	}

	/**
	 * index main.
	 *
	 * @param  Request  $request
	 * @return Response
	 */
	public function index(Request $reqeust) {
		$data = [];
		// get bus_id in request

		return view('tracking.index', compact('data'));
	}

	/**
	 * json main.
	 *
	 * @param  Request  $request
	 * @return Response
	 */
	public function json(Request $request) {
		$last_id = 0;
		$list = [];

		$schedules = $this->schedules
			->whereDate('real_active_date', date('Y-m-d'))->get();

		foreach ($schedules as $key => $schedule) {
			# find checkpoint field
			$data = $this->checkpoint
				->where('schedules_id', $schedule->schedules_id)
				->orderBy('check_id', 'asc')->get();

			foreach ($data as $key => $item) {
				$item->lat = floatval($item->latitude);
				$item->lng = floatval($item->longitude);
			}

			$schedule->checkpoints = $data;
			# find bus detail
			$schedule->bus_data = $schedule->bus;

		}
        
		return response()->json(['data' => $schedules, 'last' => $last_id]);
	}

	public function show($bus_id, Request $request) {
		$data = [];
		// get bus_id in request

		if (isset($bus_id)) {
			$schedules = $this->schedules->where('bus_id', $bus_id)
				->whereDate('real_active_date', date('Y-m-d'))
				->first();

			if (!isset($schedules)) {
				return redirect()->route('tracking.index')->withErrors(['message' => 'schedules not found']);
			}

			$data = $this->checkpoint->where('schedules_id', $schedules->schedules_id)->get();

		}

		return view('tracking.index', compact('data'));
	}

	// update ?
	public function update($last, Request $request) {
		// get last detail by id
		$data = $this->checkpoint->where('check_id', $last)->first();
		$schedules_id = $data->schedules_id;
		$map_id = $data->map_id;

		$lastdata = $this->checkpoint->where('check_id', '>', $last)
			->where('schedules_id', $schedules_id)
			->where('map_id', $map_id)->orderBy('check_id', 'desc')->first();

		$mapdata = $this->map->where('map_id', $map_id)->first();

		if ($lastdata == null) {
			$lastdata = $data;
		}

		$distance = $this->distancematrix($mapdata, $lastdata->latitude, $lastdata->longitude);
		$lastdata->duration = $distance['duration'];
		$lastdata->distance = $distance['distance'];
		$lastdata->save();

		// find checkpoint > last_id and map_id and schedule
		$dataUpdate = $this->checkpoint->where('check_id', '>', $last)
			->where('schedules_id', $schedules_id)
			->where('map_id', $map_id)->get();

		return response()->json($dataUpdate);
		// return json

	}

	//connect google api
	private function distancematrix($map, $latitude, $longitude) {

		$output = [];
		$client = new Client([]);

		$request = new \GuzzleHttp\Psr7\Request('GET', 'https://maps.googleapis.com/maps/api/distancematrix/json');
		$response = $client->send($request, ['timeout' => 2,
			'query' => [
				'origins' => $latitude . ',' . $longitude,
				'destinations' => $map->destination,
				'key' => 'AIzaSyCFHiWh9Ki23zYMDAN2u3At8qyEqRqgIKo',
			],
		]);

		$body = $response->getBody();

		$data = json_decode($body);

		$output['distance'] = $data->rows[0]->elements[0]->distance->text;
		$output['duration'] = $data->rows[0]->elements[0]->duration->text;
		return $output;
	}

}
