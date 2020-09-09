use strict;
use warnings;
package Scc;
sub new{
	return bless[map[],1..$_[1]],$_[0];
}
sub add_edge{
	my$self=shift;
	push@{$self->[$_[0]]},$_[1];
}
sub scc_ids{
	my$self=shift;
	my$now_ord=0;
	my$group_num=0;
	my@low;
	my@ord=(-1)x@{$self};
	my@ids;
	my@visited;
	my$dfs;
	$dfs=sub{
		my$v=shift;
		$low[$v]=$ord[$v]=$now_ord++;
		push@visited,$v;
		for my$to(@{$self->[$v]}){
			if($ord[$to]==-1){
				$dfs->($to);
				$low[$v]=$low[$to]if$low[$v]>$low[$to];
			}
			else{
				$low[$v]=$ord[$to]if$low[$v]>$ord[$to];
			}
		}
		if($low[$v]==$ord[$v]){
			my$u=-1;
			while($u!=$v){
				$u=pop@visited;
				$ord[$u]=@{$self};
				$ids[$u]=$group_num;
			}
			$group_num++;
		}
	};
	for(0..$#ord){
		$dfs->($_)if$ord[$_]==-1;
	}
	$_=$group_num-1-$_ for@ids;
	return($group_num,\@ids);
}
sub scc{
	my$self=shift;
	my($group_num,$ids)=$self->scc_ids();
	my@groups=map[],1..$group_num;
	for(0..$#{$ids}){
		push@{$groups[$ids->[$_]]},$_;
	}
	return\@groups;
}
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
package main;
my($N,$D)=split$",<>;
my$twosat=TwoSat->new($N);
my@p;
for(1..$N){
	my($x,$y)=split$",<>;
	push@p,[$x,$y];
}
for my$i(0..$N-1){
	for my$j($i+1..$N-1){
		$twosat->add_clause($i,1,$j,1)if abs$p[$i][0]-$p[$j][0]<$D;
		$twosat->add_clause($i,1,$j,0)if abs$p[$i][0]-$p[$j][1]<$D;
		$twosat->add_clause($i,0,$j,1)if abs$p[$i][1]-$p[$j][0]<$D;
		$twosat->add_clause($i,0,$j,0)if abs$p[$i][1]-$p[$j][1]<$D;
	}
}
my($isok,$answer)=$twosat->satisfiable();
if($isok){
	print"Yes",$/;
	for(0..$N-1){
		print$p[$_][$answer->[$_]],$/;
	}
}
else{
	print"No",$/;
}
