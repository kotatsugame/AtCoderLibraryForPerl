# ModInt

## MOD

```perl
sub MOD(){10**9+7}
```

最適化がかかってインライン展開されます。

[perlsub - perldoc#Constant Functions](https://perldoc.perl.org/5.32.0/perlsub.html#Constant-Functions)

この値を書き換えればMODの値を変更できます。
また、外で定義した変数の値を返すようにすれば、実行時MODにも対応できます。この場合インライン展開は行われません。

## コンストラクタ

```perl
ModInt->new($a)
```

## 演算子

以下の演算子がオーバーロードされています。
正確には、`+,-,*,/,**,==,!=`(と数値化の演算子`0+`)がオーバーロードされており、それ以外の演算子はPerlによって自動生成されていれば使用できます。

[overload - perldoc#Magic Autogeneration](https://perldoc.perl.org/5.32.0/overload.html#Magic-Autogeneration)


```
-ModInt;

ModInt++;
ModInt--;
++ModInt;
--ModInt;

ModInt + ModInt;
ModInt - ModInt;
ModInt * ModInt;
ModInt / ModInt;
ModInt ** ModInt;

ModInt += ModInt;
ModInt -= ModInt;
ModInt *= ModInt;
ModInt /= ModInt;
ModInt **= ModInt;

ModInt == ModInt;
ModInt != ModInt;
```

また、2項演算子のどちらかのオペランドがModIntのオブジェクトであれば、オーバーロードされた演算子が呼び出されるので、`1+ModInt`や`ModInt*3`も動きます。
ModIntではないほうのオペランドに対して`ModInt->new`が呼び出されるわけではありません。必要に応じて内部でMODを取っています。

`**`演算子は、右項のMODを取らない実装になっているので、MODより大きな数でのべき乗も動作します。

`+`、`-`演算子は演算の後にしかMODを取っていないため、オーバーフローギリギリの値と演算をするとオーバーフローする場合があります。

## invmod

```perl
ModInt::invmod($a)
```

`/`演算子の実装のために用意された関数です。数値`x`を渡すと`xy≡1 mod MOD`なる`y`を返します。

現在の実装では`x**(MOD-2) mod MOD`を計算しているだけなので、MODは素数である必要があります。

# 使用例

* サンプルコード

```perl
use strict;
use warnings;
package ModInt;
# 省略
package main;
my$a=ModInt->new(2);
$\=$/;
print"\$a = ",$a;
print"-\$a = ",-$a;
print"";
print"\$a++ = ",$a++," changes to ",$a;
print"\$a-- = ",$a--," changes to ",$a;
print"++\$a = ",++$a;
print"--\$a = ",--$a;
print"";
print"\$a + 10**10 = ",$a+10**10;
print"\$a - 10**10 = ",$a-(10**10);
print"\$a * 10**10 = ",$a*10**10;
print"\$a / 10**10 = ",$a/10**10;
print"(\$a / 10**10 * 10**10 = ",($a/10**10)*10**10,")";
print"";
print"\$a == 10**9+7+2 = ",$a==10**9+7+2;
print"\$a != 10**9+7+5 = ",$a!=10**9+7+5;
```

`test1.pl`です。

* [AtCoder Beginner Contest 177 C - Sum of Product of pairs](https://atcoder.jp/contests/abc177/submissions/16627184)

`test2.pl`です。

