#!/usr/bin/bash

# video_file=~/VLC_stuff/2015bsVriot.mp4
# output_path = ~/VLC_stuff/frames/2015bsVriot_play/

# sh excerpt.sh ~/VLC_stuff/2015bsVriot.mp4 ~/VLC_stuff/frames/TEST/ 600 5

# -----------------------------------------------
# Configuration
# -----------------------------------------------

digits='^[0-9]+$'
FILE_PREFIX='frame_'
REQUIRED_ARGS=2
FINE_GRAINED=3    # About 10 frames per second
COURSE_GRAINED=30 # About 1 frame per second
DEFAULT_FRAME_RATIO=$FINE_GRAINED
FRAME_RATIO=$DEFAULT_FRAME_RATIO
  
# -----------------------------------------------
# Get input arguments
# -----------------------------------------------

video_file=$1
output_path=$2
start_time_seconds=$3
run_time_seconds=$4
frame_ratio=$5

# -----------------------------------------------
# Validate input arguments
# -----------------------------------------------

if ! [ -z ${3+x} ] && ! [[ $start_time_seconds =~ $digits ]] ; then
 echo "\n*** start_time_seconds must be an integer ***\n" >&2; exit 1
fi

if ! [ -z ${4+x} ] && ! [[ $run_time_seconds =~ $digits ]] ; then
 echo "\n*** run_time_seconds must be an integer ***\n" >&2; exit 1
fi

if [ -z ${5+x} ] ; then
  echo Use default frame ratio
else
  echo Set frame ratio
  if [[ $frame_ratio == "coarse" ]] ; then
    echo COARSE
    FRAME_RATIO=$COURSE_GRAINED
  fi
  if [[ $frame_ratio == "fine" ]] ; then
    echo FINE
    FRAME_RATIO=$FINE_GRAINED
  fi
fi

# -----------------------------------------------
# Issue usage instructions, if needed
# -----------------------------------------------

if [ $# -lt $REQUIRED_ARGS ]
then
  echo "\nUsage: `basename $0` {video_file} {output_path} {start_time_seconds} [run_time_seconds]\n"
  echo "EXAMPLE:\n`basename $0` ~/VLC_stuff/2015bsVriot.mp4 ~/VLC_stuff/frames/2015bsVriot_play/ 300 5\n"
  exit -1
fi

# -----------------------------------------------
# MAIN reason for being here
# -----------------------------------------------

# Construct a command to extract an excerpt of the video as a series of images
echo vlc $video_file  --start-time $start_time_seconds --run-time $run_time_seconds --sout \'#transcode{ vfilter = scene{ ratio = $FRAME_RATIO, prefix = $FILE_PREFIX, path = $output_path, out=dummy }, vcodec = theo, vb = 2000,scale = 1.0, acodec = none }:standard{ access = file, mux = ogg, dst = \"dummy.ogg\" }\' vlc://quit > tmp.sh

# Now execute the command
sh tmp.sh

#echo ----------------------------------------------
#echo tail -n50 ~/Library/Logs/vlc-log.txt


# With ratio=3 ...
# sh excerpt.sh ~/VLC_stuff/2015bsVriot.mp4 ~/VLC_stuff/frames/2015bsVriot_play/ 305 55
# generated 630 images
# should be 550 images ( 55 sec x 30 frames per second, ratio = 1 for every 3 )
# from about 5:05 to 6:04
# should be  5:05 to 6:00 = 55 seconds
