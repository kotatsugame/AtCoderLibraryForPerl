package TwoSat;
@TwoSat::ISA=qw(Scc);
sub new{
	return$_[0]->SUPER::new($_[1]*2);
}
sub add_clause{
	my$self=shift;
	$self->add_edge(2*$_[0]+!$_[1],2*$_[2]+!!$_[3]);
	$self->add_edge(2*$_[2]+!$_[3],2*$_[0]+!!$_[1]);
}
sub satisfiable{
	my$self=shift;
	my$ids=($self->scc_ids())[1];
	my@answer;
	for(0..@{$ids}/2-1){
		return 0 if$ids->[2*$_]==$ids->[2*$_+1];
		$answer[$_]=$ids->[2*$_]<$ids->[2*$_+1];
	}
	return(1,\@answer);
}
