package scc;
sub new{
	return bless[map[],1..$_[1]],$_[0];
}
sub add_edge{
	my$self=shift;
	push@{$self->[$_[0]]},$_[1];
}
sub scc{
	my$self=shift;
	my$now_ord=0,$group_num=0,@low,@ord=(-1)x@{$self},@ids;
	my@visited;
	my$dfs;
	$dfs=sub{
		my$v=shift;
		$low[$v]=$ord[$v]=$now_ord++;
		push@visited,$v;
		for$to(@{$self->[$v]}){
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
	for$i(0..$#ord){
		$dfs->($i)if$ord[$i]==-1;
	}
	$_=$group_num-1-$_ for@ids;
	my@groups=map[],1..$group_num;
	for$i(0..$#ids){
		push@{$groups[$ids[$i]]},$i;
	}
	return\@groups;
}
