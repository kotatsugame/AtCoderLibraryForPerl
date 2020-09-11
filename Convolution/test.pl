use strict;
use warnings;
package Convolution;
use integer;
sub MOD(){998244353};
sub primitive_root(){3};
sub powermod($$){
	my($v,$w)=@_;
	my$r=1;
	$v%=MOD;
	while($w>0){
		$r=$r*$v%MOD if$w&1;
		$v=$v*$v%MOD;
		$w>>=1;
	}
	return$r;
}

my(@es,@ies,@sum_e,@sum_ie);
{
	my$cnt2=0;
	$cnt2++until MOD-1>>$cnt2&1;
	my$e=powermod(primitive_root,MOD-1>>$cnt2);
	my$ie=powermod($e,MOD-2);
	for(my$i=$cnt2;$i>=2;$i--){
		$es[$i-2]=$e;
		$ies[$i-2]=$ie;
		$e=$e*$e%MOD;
		$ie=$ie*$ie%MOD;
	}
	my$now=1;
	my$inow=1;
	for(0..$cnt2-3){
		$sum_e[$_]=$es[$_]*$now%MOD;
		$now=$now*$ies[$_]%MOD;
		$sum_ie[$_]=$ies[$_]*$inow%MOD;
		$inow=$inow*$es[$_]%MOD;
	}
}

sub convolution(\@\@){
	my@a=@{$_[0]};
	my@b=@{$_[1]};
	my$n=@a;
	my$m=@b;
	return()if$n==0||$m==0;
	my$h=0;
	$h++while$n+$m-1>1<<$h;
	my$z=1<<$h;
	my@bsf;
	for my$i(0..$h-1){
		for(1..1<<$h-$i-1){
			$bsf[($_<<$i)-1]=$i;
		}
	}
	#butterfly @a,@b
	for my$ph(1..$h){
		my$w=1<<$ph-1;
		my$p=1<<$h-$ph;
		my$now=1;
		for my$s(0..$w-1){
			my$offset=$s<<$h-$ph+1;
			for($offset..$offset+$p-1){
				my$l=$a[$_];
				my$r=$a[$_+$p]*$now%MOD;
				$a[$_]=($l+$r)%MOD;
				$a[$_+$p]=($l-$r+MOD)%MOD;
				$l=$b[$_];
				$r=$b[$_+$p]*$now%MOD;
				$b[$_]=($l+$r)%MOD;
				$b[$_+$p]=($l-$r+MOD)%MOD;
			}
			$now=$now*$sum_e[$bsf[$s]]%MOD;
		}
	}
	$a[$_]=$a[$_]*$b[$_]%MOD for 0..$z-1;
	#butterfly_inv @a
	for(my$ph=$h;$ph>=1;$ph--){
		my$w=1<<$ph-1;
		my$p=1<<$h-$ph;
		my$inow=1;
		for my$s(0..$w-1){
			my$offset=$s<<$h-$ph+1;
			for($offset..$offset+$p-1){
				my$l=$a[$_];
				my$r=$a[$_+$p];
				$a[$_]=($l+$r)%MOD;
				$a[$_+$p]=($l-$r+MOD)*$inow%MOD;
			}
			$inow=$inow*$sum_ie[$bsf[$s]]%MOD;
		}
	}
	$#a=$n+$m-2;
	my$iz=powermod($z,MOD-2);
	$_=$_*$iz%MOD for@a;
	return@a;
}
no integer;
package main;
my($N,$M)=split$",<>;
my@a=split$",<>;
my@b=split$",<>;
print$_,$/for Convolution::convolution(@a,@b);

