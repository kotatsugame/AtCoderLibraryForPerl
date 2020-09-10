use strict;
use warnings;
package SuffixArray;
sub sa_is(\@$);
sub sa_is(\@$){
	my@s=@{$_[0]};
	my$upper=$_[1];
	my$n=@s;
	if($n==0){
		return();
	}
	elsif($n==1){
		return(0);
	}
	my@sa;
	my@ls;
	for(my$i=$n-2;$i>=0;$i--){
		$ls[$i]=$s[$i]==$s[$i+1]?$ls[$i+1]:$s[$i]<$s[$i+1];
	}
	my@sum_l=(0)x($upper+1);
	my@sum_s=(0)x($upper+1);
	$ls[$_]?$sum_l[$s[$_]+1]++:$sum_s[$s[$_]]++for 0..$n-1;
	for(0..$upper){
		$sum_s[$_]+=$sum_l[$_];
		$sum_l[$_+1]+=$sum_s[$_]if$_<$upper;
	}
	my$induce;
	$induce=sub{
		my@sa=(-1)x$n;
		my@buf=@sum_s;
		for(@_){
			next if$_==$n;
			$sa[$buf[$s[$_]]++]=$_;
		}
		@buf=@sum_l;
		$sa[$buf[$s[$n-1]]++]=$n-1;
		for(@sa){
			$sa[$buf[$s[$_-1]]++]=$_-1if$_>=1&&!$ls[$_-1];
		}
		@buf=@sum_l;
		for(my$i=$n-1;$i>=0;$i--){
			my$v=$sa[$i];
			$sa[--$buf[$s[$v-1]+1]]=$v-1if$v>=1&&$ls[$v-1];
		}
		return@sa;
	};
	my@lms=grep!$ls[$_-1]&&$ls[$_],1..$n-1;
	my@lms_map=(-1)x($n+1);
	my$m=@lms;
	for(0..$m-1){
		$lms_map[$lms[$_]]=$_;
	}
	@sa=$induce->(@lms);
	if($m){
		my@sorted_lms=grep$lms_map[$_]!=-1,@sa;
		my@rec_s;
		my$rec_upper=0;
		$rec_s[$lms_map[$sorted_lms[0]]]=0;
		for(1..$m-1){
			my$l=$sorted_lms[$_-1];
			my$r=$sorted_lms[$_];
			my$end_l=$lms[$lms_map[$l]+1]//$n;
			my$end_r=$lms[$lms_map[$r]+1]//$n;
			my$different;
			if($end_l-$l!=$end_r-$r){
				$different=1;
			}
			else{
				$l++,$r++while$l<$end_l&&$s[$l]==$s[$r];
				$different=$l==$n||$s[$l]!=$s[$r];
			}
			$rec_s[$lms_map[$sorted_lms[$_]]]=$rec_upper+=$different;
		}
		my@rec_sa=sa_is(@rec_s,$rec_upper);
		$sorted_lms[$_]=$lms[$rec_sa[$_]]for 0..$m-1;
		@sa=$induce->(@sorted_lms);
	}
	return@sa;
}
sub suffix_array($){
	my@s=map ord,split"",$_[0];
	return sa_is(@s,255);
}
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
package main;
my$s=<>;
chomp$s;
my@lcp=LcpArray::lcp_array($s,SuffixArray::suffix_array($s));
my$ans=length($s)*(length($s)+1)/2;
$ans-=$_ for@lcp;
print$ans,$/;
