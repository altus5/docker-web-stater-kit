#!/bin/bash
set -e
trap 'echo "エラーが発生しました。bash を起動します。" 1>&2; bash' ERR

cmd=${1:-serve}

_init() {
  ## .a5cache の配置
  if [ ! -e /home/nobita/.npm ]; then
    sudo cp -ra /home/nobita/.a5cache/.npm /home/nobita/
    sudo chown -R nobita:nobita /home/nobita/.npm
  fi
  if [ ! -e /srv/web-starter-kit/app ]; then
    sudo mkdir -p /srv
    sudo cp -ra /home/nobita/.a5cache/web-starter-kit /srv/
    sudo chown -R nobita:nobita /srv/web-starter-kit
  fi
}

_init

case "$cmd" in
  'serve')
    cd /srv/web-starter-kit
    gulp
    gulp serve
    ;;
  *)
    exec "$@"
    ;;
esac

