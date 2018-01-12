<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Schedules extends Model
{
    //
     protected $table = 'schedules';

    public $timestamps = false;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['start' , 'goal' , 'map_id' , 'bus_id' , 'real_active_date'];
}
