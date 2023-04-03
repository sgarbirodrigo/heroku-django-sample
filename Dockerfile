# syntax=docker/dockerfile:1
FROM python:3
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE=1
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
COPY . /code/


# collect static files
RUN python manage.py collectstatic --noinput

# add and run as non-root user
RUN adduser -D myuser
USER myuser
# run gunicorn
CMD gunicorn hello_django.wsgi:application --bind 0.0.0.0:$PORT