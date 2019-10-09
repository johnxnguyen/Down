# You can set the Swift version to what you need for your app. Versions can be found here: https://hub.docker.com/_/swift
FROM swift:5.1

RUN apt-get -qq update \
  && apt-get -q -y install libssl-dev zlib1g-dev \
  && rm -r /var/lib/apt/lists/*
