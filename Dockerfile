FROM docker.io/alpine:3.10

ENV UID=1337 \
    GID=1337 \
    FFMPEG_BINARY=/usr/bin/ffmpeg

COPY . /opt/mautrix-telegram
WORKDIR /opt/mautrix-telegram
RUN apk add --no-cache \
      py3-virtualenv \
      py3-pillow \
      py3-aiohttp \
      py3-magic \
      py3-sqlalchemy \
      py3-markdown \
      py3-psycopg2 \
      py3-ruamel.yaml \
      # Indirect dependencies
      #commonmark
        py3-future \
      #alembic
        py3-mako \
        py3-dateutil \
        py3-markupsafe \
      #moviepy
        py3-decorator \
        #py3-tqdm \
        py3-requests \
        #imageio
          py3-numpy \
      #telethon
        py3-rsa \
      # Other dependencies
      python3-dev \
      libffi-dev \
      build-base \
      ffmpeg \
      ca-certificates \
      su-exec \
 && pip3 install .[fast_crypto,hq_thumbnails,metrics] \
 && pip3 install --upgrade 'https://github.com/LonamiWebs/Telethon/tarball/master#egg=telethon' \
                           'https://github.com/tulir/mautrix-python/tarball/error-debug#egg=mautrix'

VOLUME /data

CMD ["/opt/mautrix-telegram/docker-run.sh"]
