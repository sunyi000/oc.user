#!/bin/sh
# -ab 128k


# 
# rtbufsize integer (input) 
# 	Set max memory used for buffering real-time frames.
#
# probesize integer (input)
# 	Set probing size in bytes, i.e. the size of the data to analyze to get stream information. 
#	A higher value will enable detecting more information in case it is dispersed into the stream, but will increase latency. 
#	Must be an integer not lesser than 32. It is 5000000 by default.
#
# packetsize integer (output)
# 	Set packet size.
# ar integer (decoding/encoding,audio)
# 	Set audio sampling rate (in Hz).
# ac integer (decoding/encoding,audio)
# 	Set number of audio channels.

# The following options are supported by the libmp3lame wrapper. The lame-equivalent of the options are listed in parentheses.
# -b
#	Set bitrate expressed in bits/s for CBR or ABR. LAME bitrate is expressed in kilobits/s.
# compression_level (-q)
# 	Set algorithm quality. 
#	Valid arguments are integers in the 0-9 range, with 0 meaning highest quality but slowest, and 9 meaning fastest while producing the worst quality.
# -reservoir
# 	Enable use of bit reservoir when set to 1. Default value is 1. LAME has this enabled by default, but can be overridden by use --nores option.
#
# joint_stereo (-m j)
#	Enable the encoder to use (on a frame by frame basis) either L/R stereo or mid/side stereo. Default value is 1.



ffmpeg -y \
-acodec pcm_s16le \
-ar 44100 \
-probesize 64 \
-rtbufsize 64 \
-f pulse \
-i auto_null.monitor \
-acodec libmp3lame \
-ab 128k \
-ac 1 \
-reservoir 0 \
-f mp3 \
-seekable 0 \
-fflags +nobuffer \
- \
| nodejs /composer/node/livesound-service/stdinstreamer.js -port 8000 -type mp3 -burstsize 0
