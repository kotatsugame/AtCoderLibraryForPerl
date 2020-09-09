# クラスDSU

無向グラフに対して、

* 辺の追加
* 2頂点が連結かの判定

をならしO(α(n))時間で処理することが出来ます。

また、内部的に各連結成分ごとに代表となる頂点を1つ持っています。辺の追加により連結成分がマージされる時、新たな代表元は元の連結成分の代表元のうちどちらかになります。

## コンストラクタ

```perl
my$dsu=dsu->new($n)
```

* n頂点0辺の無向グラフを作ります。

## merge

```perl
$dsu->merge($a,$b)
```

## same

```perl
$dsu->same($a,$b)
```

## leader

```perl
$dsu->leader($a)
```

## size

```perl
$dsu->size($a)
```

## groups

未実装です。

# 使用例

## merge,same,leader

[AtCoder Library Practice Contest A - Disjoint Set Union](https://atcoder.jp/contests/practice2/submissions/16601739)

`test1.pl`です。

## size,groups

なし(未verify)

