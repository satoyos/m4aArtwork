# m4aへのArtwork画像付与ツール"atomicparsley"を使いやすくするシェルスクリプト

以下の記事で紹介されていたシェルスクリプトをそのまま拝借。
- [【Mac】m4a ファイルに画像を貼付 - 林檎コンピュータ](https://mac-ra.com/atomicparsley-shellscript/)

## atomicparsley

atomicparsley は mp4 ファイルの ID タグを操作するコマンドだそうな。Macでは、Homebrew で簡単にインストールできる。

```bash
$ brew install atomicparsley
```

### atomicparsley でアートワークを設定するには

基本は`atomicparsley m4aファイル --artwork 画像ファイル`でいいみたい。
元記事によると、
> 画像形式は jpg か png である。

とのこと。

```bash
atomicparsley /path/to/INPUT.m4a --artwork /path/to/art.jpg
```

これにより、元のm4aファイルそのものには手を加えず、新たにアートワーク画像を埋め込んだファイルを作って、`ファイル名-temp-番号.m4a`という名前で保存してくれる。

あとの使い方は、ヘルプを読もう。
```bash
$ atomicparsley -h
```

## atomicparsleyをフォルダ単位に適用するシェルスクリプト

こちらが本リポジトリの本題。

`-f`というオプションをつけて m4a ファイルの入ったフォルダを指定する。(Finderから、フォルダをターミナルやiTerm2にドラッグアンドドロップで投下するのが簡単)

```bash
$ sh artwork.sh -f フォルダ 画像ファイル
```
という感じで使うと、そのフォルダ内に`temp`フォルダができ、処理済みのファイルがその下に格納される。