FROM gw000/keras:1.1.1-py2-tf-gpu

RUN mkdir /app
COPY . /app
WORKDIR /app

CMD python model.py
