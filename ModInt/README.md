# ModInt

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

びっくりするほど遅いので何か問題を解くのは諦めました。ほとんどテストしていません。

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
