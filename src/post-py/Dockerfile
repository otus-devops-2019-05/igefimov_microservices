FROM python:3.6.0-alpine

WORKDIR /app
ADD . /app

RUN apk add --no-cache gcc musl-dev
RUN pip install --upgrade pip && pip install -r /app/requirements.txt

ENV POST_DATABASE_HOST mongodb
ENV POST_DATABASE posts

ENTRYPOINT ["python3", "post_app.py"]
