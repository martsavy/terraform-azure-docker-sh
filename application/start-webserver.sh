#!/bin/bash

# Создайте простую HTML-страницу
echo "<html><body><h1>Hello from the Docker container!</h1></body></html>" > index.html

# Запуск веб-сервера на Python
python -m http.server 8000
