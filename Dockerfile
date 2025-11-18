FROM ruby:3.1.0

# Node.jsとYarnのインストール（Rails 7のJavaScriptビルドに必要）
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
  && apt-get install -y nodejs

RUN npm install --global yarn

# PostgreSQLクライアントのインストール
RUN apt-get update -qq && apt-get install -y postgresql-client

# 作業ディレクトリの設定
WORKDIR /usr/src/app

# GemfileをコピーしてGemをインストール
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションコードをコピー
COPY . .

# ポート3000を公開
EXPOSE 3000

# サーバー起動コマンド
CMD ["rails", "server", "-b", "0.0.0.0"]