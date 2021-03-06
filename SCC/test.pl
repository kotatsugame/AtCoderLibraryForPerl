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
package main;
my($N,$M)=split$",<>;
my$scc=Scc->new($N);
for(1..$M){
	my($a,$b)=split$",<>;
	$scc->add_edge($a,$b);
}
my$groups=$scc->scc();
print scalar(@{$groups}),$/;
for(@{$groups}){
	print scalar(@{$_}),$","@{$_}",$/;
}
