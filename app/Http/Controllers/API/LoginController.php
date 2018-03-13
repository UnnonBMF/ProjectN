<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\User;

class LoginController extends Controller
{
    //
    private $user;

    public function __construct(User $user)
	{
		$this->user = $user;
	}

	public function store(Request $request){
		$username = $request->input('username');
		$password = $request->input('password');

		$user = $this->user->where('username',$username)->where('password',md5($password))->first();
		if(!isset($user)){
			return response()->json([
    			'status' => false,
    			'message' =>'username or password incorrect',
    			'data' => $request->all()
    		]);
		}

		return response()->json([
			'status' => true,
			'message' =>'success',
			'data' => $user
		]);
	}

}
