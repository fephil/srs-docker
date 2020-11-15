FROM centos:centos7

# Install tools
RUN yum install -y gcc make gcc-c++ patch unzip perl git wget xz

# Download and copy ffmpeg 4.1
# TODO: Can we modify SRS build to point to ffmpeg location instead of usr?
# TODO: Consider building ffmpeg from source?
RUN cd /tmp && wget https://www.johnvansickle.com/ffmpeg/old-releases/ffmpeg-4.1.4-amd64-static.tar.xz
RUN unxz /tmp/ffmpeg-4.1.4-amd64-static.tar.xz
RUN mkdir /tmp/ffmpeg-4.1.4-amd64-static
RUN tar -xf /tmp/ffmpeg-4.1.4-amd64-static.tar -C /tmp/
RUN cp /tmp/ffmpeg-4.1.4-amd64-static/ffmpeg /usr/local/bin/ffmpeg 

# Clone SRS Version
RUN cd /tmp/ && git clone --depth=1 --branch=v3.0-r2 https://github.com/ossrs/srs.git

# Install SRS
RUN cd /tmp/srs/trunk && ./configure --with-ffmpeg && make && make install

# Copy SRS Config
COPY ./srs.conf /usr/local/srs/conf/srs.conf

# Delete Files
RUN rm -rf /tmp/*

# Expose Ports
EXPOSE 1935 1985 8080

# Run SRS
WORKDIR /usr/local/srs
CMD ["./objs/srs", "-c", "conf/srs.conf"]