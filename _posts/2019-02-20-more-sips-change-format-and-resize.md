
## Change image format
```
sips -s format png 300_250.gif --out 300_250.png
sips -s format png 360_640.jpg --out 360_640.png
sips -s format png 640_360.jpg --out 640_360.png
sips -s format png 1280_720.jpg --out 1280_720.png
```

## Resize
```
sips -z 720 1280 1280_720.png
sips -z 250 300 300_250.png
sips -z 50 320 320_50.png
sips -z 640 360 360_640.png
sips -z 360 640 640_360.png
sips -z 90 768 768_90.png
```
