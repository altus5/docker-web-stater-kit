Web Starter Kit の環境
=======================

このコンテナは、Google Web Starter Kit で開発を始めるための環境です。
nodejsのキャッシュや、node_modulesのディレクトリも、npm install した状態を
コンテナ内に持っているので、初回起動時に、npm install する必要もなく、
環境の準備にかかる時間がとても短いので、何度でも、ストレスなく、やり直しながら、
試行できます。

コンテナは、nobita ユーザー(uid=1000)で実行されます。
このユーザーのホームディレクトリに、キャッシュデータとnode_modules等のディレクトリを保持していて、
初回起動時に、ホストと共有する /srv/web のディレクトリに、コピーするようになっています。

開発が進んでいく過程で、パッケージを追加した場合も、docker-compose で次のように、
volumes を構成することで、データコンテナに npm のキャッシュや、 node_modules のディレクトリが
永続化されるので、コンテナの再起動時にも、追加パッケージが維持されます。

```
version: '2'

services:
  wsk:
    image: altus5/web-starter-kit:0.6.5_2
    container_name: wsk
    volumes:
      - .:/srv/web
      - data:/home/nobita/.npm
      - data:/srv/web/node_modules
    ports:
      - "3000:3000"
      - "3001:3001"
      - "3002:3002"
    user: nobita
    working_dir: /srv/web
    tty: true

volumes:
  data:
    driver: local
```

