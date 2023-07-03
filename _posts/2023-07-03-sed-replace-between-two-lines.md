I wanted to remove all the headers on my blog. The format is triple-dashes, some lines of text, then triple dashes to end. 

![https://github.com/scotthmccoy/scotthmccoy.github.io/assets/1480870/ae2023a6-f4c8-4ef6-9c95-d155efb55ceb](https://github.com/scotthmccoy/scotthmccoy.github.io/assets/1480870/ae2023a6-f4c8-4ef6-9c95-d155efb55ceb)

Works on OSX. 
```
sed -i '' -e '/---/,/---/d' *
```
