package dsu;
sub new{
	return bless[(-1)x$_[1]],$_[0];
}
sub merge{
	my$self=shift;
	my$x=$self->leader($_[0]);
	my$y=$self->leader($_[1]);
	return$x if$x==$y;
	($x,$y)=($y,$x)if-$self->[$x]<-$self->[$y];
	$self->[$x]+=$self->[$y];
	return$self->[$y]=$x;
}
sub same{
	my$self=shift;
	return$self->leader($_[0])==$self->leader($_[1]);
}
sub leader{
	my$self=shift;
	my$a=shift;
	return$a if$self->[$a]<0;
	return$self->[$a]=$self->leader($self->[$a]);
}
sub size{
	return-$_[0]->[$_[1]];
}
sub groups{
	#TODO
}
package main;
my($N,$Q)=split$",<>;
my$dsu=dsu->new($N);
for(1..$Q){
	my($t,$u,$v)=split$",<>;
	if($t==0){
		$dsu->merge($u,$v);
	}
	else{
		print $dsu->same($u,$v)?1:0,$/;
	}
}
