FROM debian:stable-slim
RUN echo steam steam/license note '' | debconf-set-selections && echo steam steam/question select "I AGREE" | debconf-set-selections
RUN dpkg --add-architecture i386 && \
  sed -i -e's/ main/ main contrib non-free/g' /etc/apt/sources.list \
  && apt-get -q update \
  && apt-get -qy dist-upgrade \
  && apt-get install -qy steamcmd libsdl2-2.0-0:i386 libsdl2-2.0-0 tini ca-certificates locales \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists \
  && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && dpkg-reconfigure --frontend=noninteractive locales \
  && useradd -ms /bin/bash steam
ENV PATH="/usr/games:${PATH}"
USER steam
WORKDIR /home/steam
ADD --chmod=0755 start_server.sh entrypoint.sh
RUN mkdir SatisfactoryDedicatedServer Steam .config .steam .local
VOLUME [ "/home/steam/SatisfactoryDedicatedServer", "/home/steam/Steam", "/home/steam/.config", "/home/steam/.steam", "/home/steam/.local" ]
EXPOSE 7777/udp 15000/udp 15777/udp
ENTRYPOINT ["/usr/bin/tini", "--", "/home/steam/entrypoint.sh"]
