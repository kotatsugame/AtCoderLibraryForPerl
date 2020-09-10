use strict;
use warnings;
package ZAlgorithm;
sub z_algorithm(@){
	my$n=@_;
	my@z=($n);
	my$i=1;
	my$j=0;
	while($i<$n){
		$j++while$i+$j<$n&&$_[$j]eq$_[$i+$j];
		$z[$i]=$j;
		if($j==0){
			$i++;
			next;
		}
		my$k=1;
		while($i+$k<$n&&$k+$z[$k]<$j){
			$z[$i+$k]=$z[$k];
			$k++;
		}
		$i+=$k;
		$j-=$k;
	}
	return@z;
}
package main;
my($s,$t)=map{chomp;$_}<>;
my@s=split"",$s;
my@t=split"",$t;
my@ss=(@s,@s);
push@ss,@s while@ss<@t*2;
my@z=ZAlgorithm::z_algorithm(@t,@ss);
my@ok=map$z[$_+@t]>=@t,0..$#s;
my@memo=(-1)x@s;
sub dfs{
	my$u=shift;
	if($memo[$u]>=0){
		return$memo[$u];
	}
	elsif($memo[$u]==-2){
		return$memo[$u]=1e9;
	}
	if($ok[$u]){
		$memo[$u]=-2;
		return$memo[$u]=dfs(($u+@t)%@s)+1;
	}
	else{
		return$memo[$u]=0;
	}
}
my$ans=0;
for(0..$#s){
	my$now=dfs($_);
	$ans=$now if$ans<$now;
}
print$ans<1e9?$ans:-1,$/;
