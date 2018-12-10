#!/bin/bash

docker run --name lolflask -p 8842:8042 -e VIRTUAL_HOST=flask.local.me --rm example-flask
