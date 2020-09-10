# Fenwick Tree

## コンストラクタ

```perl
my$fenwicktree=FenwickTree->new($n)
```

* 長さnの配列を作ります。初期値はすべて0です。

## add

```perl
$fenwicktree->add($p,$x)
```

p番目の値にxを足します。

## sum

```perl
$fenwicktree->sum($l,$r)
```

l番目からr-1番目までの和を返します。正確には、(0番目からr-1番目までの和)-(0番目からl番目までの和)を返します。

## prefixsum

```perl
$fenwicktree->prefixsum($r)
```

0番目からr-1番目までの和を返します。

# 使用例

## add,sum,prefixsum

* [AtCoder Library Practice Contest B - Fenwick Tree](https://atcoder.jp/contests/practice2/submissions/16603403)

`test.pl`です。

