FROM centos:centos7

RUN yum -y update && \
    yum install -y gcc openssl-devel bzip2-devel git && \
    yum install -y https://centos7.iuscommunity.org/ius-release.rpm && \
    yum install -y python36u python36u-pip python36u-devel && \
    yum clean all

# See https://github.com/CentOS/sig-cloud-instance-images/issues/71
RUN localedef -i en_US -f UTF-8 en_US.UTF-8

RUN ln -s /bin/python3.6 /bin/python3
RUN ln -s /bin/pip3.6 /bin/pip3

# Change machine time zone to pacific. ENV variables are needed to run Flask server
RUN ln -fs /usr/share/zoneinfo/europe/paris /etc/localtime

ENV LC_ALL "en_US.utf8"
ENV LANG "en_US.utf8"

# Python system and package requirements
COPY . /typhoon/example-flask

RUN pip3 install -U pip --no-cache-dir && pip3 install -r /typhoon/example-flask/requirements.txt --no-cache-dir

# Expose the port for the Flask server
EXPOSE 8042

# Set up Python path
ENV PYTHONPATH "/typhoon/example-flask"

# Launch the script which will run the server
WORKDIR "/typhoon/example-flask"
CMD ["python3", "/typhoon/example-flask/flaskserver.py"]
