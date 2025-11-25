#!/bin/bash
set -e

# 本番環境用マイグレーション
bundle exec rails db:migrate RAILS_ENV=production

# 本番環境用アセットプリコンパイル
bundle exec rails assets:precompile RAILS_ENV=production