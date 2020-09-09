package FenwickTree;
sub new{
	return bless[(0)x$_[1]],$_[0];
}
sub add{
	my$self=shift;
	my($p,$x)=@_;
	$p++;
	while($p<=@{$self}){
		$self->[$p-1]+=$x;
		$p+=$p&-$p;
	}
}
sub sum{
	my$self=shift;
	return$self->prefixsum($_[1])-$self->prefixsum($_[0]);
}
sub prefixsum{
	my$self=shift;
	my$r=shift;
	my$s=0;
	while($r>0){
		$s+=$self->[$r-1];
		$r-=$r&-$r;
	}
	return$s;
}
