# String

## z_algorithm

```perl
ZAlgorithm::z_algorithm(@s)
```

`ZAlgorithm->z_algorithm(@s)`のようにして呼び出さないでください。この形式で呼び出すと、引数リストの先頭に`"ZAlgorithm"`が入ってしまうからです。

8行目で引数のリストの要素を`eq`によって比較しています。これは文字列に対してz_algorithmを呼び出すことを念頭に置いた実装です。数値のリストに対して呼び出すならば、この比較は`==`のほうが適当であり、また速く動作します。

## sa_is

```perl
SuffixArray::sa_is(@s,$upper)
```

`@s`は数値のリストです。この順番の引数を実現するためにプロトタイプ宣言`\@$`をしているため、例えば`map`や他の関数の返り値をそのまま渡したりはできません。

### 実装メモ

本家の実装では`induce`関数は外側の`sa`配列を直接書き換えているが、試してみたところPerlでは遅くなっていそうなので、毎回`@sa`を作成して返すようにしている。

## suffix_array

```perl
SuffixArray::suffix_array($s)
```

上の`sa_is`関数を文字列に適用するためのラッパーです。内部では文字列を1文字ごとに区切り、`ord`関数を適用したリストを作成して、`SuffixArray::sa_is(@s,255)`を呼び出しています。

## lcp

```perl
LcpArray::lcp(@s,@sa)
```

`@s`は数値のリストです。リスト2つを引数にするため、プロトタイプ宣言`\@\@`をしています。そのため、`sa_is`と同様、この関数の引数に`map`やその他の関数の返り値をそのまま渡すことはできません。

## lcp_array

```perl
LcpArray::lcp_array($s,@sa)
```

`@sa`は`SuffixArray::suffix_array($s)`が返すものです。変数を作成せず、直接`lcp_array`の引数に渡してもよいです。

この関数も上の`lcp`関数を文字列に適用するためのラッパーという扱いなので、内部で文字コードのリストを作成しています。この2度手間を嫌う場合は、外でリストを作成した後直接`sa_is`や`lcp`関数を呼んでください。

# 使用例

## z_algorithm

* [AtCoder Beginner Contest 135 F - Strings of Eternity](https://atcoder.jp/contests/abc135/submissions/16614898)

`test1.pl`です。

文字列に対して適用する際は、`split""`などを用いて、1文字ごとに区切ってから関数に渡してください。

* [AtCoder Beginner Contest 150 F - Xor Shift](https://atcoder.jp/contests/abc150/submissions/16615096)

`test2.pl`です。

整数の配列に対して適用するので、比較演算子を`==`に書き換えています。

## sa_is,suffix_array,lcp,lcp_array

* [AtCoder Library Practice Contest I - Number of Substrings](https://atcoder.jp/contests/practice2/submissions/16620606)

`test3.pl`です。

