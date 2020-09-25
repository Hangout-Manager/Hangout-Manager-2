# Hangout-Manager-2

![logo_hangout](C:\Users\masashi\workspace\3_PRIVATE\hangout\logo_hangout.png)



![スライド40](C:\Users\masashi\OneDrive\デスクトップ\技育展v2\スライド40.JPG)



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