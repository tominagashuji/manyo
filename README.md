# README

## 開発環境
```
ruby 2.5.3p105 (2018-10-18 revision 65156) [x86_64-darwin16]
Rails 5.2.1
```

## 設計書
https://docs.google.com/spreadsheets/d/1kX6JYpMjxbjaV0LmtLJMRyZRheTFpt7DdjHXQgSSQrE/edit#gid=1666825416

## step13にてherokuへデプロイ
### Basic認証導入にについて
```
http_basic_authenticate_with :name => ENV['BASIC_AUTH_USERNAME'], :password => ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"
```

### herokuとGitHub連携手順
https://j-hack.gitbooks.io/deploy-meteor-app-to-heroku/content/step4.html

### herokuデプロイ手順の整理
```
1. git init
実行、その後に ls -a で . .. .git のファイル？を存在確認する
設定状態も確認する
2. git config --global --list
アセッツプリコンパイル
3. heroku restart
画像のconfig.assets~をtrue に変更しよう！！
4. rails assets:precompile RAILS_ENV=production　→アセッツを触ったらリコンパイル必要
5. git add -A
6. git commit -m "test commit"
7. heroku create　heroku側でアプリを作成する！実行すると自動で remote で heroku が出来上がる！DB作ろう(５回以上やると怒られた様子、無視して次やったら、、出来た！！＾＾b)
8. git push heroku master
10. heroku run rake db:migrate　→DBとかをいじってなければOK
11. heroku run bundle install　→ヘロクのバンドルインストール
```
