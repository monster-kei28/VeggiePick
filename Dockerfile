FROM ruby:3.1.0

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  npm \
  postgresql-client \
  && rm -rf /var/lib/apt/lists/*

# Node.js 16.16.0をインストール
RUN npm install -g n && n 16.16.0

WORKDIR /app

# GemfileとGemfile.lockをコピー
COPY Gemfile Gemfile.lock ./

# Bundlerでgemをインストール
RUN bundle install

# アプリケーションコードをコピー
COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]