## screenrec.sh

A simple shell script for recording screencasts.

## Requirements & Compatibility

* [ffmpeg](http://ffmpeg.org/)
* optionally, a video editor. I use [openshot](http://www.openshotvideo.com/)
* xdpyinfo (check your distro's xorg packages)
* standard UNIX tools: awk and of course sh.

Currently this script is compatible with Linux only. Future versions will support more OS.

## Installation

Just copy the script somewhere in your `PATH` and make it executable.

## Usage

Simply run the script. It will start a countdown from 5 and then record your screen. Stop the recording by pressing `Q` in the terminal you started the script from. If a video editor, like Openshot, is installed the script will start it and import the recorded video for further processing.

You can change the output path and output filename pattern as well as set a video editor by setting variables between the `## configuration: start` and `## configuration: end` section in the script. Future versions will use a configuration file.

## License

This script is licensed under the [ISC license](http://opensource.org/licenses/ISC).
