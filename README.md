# TechConfigs

This is a collection of configurations and Scripts for Automating Sunday A/V processes at [Tenth Presbyterian Church](https://tenth.org).  If you're interested in doing something similar at your church (or somewhere else), you are welcome to borrow anything here in compliance with [the License](LICENSE.md).  

You will, however, almost certainly need to alter some of the scripts to ensure things work in your system.

The instructions we provide our operators (in addition to training) are [in the wiki](https://github.com/TenthPres/techConfigs/wiki). 

## System & Operator Overview

For a typical service, we have four operators:
1. House Audio - Using an Allen & Heath iLive R72, this person sits among the congregation and The iLive provides the Analog-to-Digital conversion for all audio, and makes all inputs available via Dante. 
2. Recording Audio - Using a computer running Reaper, this person sits in the control room and creates the recording/broadcast audio mix in Reaper.  As the sources for this mix are the direct outs from the iLive, this mix is completely unaffected by mutes, levels, EQs and other processing in the iLive.  This separation gives us a clean mix, which we can optimize for broadcast, rather than in-house reinforcement. 
3. Video Switcher/Camera Operator - Using two computers and a host of software, this person is responsible for driving the PTZ cameras, switching between them, and routing it to the proper destinations.  The primary software used for this is Wirecast, which creates the primary stream and broadcasts it to YouTube, SermonAudio, and our internal NDI stream.  The second computer runs two instances of OBS, one for Facebook, and the other audio-only for our PhoneLivestreaming audience.
4. Graphics - Using a computer running [PPT-NDI](https://github.com/ykhwong/ppt-ndi), this person runs the slides (literally PowerPoint slides) that create our graphics.  PPT-NDI makes them available, with transparent backgrounds via NDI, to the Wirecast. 
