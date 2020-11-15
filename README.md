# srs-docker
A proof of concept Docker container for SRS

## WIP Commands

docker build --tag srs:0.1 .

docker run --p 1935:1935 --p 1985:1985 --p 8080:8080 --name srs srs:0.1
