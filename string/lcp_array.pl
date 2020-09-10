package LcpArray;
sub lcp(\@\@){
	my@s=@{$_[0]};
	my$n=@s;
	my@sa=@{$_[1]};
	my@rnk;
	$rnk[$sa[$_]]=$_ for 0..$n-1;
	my@lcp;
	my$h=0;
	for(0..$n-1){
		$h--if$h>0;
		next if$rnk[$_]==0;
		my$j=$sa[$rnk[$_]-1];
		$h++while$j+$h<$n&&$_+$h<$n&&$s[$j+$h]==$s[$_+$h];
		$lcp[$rnk[$_]-1]=$h;
	}
	return@lcp;
}
sub lcp_array($@){
	my@s=map ord,split"",shift;
	return lcp(@s,@_);
}
