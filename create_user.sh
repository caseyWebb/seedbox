#!/bin/bash
source .env

if [ ! -d "$DIRECTORY" ]; then
  mkdir -p ${MEDIA_ROOT}
fi

if ! id ${PUID} > /dev/null 2>&1; then
  useradd -u ${PUID} -g ${GUID} -d ${MEDIA_ROOT}
fi
