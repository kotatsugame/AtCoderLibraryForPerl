# Convolution

## Number Theoretic Transform

```perl
Convolution::convolution(@a,@b)
```

畳み込みを`mod MOD`で計算します。

```perl
sub MOD(){998244353}
sub primitive_root(){3}
```

MODの値と、それに対応する原始根の値です。最適化がかかってインライン展開されます。
MODの値を変更したい場合は、この関数を書き換えてください。

# 使用例

* Number Theoretic Transform

[AtCoder Library Practice Contest F - Convolution](https://atcoder.jp/contests/practice2/submissions/16631265)

`test1.pl`です。全然間に合いませんでした。

[AtCoder Typical Contest 001 C - 高速フーリエ変換](https://atcoder.jp/contests/atc001/submissions/16656446)

`test2.pl`です。こちらは余裕をもって間に合いました。

畳み込み後の要素の最大値は`10^5*100^2 = 10^9`程度と見積もることができます。そこで、MODとして`10^9`を超える`1012924417 = 2^21*483+1`を使用することで、値の復元が必要なくなります。このMODに対応する最小の原始根は5なので、その値も書き換えています。

