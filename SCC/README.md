# SCC

## コンストラクタ

```perl
my$scc=Scc->new($n)
```

* n頂点0辺の有向グラフを作ります。

## add_edge

```perl
$scc->add_edge($from,$to)
```

## scc_ids

```perl
$scc->scc_ids()
```

本家のinternal_sccにある内部実装です。強連結成分の個数と、各ノードが属する強連結成分の番号のリストのリファレンスを組にして返します。強連結成分の番号はトポロジカル順序で振られています。

TwoSatの実装でも使用されるため、下のscc()と分けています。

## scc

```perl
$scc->scc()
```

本家と同様のものを、リストのリストにして返します。

返ってくるものはリストのリファレンスで、これをデリファレンスして得られるリストの各要素は、それぞれ対応する強連結成分に含まれる頂点のリストへのリファレンスです。

### 実装メモ

本家ではグラフの隣接リストを1つのvectorにまとめている。これは定数倍高速化の役割があるらしい。Perlにおいても同様の高速化が見込めるかについては検証していない。

scc内部でdfs関数を定義しているが、無名関数のリファレンスを変数に代入する形にしているのは、my宣言された変数のスコープの関係である。詳しくは以下のページを参照されたい。

[subの中にsub - 徒書](http://www.akatsukinishisu.net/itazuragaki/perl/sub_in_sub.html)

# 使用例

## add_edge,scc

* [AtCoder Library Practice Contest G - SCC](https://atcoder.jp/contests/practice2/submissions/16603426)

`test.pl`です。

