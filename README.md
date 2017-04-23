Web Starter Kit の環境
=======================

このコンテナは、Google Web Starter Kit で開発を始めるための環境です。
nodejsのキャッシュや、node_modulesのディレクトリも、npm install した状態を
コンテナ内に持っているので、初回起動時に、npm install する必要もなく、
環境の準備にかかる時間がとても短いので、何度でも、ストレスなく、始めからやり直しながら、
試行できます。

コンテナは、nobita ユーザー(uid=1000)で実行されます。
このユーザーのホームディレクトリに、キャッシュデータとnode_modules等のディレクトリを保持していて、
初回起動時に、ホストと共有する /srv/web-starter-kit のディレクトリに、コピーするようになっています。

開発が進んでいく過程で、パッケージを追加した場合も、docker-compose で次のように、
volumes を構成することで、データコンテナにnodejsのキャッシュや、node_modulesのディレクトリが
永続化されるので、コンテナの再実行時にも、追加パッケージが維持されます。

```
version: '2'

services:
  wsk:
    build: docker/web-starter-kit
    image: altus5/web-starter-kit:0.6.5_0
    container_name: wsk
    volumes:
      - ./web-starter-kit:/srv/web-starter-kit
      - data:/home/nobita/.npm
      - data:/srv/web-starter-kit/node_modules
    ports:
      - "3000:3000"
      - "3001:3001"
      - "3002:3002"
    user: nobita
    working_dir: /srv/web-starter-kit
    tty: true

volumes:
  data:
    driver: local
```

