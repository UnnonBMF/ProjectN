<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Checkpoint extends Model
{
    //
    protected $table = 'checkpoint_field';

    public $timestamps = false;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['latitude' , 'longitude' , 'schedules_id' , 'map_id'];
}
