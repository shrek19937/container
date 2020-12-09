FROM python:3
# . is the current build dir where docker build is invoked
COPY . /public
WORKDIR /public
ENTRYPOINT ["python3", "-m", "http.server"]
