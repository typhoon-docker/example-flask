#!/usr/bin/env python3
# -*-coding:utf-8-*-

"""
This is a small Flask server used to access logs and reports of the different deployments from the same place
"""

import subprocess

from flask import Flask


app = Flask(__name__)


@app.route("/")
def hello_world():
    hostname = subprocess.check_output("hostname").decode("utf-8").strip()
    label = subprocess.check_output(["git", "rev-parse", "--short", "HEAD"]).decode("utf-8").strip()
    return f"Flask server is up on {hostname}, with label {label}"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8042)
