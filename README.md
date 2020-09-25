# Hangout-Manager-2

![logo_hangout](https://user-images.githubusercontent.com/33748835/94321877-d9752b00-ffcb-11ea-9842-9eb25b74b4f3.png)




# セットアップ

各種コマンドを実行

```shell
$ docker-compose build
$ docker create network proxy
$ docker-compose run --rm front npm install
$ docker-compose run --rm api rails db:create
$ docker-compose run --rm api rails db:migrate
$ docker-compose run --rm api rails db:seed_fu
$ docker-compose up
```

めんどくさい人へ

```shell
$ ./setup.sh
```

`setup.sh`に上記のコマンドがシェルスクリプトとして書いてあります．

![スライド40](https://user-images.githubusercontent.com/33748835/94321953-07f30600-ffcc-11ea-931e-32eb5a1e76c2.JPG)
