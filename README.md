# Jvkoh
### Stuff and things

## Installation Instructions

Install Node

Run this from the command line:
npm install -g jade vogue coffee-script tplcpl uglify-js nodewatch

Note:If you ever get a 'module \<module\> not found' error, just run npm install -g \<module_name\>

## Developing
To run the local server, just run ./runServer.
Then, simply run 'cake watch' in a separate terminal, and all source files will be compiled as you save them! 

* If a file is not being changed, you must first run the watch command and then save the file
* The watch script occasionally runs into errors. If it does, just run it again

Less files should be automatically updated in the browser 

## Project Structure
Less is in public/css/. It should update automatically (working for me).  
Coffeescript is in src/js/  
Jade is in src/views/
