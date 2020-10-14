# iTunes2SD

<img src="https://drive.slawagurevich.com/itunes2sd.png" alt="iTunes2SD" width="900" />

## What is this?

iTunes2SD is a small tool I wrote for syncing my Android Phone with my iTunes library.

## Why does this exist?

I was a long time Apple user (and still have quite a lot of their hardware). However, when it was time to get a new phone, I decided to try go team green and my biggest annoyance ever since was managing my music on my Mac. For Mac + iPhone there is iTunes, as well as for Windows + iPhone. For Windows + Android I assume people just throw a bunch of mp3s somewhere on their SD card and are happy with that. I wanted a more sophisticates solution, so I wrote a small script to export my iTunes playlists into *.m3u(8) files and copy my music collection accordingly, so that I just need to move everything onto my Android phone once. When my library updates, I just repeat that for any playlists that have changed and voila. However...

## Features

This is still very much an alpha and a lot of features are missing (Artist and Album copy being the biggest ones). Here is what's working:

- Select and export playlists (duh!)
- Switch between m3u and m3u8 formats (I'd stick to m3u8, because it supports different languages)
- Export playlists only, if you want to listen to them on your machine only or manually copy the songs over through the cloud

## Future features

In the future I am planning on implementing more small and big changes to make the app more useful.

- Support for copying Artists and Albums (The main problem here is finding out, which ones are selected...)
- Move the files directly to the phone over adb (this will be fun)
- Keep the libraries in sync both ways

For now it does what it was designed to do in the very beginning. Select a playlist, copy to a folder, get the m3u(8) file, copy to phone, done.

## Help?

PRs and other optimisations very much appreciated.
