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

`test.pl`です。全然間に合いませんでした。

