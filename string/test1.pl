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
my$N=<>;
my@A=map int,split$",<>;
my@B=map int,split$",<>;
my@T;
for(0..$N-1){
	$T[$_]=$B[$_]^$B[($_+1)%$N];
	$T[$_+$N]=$T[$_+2*$N]=$A[$_]^$A[($_+1)%$N];
}
my@z=ZAlgorithm::z_algorithm(@T);
for(0..$N-1){
	print$_,$",$A[$_]^$B[0],$/if$z[$_+$N]>=$N;
}
