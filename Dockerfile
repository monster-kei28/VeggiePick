FROM ruby:3.1.0

# Node.js と Yarn
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs
RUN npm install --global yarn

# PostgreSQL client
RUN apt-get update -qq && apt-get install -y postgresql-client

# 作業ディレクトリ
WORKDIR /usr/src/app

# Gemfileをコピーして bundle install
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションコード
COPY . .

# assets:precompile（必要ならここで）
# RUN bundle exec rails assets:precompile RAILS_ENV=production

# Rails を Render のポートで起動
CMD ["sh", "-c", "rails server -b 0.0.0.0 -p ${PORT}"]