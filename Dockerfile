# Use the official Python image from the Docker Hub
FROM python:3.10.12

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia el archivo requirements.txt al contenedor
ADD . .


# Instala las dependencias del proyecto
RUN pip install -r requirements.txt

RUN pip manage.py makemigrations &
RUN pip manage.py migrate &


# Puerto en el que el contenedor va a escuchar (debe coincidir con el expuesto en docker-compose.yml)
EXPOSE 8000

# Comando para ejecutar Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "proyecto.wsgi:application"]  


#CMD python manage.py runserver 0:8000
