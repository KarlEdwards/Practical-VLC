# Practical-VLC
Examples illustrating manipulation of videos using VLC.
--------
1. Excerpt a video

Input: `~/VLC_stuff/2015bsVriot.mp4`
Start time ( seconds from beginning of video ): `3600`
Duration( seconds ): `60`
Output: `./` ( current directory )

Putting it all together as follows:

```$ sh excerpt.sh ~/VLC_stuff/2015bsVriot.mp4 ./ 3600 60```

yields a series of a few hundred frames from the video, each frame in a file having a name like frame_0####.png

