#!/bin/sh
#
# screenrec.sh: a simple screencasting script.
#
# Copyright (c) 2013 Manolis Tzanidakis <mtzanidakis@gmail.com>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
# WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
# AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
# DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
# PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
# TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

## configuration: start

# output directory
_output="$HOME/tmp"

# output file format
_outfile="screenrec-$(date '+%Y%m%d_%H%M').mkv"

# video editor (optional)
_videditor="openshot"

## configuration: end

## actual script: stop editing here

# error reporting function
_error() {
	echo "error: ${@}."
	exit 1
}

# check if all requirements are available
for _cmd in awk xdpyinfo ffmpeg; do
	which ${_cmd} >/dev/null 2>&1 || \
		_error "${_cmd} is not installed or accessible"
done

# detect screen resolution
_res="$(xdpyinfo | awk '/dimensions/ {print $2}')"

# start the countdown
printf "start recording in: "
sleep 1
for _i in 5 4 3 2 1; do
	printf "$_i "
	sleep 1
done
printf "go.\n"

# record 'raw' video
# XXX: make it less linux-oriented in the future
ffmpeg -f alsa -ac 2 -f x11grab -r 24 -s ${_res} -i :0.0 \
	-acodec pcm_s16le -vcodec libx264 -preset ultrafast \
	-crf 0 -threads 0 ${_output}/${_outfile}

# import the capture file in the video editor if it's available
if which ${_videditor} >/dev/null 2>&1; then
	${_videditor} ${_output}/${_outfile}

	# ask to delete the original capture file
	printf "\n"
	rm -i ${_output}/${_outfile}
fi
