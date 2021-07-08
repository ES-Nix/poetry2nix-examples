# FROM python:3.9.6-slim-buster
FROM python:3.8.3-slim-buster AS builder


# Set python environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=0 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

RUN addgroup \
    --gid 1234 app_group \
 && adduser \
    --uid 5678 \
    --gid 1234 \
    --home /home/app_user \
    --shell /bin/bash \
    --disabled-login \
    --disabled-password \
    --gecos "User for app" \
    app_user \
 && chmod 0700 /home/app_user

RUN apt-get update \
 && apt-get install -y --no-install-suggests --no-install-recommends \
   curl \
   ca-certificates \
   git \
   nano \
   locales \
 && apt-get -y autoremove \
 && apt-get -y clean  \
 && rm -rf /var/lib/apt/lists/*

RUN sed --in-place '/^#.* pt_BR.UTF-8 /s/^#//' /etc/locale.gen \
 && locale-gen

RUN pip install 'poetry==1.2.0a1' \
 && poetry config virtualenvs.create true

ENV PATH="/root/.poetry/bin:$PATH"

COPY . /app/


FROM python:3.8.3-slim-buster

COPY --from=builder /app/dist/*.whl /app/

RUN pip install --no-cache-dir /app/*.whl

RUN addgroup \
    --gid 1234 app_group \
 && adduser \
    --uid 5678 \
    --gid 1234 \
    --home /home/app_user \
    --shell /bin/bash \
    --disabled-login \
    --disabled-password \
    --gecos "User for app" \
    app_user \
 && chmod 0700 /home/app_user
