# README

## 設計書
https://docs.google.com/spreadsheets/d/1kX6JYpMjxbjaV0LmtLJMRyZRheTFpt7DdjHXQgSSQrE/edit#gid=1666825416

##step13にてherokuへデプロイ
##Basic認証導入にについて
```
http_basic_authenticate_with :name => ENV['BASIC_AUTH_USERNAME'], :password => ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"
```

##herokuデプロイ手順の整理


##herokuとGitHub連携手順の


##環境
```
ruby 2.5.3p105 (2018-10-18 revision 65156) [x86_64-darwin16]
Rails 5.2.1
```
