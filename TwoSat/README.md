# 2-SAT

Sccを継承します。useを書いていないので、同じファイル内に[scc.pl](https://github.com/kotatsugame/AtCoderLibraryForPerl/blob/master/SCC/scc.pl)の内容をコピペしてください。

## コンストラクタ

```perl
my$twosat=TwoSat->new($n)
```

## add_clause

```perl
$twosat->add_clause($i,$f,$j,$g)
```

fとgはtruthy/falsyであればよい(はず)です。内部で`!`を1回または2回適用します。falsyな値を論理否定すると必ず1が得られることを仮定しています。

## satisfiable

```perl
$twosat->satisfiable()
```

条件を満たす割り当てが存在しない場合は数値の0のみを返します。

条件を満たす割り当てが存在した場合、数値の1と、条件を満たす割り当てのリストのリファレンスを組にして返します。これは本家ではanswer()によって得られるものでしたが、そういうメンバ変数を保持するコストを鑑みて、同時に返す実装にしました。

割り当てのリストの内容は真偽値です。具体的には、数値を`<`演算子で比較した結果をそのまま代入しています。真の場合は1ですが、偽の場合は少し特殊で、数値として評価すると警告を発さず0になるような、特別な空文字列です。

[perlop#Relational Operators - perldoc](https://perldoc.perl.org/5.32.0/perlop.html#Relational-Operators)

# 使用例

[AtCoder Library Practice Contest H - Two SAT](https://atcoder.jp/contests/practice2/submissions/16603538)

`test.pl`です。

