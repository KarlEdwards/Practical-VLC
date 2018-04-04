# Practical-VLC
Examples illustrating manipulation of videos using VLC.
--------
# Example 1: Excerpt a video

## Parameters

* Input: `~/VLC_stuff/2015bsVriot.mp4`
* Start time: `3600` ( seconds from beginning of video )
* Duration: `60` ( seconds )
* Output: `./`  ( current directory )

## Execution
Putting it all together as follows:

```$ sh excerpt.sh ~/VLC_stuff/2015bsVriot.mp4 ./ 3600 60```

yields a series of a few hundred frames from the video, each frame in a file having a name like frame_00000.png

See a few examples in [images](https://github.com/KarlEdwards/Practical-VLC/blob/master/images/)
