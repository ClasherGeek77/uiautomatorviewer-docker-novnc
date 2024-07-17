FROM --platform=linux/amd64 ubuntu:20.04 as base
################################################################################

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Jakarta

RUN apt-get -qqy update && \
    apt-get -qqy --no-install-recommends install \
    openjdk-8-jdk \
    curl \
    zip \
    unzip

ENV PATH=/root/.local/bin:$PATH

RUN curl -sL https://deb.nodesource.com/setup_20.x | bash && \
    apt-get -qqy install nodejs

RUN JAVA_HOME=$(dirname $( readlink -f $(which java) )) \
    export JAVA_HOME=$(realpath "$JAVA_HOME"/../)

ENV PATH=$PATH:$JAVA_HOME/bin

#=====================
# Install Android SDK
#=====================
ENV SDK_VERSION=sdk-tools-linux-4333796
ENV ANDROID_BUILD_TOOLS_VERSION=33.0.0
ENV ANDROID_PLATFORM_VERSION="android-28"
ENV ANDROID_HOME=/android-sdk
ENV BUNDLE_VERSION=1.9.1

RUN mkdir $ANDROID_HOME
RUN curl -o tools.zip https://dl.google.com/android/repository/${SDK_VERSION}.zip

RUN unzip tools.zip -d $ANDROID_HOME && rm tools.zip

ENV PATH=$ANDROID_HOME/tools/:$ANDROID_HOME/tools/bin:/root/:$PATH

RUN mkdir -p ~/.android && \
    touch ~/.android/repositories.cfg

RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager "platform-tools" --sdk_root=$ANDROID_HOME  && \
    echo y | $ANDROID_HOME/tools/bin/sdkmanager "build-tools;$ANDROID_BUILD_TOOLS_VERSION" --sdk_root=$ANDROID_HOME  && \
    echo y | $ANDROID_HOME/tools/bin/sdkmanager "platforms;$ANDROID_PLATFORM_VERSION" --sdk_root=$ANDROID_HOME

ENV PATH=$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/$ANDROID_BUILD_TOOLS_VERSION/:/root/:$PATH


# Install git, supervisor, VNC, & X11 packages
RUN set -ex; \
    apt-get update; \
    apt-get install -y \
      bash \
      fluxbox \
      git \
      net-tools \
      novnc \
      supervisor \
      x11vnc \
      xterm \
      xvfb

# Setup demo environment variables
ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_XTERM=yes \
    RUN_FLUXBOX=yes
    
COPY ./app /app
CMD ["/app/entrypoint.sh"]
EXPOSE 8080
