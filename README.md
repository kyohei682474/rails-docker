# README

##  環境構築手順について
*  このプロジェクトではdockerを利用することでRailsアプリケーションとPostgresを簡単にセットアップして実行することができます。
### 前提条件
* DockerとDockerHubがインストールされていることが必要です。
* DockerHubはこちらの[公式サイト](https://hub.docker.com/)からダウンロードおよびインストールができます。
### インストール手順
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
