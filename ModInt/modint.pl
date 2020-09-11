package ModInt;
use constant MOD=>10**9+7;
use overload
	"+"=>\&modadd,
	"-"=>\&modsub,
	"*"=>\&modmul,
	"/"=>\&moddiv,
	"**"=>\&modpow,
	"=="=>\&modeq,
	"!="=>\&modne,
	"0+"=>sub{return${$_[0]}},
;
sub new{
	my$class=shift;
	return bless\($_[0]%MOD),$class;
}
sub modadd{
	my($x,$y)=@_;
	return bless\(($$x+(ref$y?$$y:$y))%MOD),ref$x;
}
sub modsub{
	my($x,$y)=@_;
	my$v=$$x;
	$v-=ref$y?$$y:$y;
	$v=-$v if$_[2];
	$v%=MOD;
	return bless\$v,ref$x;
}
sub modmul{
	my($x,$y)=@_;
	return bless\((ref$y?$$y:$y%MOD)*$$x%MOD),ref$x;
}
sub moddiv{
	my($x,$y)=@_;
	my$v=$$x;
	my$w=ref$y?$$y:$y%MOD;
	$v=$_[2]?$w*modinv($v)%MOD:$v*modinv($w)%MOD;
	return bless\$v,ref$x;
}
sub modpow{
	my($x,$y)=@_;
	my$r=1;
	my$v=$$x;
	my$w=$y;
	($v,$w)=($w,$v)if$_[2];
	$v%=MOD;
	while($w>0){
		$r=$r*$v%MOD if$w&1;
		$v=$v*$v%MOD;
		$w>>=1;
	}
	return bless\$r,ref$x;
}
sub modeq{
	my($x,$y)=@_;
	my$v=$$x;
	my$w=ref$y?$$y:$y%MOD;
	return$v==$w;
}
sub modne{
	my($x,$y)=@_;
	my$v=$$x;
	my$w=ref$y?$$y:$y%MOD;
	return$v!=$w;
}
sub modinv{
	my$r=1;
	my$a=shift;
	my$n=MOD-2;
	while($n>0){
		$r=$r*$a%MOD if$n&1;
		$a=$a*$a%MOD;
		$n>>=1;
	}
	return$r;
}
