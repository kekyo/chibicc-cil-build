# chibicc-cil ビルドルートリポジトリ

[English language](README.md)

## これは何?

このプロジェクトに興味を持ってくれてありがとう！

これは、Rui Ueyama氏の [chibicc: A Small C Compiler](https://github.com/rui314/chibicc) を.NET環境に移植するプロジェクトのビルドルートリポジトリです。

ただ、私はしばらくこのプロジェクトを更新する予定はありません。
issueやPRを投げてもらっても構いませんが、修正依頼については反応が無いかも知れません。

大きな残件は、[このリポジトリのディスカッション](https://github.com/kekyo/chibicc-cil-build/discussions)に書き残してあります。

もちろん、フォークして弄るのは自由です。少なくともプロジェクトは全体的にMIT配下にあります。

## 詳細

chibiccはC言語処理系ですが、これを.NETに移植する際には「Cランタイムライブラリ」が必要です。
しかし、.NETには標準的な実装がありません。したがって:

1. chibiccと一緒に使用するための、ツールチェイン「chibicc-cil-toolchain」をビルドする。
2. chibiccをビルドする（最低限のCランタイムライブラリ「libc-bootstrap」を使うことで、chibicc自身のビルドを可能にする）。
3. 上記のchibiccを使用して、Cランタイムライブラリを網羅している「newlib」と、不足する実装「libgloss」をビルドする。
4. 上記の完成したCランタイムライブラリ「libc.a」「libgloss.dll」を使用して、chibiccをビルドし直す。

を実行する必要があります。`build.sh`は、この手順を実行します。

`build.sh`は、Ubuntu (22.04/24.04) 向けに書かれています。必要なパッケージ等は自動的にインストールします。
この挙動が気に入らない場合は、事前にスクリプトの内容を確認してください（スクリプトは平易に書かれているはずです）。

## ご注意

現状で、あと10コミット程でchibicc移植達成という状態になっていますが、移植者はここで移植を断念しています。
理由については、以下の場で登壇して解説しています:

* [NGK2025S (名古屋合同懇親会2025)](https://ngk.connpass.com/event/334796/) (LT登壇なので、解説と言えるほどの内容はありません)
* [第9回 Center CLR 勉強会](https://centerclr.connpass.com/event/341192/)

また、 [YouTubeのchibicc移植リスト](https://www.youtube.com/playlist?list=PLL43LzwbRhvRL2PkpewoRv0AFVobTtZGt) でも公開するかも知れません（未定です）。

より詳しくは、各サブモジュール先のリポジトリを参照してください。
