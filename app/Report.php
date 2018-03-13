<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Report extends Model
{
    ////
    protected $table = 'report';

    public $timestamps = false;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['message' , 'user_id' ];
}
