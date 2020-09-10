# DSU

## コンストラクタ

```perl
my$dsu=Dsu->new($n)
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

* [AtCoder Library Practice Contest A - Disjoint Set Union](https://atcoder.jp/contests/practice2/submissions/16603064)

`test1.pl`です。

## size,groups

なし(未verify)

