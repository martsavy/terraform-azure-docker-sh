#!/bin/bash

# Create a simple HTML page
echo "<html><body><h1>Hello from the Docker container!</h1></body></html>" > index.html

# Start a web server using Python
python -m http.server 8000
