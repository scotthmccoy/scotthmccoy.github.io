Convert a video to mp4 audio:
```
brew install ffmpeg
ffmpeg -i input.mp4 -vn -acodec copy output.mp4
```

I used [Hear](https://github.com/sveinbjornt/hear?tab=readme-ov-file) very effectively to transcribe audio. It didn't appear to go any faster when it was audio.

I couldn't install it to `/usr/local/bin/` without disabling security and rebooting.

Example invocation:

```
./hear -T -d -i /video.m4v > transcribed_text.txt
```

The `-T` flag adds timestamps

The `-d` flag makes it use on-device speech recognition:

```
Only use on-device offline speech recognition. The default is to use whatever
the macOS Speech Recognition API thinks is best, which may include sending data
to Apple servers. When on-device is not enabled, there may be a hard limit to
the length of audio that can be transcribed in a single session. As of writing
(2025) this seems to be about 500 characters or so.
```

And `-i` specifies the input file.
