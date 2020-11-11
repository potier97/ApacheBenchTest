# Tutorial API REST- Flask (cipher/decipher)
API REST - Flask. Esta es una API básica que proporciona 2 endpoints, para cifrar y descifrar información utilizando el algoritmo RC4 utilizando en WEP. Esta aplicación esta desarrollada para el curso de Desarrollo de Soluciones Cloud. 

# Ejecución 
Para ejecutar la aplicación siga las siguientes instrucciones: 

## Crear un nuevo ambiente virtual
$ python3 -m venv nuevo_ambiente
$ source nuevo_ambiente/bin/activate

## Instalar las dependencias
$ pip install flask 
$ pip install flask-restful 
$ pip install flask-marshmallow

## Configurar variables de entorno
$ set FLASK_APP = app.py
$ set FLASK_DEBUG = 1
$ set FLASK_ENV = development

## Ejecutar
$ flask run -h 0.0.0.0

# Cifrado RC4 basado en el proyecto:
https://github.com/g2jun/RC4-Python
