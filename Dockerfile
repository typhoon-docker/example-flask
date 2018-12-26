FROM python:3.7-alpine

# Python package requirements
COPY ./requirements.txt /typhoon/requirements.txt

RUN pip3 install -U pip --no-cache-dir && pip3 install -r /typhoon/requirements.txt --no-cache-dir

# Python source code
COPY . /typhoon

# Expose the port for the Flask server
EXPOSE 8042

# Set up Python path
ENV PYTHONPATH "/typhoon"
WORKDIR "/typhoon"

# Launch the script which will run the server
CMD ["python3", "/typhoon/flaskserver.py"]
