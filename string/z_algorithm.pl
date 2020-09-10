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
