#!/bin/bash
set -e
trap 'echo "エラーが発生しました。bash を起動します。" 1>&2; bash' ERR

_init() {
  ## データコンテナをマウントした初回はオーナーが異なるので chown する
  sudo chown -R nobita:nobita /home/nobita/.npm
  sudo chown -R nobita:nobita /srv/web/node_modules
  ## .a5cache の配置
  if [ ! -e /home/nobita/.npm/.a5 ]; then
    sudo cp -ra /home/nobita/.a5cache/.npm /home/nobita/
    sudo touch /home/nobita/.npm/.a5
  fi
  if [ ! -e /srv/web/app ]; then
    sudo mkdir -p /srv
    sudo cp -ra /home/nobita/.a5cache/web /srv/
    sudo touch /srv/web/node_modules/.a5
  fi
  if [ ! -e /srv/web/app/node_modules/.a5 ]; then
    sudo cp -ra /home/nobita/.a5cache/web/node_modules/* /srv/web/node_modules
    sudo touch /srv/web/node_modules/.a5
  fi
}

_init

if [ "$#" -ne 1 ]; then
  bash
else
  exec "$@"
fi
