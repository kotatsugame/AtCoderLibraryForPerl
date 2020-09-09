# SCC

## コンストラクタ

```perl
my$scc=scc->new($n)
```

* n頂点0辺の有向グラフを作ります。

## add_edge

```perl
$scc->add_edge($from,$to)
```

## scc

```perl
$scc->scc()
```

本家と同様のものを、リストのリストにして返します。

返ってくるものはリストのリファレンスで、これをデリファレンスして得られるリストの各要素は、それぞれ対応する強連結成分に含まれる頂点のリストへのリファレンスです。

# 使用例

## add_edge,scc

[AtCoder Library Practice Contest G - SCC](https://atcoder.jp/contests/practice2/submissions/16602600)

`test.pl`です。

