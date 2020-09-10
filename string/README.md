# String

## z_algorithm

```perl
ZAlgorithm::z_algorithm(@s)
```

`ZAlgorithm->z_algorithm(@s)`のようにして呼び出さないでください。この形式で呼び出すと、引数の1番目に`"ZAlgorithm"`が入ってしまうからです。

8行目で引数の配列の要素を`eq`によって比較しています。これは文字列に対してz_algorithmを呼び出すことを念頭に置いた実装です。数値の配列に対して呼び出すならば、この比較は`==`のほうが適当であり、また速く動作します。(数値を`eq`で比較しても正しく動作するはずではあります。)

# 使用例

## z_algorithm

* [AtCoder Beginner Contest 135 F - Strings of Eternity](https://atcoder.jp/contests/abc135/submissions/16614898)

`test1.pl`です。

文字列に対して適用する際は、`split""`などを用いて、1文字ごとに区切ってから関数に渡してください。

* [AtCoder Beginner Contest 150 F - Xor Shift](https://atcoder.jp/contests/abc150/submissions/16615096)

`test2.pl`です。

整数の配列に対して適用するので、比較演算子を`==`に書き換えています。

