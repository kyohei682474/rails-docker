# README

##  環境構築手順について
*  このプロジェクトではdockerを利用することでRailsアプリケーションとPostgresを簡単にセットアップして実行することができます。
### 前提条件
* DockerとDockerHubがインストールされていることが必要です。
* DockerHubはこちらの[公式サイト](https://hub.docker.com/)からダウンロードおよびインストールができます。
### 手順
1.リポジトリのcloneを行い、作業リポジトリに移動する。
```
$ git clone https://github.com/ihatov08/rails7_docker_template
cd rails-docker
```
2.Dockerfileとdocker-compose.ymlを作成する。
```
$ touch Dockerfile docker-compose.yml
```
3.Dockerfileの記述
```
FROM ruby:3.2.2
RUN apt-get update && apt-get install -y build-essential libpq-dev nodejs 
RUN mkdir workdir
WORKDIR /workdir
ADD Gemfile /workdir/Gemfile
ADD Gemfile.lock /workdir/Gemfile.lock
RUN bundle install
ADD . /workdir/
```
4.docker-compose.ymlの記述
```
version: '12'
services:
  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: trust
  web:
    build: .
    command: /bin/sh -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
    volumes:
      - .:/workdir
    ports:
      - "3000:3000"
    depends_on:
      - db
```
5.新しいファイルの所有者を変更。
```
$ sudo chown -R $USER:$USER .
```

6.データベースと接続を行う。
#### config/database.yml
```
default: &default
  adapter: postgresql
  encoding: unicode 
  host: db
  username: postgres
  password:
  pool: 5
```
7.アプリケーションに起動
```
$ docker-compose up 
```
* ブラウザでlocalhost:3000を入力

8.databaseの作成。
* ブラウザ上のcreate databaseのボタンを押すとアプリケーションが起動する。

## アプリケーション(Myapp)の使用方法

### taskの作成
1.New taskをクリックしてtaskの入力画面に遷移する。
２.TitleとDescriptionの欄に入力してtaskのtitleとDescriptionを記述してCreate　Taskボタンを押す。
３.taskが上手く作成されるとtaskのTitleとDescriptionが表示される。

### taskの一覧を表示する
1.taskの詳細ページにあるBack to tasksをクリックすると作成したタスクの一覧画面に移動する。

### taskの詳細を表示する
１.taskの一覧ページにあるShow this taskをクリックするとtaskの詳細ページに遷移する。

### taskの編集
1.taskの詳細ページにあるEdit this taskをクリックすると変更したいtaskの編集画面が表示される。
2.TitleとDescriptionに変更を加える。
3.Update Taskをクリックすると変更された内容が表示される。

### taskの削除
１.task一覧ページに表示されているtaskの中から削除したいタスクのShow this taskをクリックする。
2.taskの詳細ページにあるDestroy this taskをクリックする。
3.taskは削除されてtask一覧ページに遷移する。

