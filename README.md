# tarakite(仮)
## アプリ概要

### 画面設計(TBD)
- figma:ユーザーフロー
  <!-- - https://www.figma.com/file/31GyISoeECiSlgkqXEkSMv/corespo-flutter-app?node-id=0%3A1 -->

### スキーマ定義
![]()
- 図はdart上でのEntityとしての持ち方。
- 詳細なスキーマについては[docs/schema.yml](docs/schema.yml)を参照。

### フォルダ構成
```shell: lib/ > tree .
% tree . -I windows -I web -I ios -I macos -I linux -I android -I build
.
├── CHANGELOG.md # バージョンごとの変更点を記載していく
├── README.md # このドキュメント
├── analysis_options.yaml # lintの設定
├── docs # ドキュメント格納フォルダ
│   ├── modeling.drawio.png
│   ├── schema.yml
│   └── schema_firebase.yml
├── lib
│   ├── common # domainでもinfrastructureでもpresentationでもないコードを置くところ
│   ├── domain
│   │   ├── entity # entityモデルを置くところ
│   │   └── value # valueやenumを置くところ
│   ├── infrastructure # repositoryを置くところ
│   ├── main.dart # Flutterのエントリポイント
│   ├── presentation # presentationにViewとViewModel相当のコードを各画面ごとに置く
│   │   ├── group
│   │   ├── post
│   │   ├── calendar
│   │   ├── login
│   │   ├── mypage
│   │   ├── signin
│   │   └── splash
│   └── state # Stateを置くところ
├── picbook.iml
├── pubspec.lock
├── pubspec.yaml
└── test
    └── widget_test.dart
```


### 開発環境
```
% fvm flutter --version
Flutter 3.0.5 • channel stable • https://github.com/flutter/flutter.git
Framework • revision f1875d570e (3 days ago) • 2022-07-13 11:24:16 -0700
Engine • revision e85ea0e79c
Tools • Dart 2.17.6 • DevTools 2.12.2
```

## プロジェクト進行について

### 全体のタスク管理
- GitHub Projectsを用いて行う。カンバン方式
  - [ver 1.0](https://github.com/pj-picbook/picbook/projects/1)
- 初期資料
  - https://docs.google.com/spreadsheets/d/1l_Nu-918y9GVZ78cG5aG6ptdbY0iy-jf/edit#gid=1807751388

### ブランチ運用
Git Flow に沿って開発を行う(ツールは使わない)
- 参考
  - [Git-flowって何？ - Qiita](https://qiita.com/KosukeSone/items/514dd24828b485c69a05)
  - [共同開発時のgithubの使い方（ブランチの作り方、マージの仕方、コンフリクトの解消方法）- vimeo(Flutter大学限)](https://vimeo.com/showcase/7431597/video/441969458)
- 基本的な流れ
  - main ブランチと develop ブランチが常に存在し、保護しておく
  - 機能を追加するときは develop ブランチから featureブランチを作成する
    - ブランチの名前は feature/#(issue 番号)\_わかりやすい名前
    - 作業が終わったら feature ブランチから develop ブランチへのPR(プルリクエスト)を作成する
    - PRを誰かがレビューし、LGTMが付けばMergeする
- 各ブランチについて
  - main
    - リリースされたアプリの状態と同期させる。直接の変更不可。PRからのマージのみ。
    - releaseブランチ or hotfixブランチからマージされ、バージョンが変更されるはずなので、mainへマージされた再はバージョンに合わせてタグを付与する
  - develop
    - 開発するためのブランチ。直接の変更不可。PRからのマージのみ。
    - developブランチでは常にビルドが通る状態にしておく。
  - feature
    - 機能追加の際に作成するブランチ。
    - developブランチから`feature/#{issue number}_{task name}`の命名規則でブランチを作成し、作業を行う。
    - PRはdevelopブランチをターゲットとする。
  - release
    - developブランチからmainブランチへ変更を取り込み、リリースを行う際に作成されるブランチ。
    - developブランチから`release/#{issue number}_{task name}`の命名規則でブランチを作成し、作業を行う。
    - PRはmainブランチをターゲットとする。
    - マージ後はリリース作業 & developブランチへもマージする。
  - hotfix
    - mainブランチで見つかったバグに対して修正したい場合に用いる
    - mainブランチから`hotfix/#{issue number}_{task name}`の命名規則でブランチを作成し、作業を行う。
    - PRはmainブランチをターゲットとする。
    - マージ後はリリース作業 & developブランチへもマージする。
- バージョニングについて
  - 一般的なセマンティックバージョニングを採用する
    - [セマンティック バージョニング 2.0.0 | Semantic Versioning](https://semver.org/lang/ja/)
  - 形式：`1.2.3` major.miner.patch
    - major
      - 大きな機能変更、後方互換性がない変更を行った際にインクリメントする
    - miner
      - 機能追加等の際にインクリメントする
    - patch
      - バグ修正などを行った場合にインクリメントする
