#!/usr/bin/perl

use strict;
use warnings;
use feature ':5.10';

# NOTE:
#  - input file is .csv format. It must be deleted comma "," in cell in advance.
#  - some field (e.g. URL) might be collapsed due to deleting ";" and ","

#===========
# [0-1] Define Valuables 
#===========
my $fdir = '/c/Users/3980285/Documents/0_Doc/40_Data_Analysis/20_Disty_Web_Analysis/10_Import.io/FY17-18';
#my $fdir = '/c/Users/3980285/Documents/0_Doc/40_Data_Analysis/20_Disty_Web_Analysis/20_Work/exec';

my $libdir = '/c/Users/3980285/Documents/0_Doc/40_Data_Analysis/20_Disty_Web_Analysis/20_Work/lib';
#my $fdir = '.';
#my @filelist = `ls | sort `;
#my @filelist = `ls $fdir |sort`;

#my @filelist = `ls $fdir | grep "^0[1-4]" |sort`;
#my @filelist = `ls $fdir | grep "^05" |sort`;
#my @filelist = `ls $fdir | grep "^0[6-9]" |sort`;
#my @filelist = `ls $fdir | grep "^1" |sort`;
#my @filelist = `ls $fdir | grep "^2" |sort`;
#my @filelist = `ls $fdir | grep "^3" |sort`;
#my @filelist = `ls $fdir | grep "^4[0-8]" |sort`;
#my @filelist = `ls $fdir | grep "^49" |sort`;
#my @filelist = `ls $fdir | grep "^5" |sort`;

#my @filelist = `ls $fdir | grep "^49-DK" | sort`;
#my @filelist = `ls $fdir | egrep (MS-PhotoMOS|MS-Tact_Switch) |sort`;
#my @filelist = `ls $fdir | grep "DK-Tact_Switch" |sort`;
#my @filelist = `ls $fdir | grep "MS-SMD_Lytic" | grep "2018-10-31" | sort`;
#my @filelist = `ls $fdir | grep "BtoB" |sort`;
my @filelist = `ls $fdir |grep "^04-MS" |grep "2019-03-31" |sort`;

my $file;
my $skipfile = 'n';
my $f;
my $f0 = '';
my $f1 = '';
my $f2;
my $Disty = '';
my $Prod = '';
my @adate;
my @field;
my $date;
my $date2;
my %date;
#my $ofile;
my $ofile2;
my $ofile3;
my $ofile4;
my $ofile0;
my $fc;
my $lc;
my @pnlist;
my @pnlist_daily;
my @mpnlist;
my $count = '0';
my $preline = '';

#===========
# [0-2] Define Valuables for Identify section
#===========
my %MPN;
my $MPN;
my $PN;
my %Supplier;
my %Description;
my $Stock;
my %Stock;
my %UnitPrice;

my $Unit;
my $Value;

my %minimum;

my %DiffStock;
my %Quantity;
my %Transaction;
my %SumOfTransaction;
my %SumOfQuantity;

my %Price;
my %PrevPrice;
my %DiffPrice;
my %DiffPriceFlag;
my %DiffPriceCount;

#-----
# - SD_Card -
#-----
my @sdpnlist;

#-----
# - Spec -
#-----
my %AECQ200;
my %Accuracy;
my %ActuatorType;
my %Adhesive;
my %Adjustment;
my %AntiV;
my %Application;
my %Approvals;
my %BackingCarrier;
my %BreakingCapacity;
my %BuiltInSwitch;
my %Bushing;
my %BValue;
my %Capacitance;
my %Capacity;
my %CaseCodeI;
my %CCT;
my %Cell;
my %Channels;
my %Chemistry;
my %CMTI;
my %CoilCurrent;
my %CoilType;
my %CoilVoltage;
my %CoilVoltageAC;
my %CoilVoltageDC;
my %Color;
my %Composition;
my %Configuration;
my %Contact;
my %ContactForm;
my %ContactRating;
my %Control;
my %Core;
my %CRI;
my %Current;
my %CurrentTest;
my %CurrentMax;
my %CurrentPeak;
my %CurrentRating;
my %CurrentSaturation;
my %CurrentSurge;
my %DataRate;
my %DCR;
my %Detent;
my %Diameter;
my %Diameter2;
my %Dielectric;
my %Dimming;
my %Distortion;
my %Dummy;
my %Efficiency;
my %Energy;
my %EncodeType;
my %Esr;
my %FailureRate;
my %Features;
my %FilterType;
my %Flux;
my %Frequency;
my %FrequencyTest;
my %Function;
my %Height;
my %HeightMax;
my %If;
my %ImageLink;
my %Inductance;
my %Inputs;
my %InputType;
my %Interface;
my %Io;
my %Iout;
my %LeadSpacing;
my %Length;
my %LensType;
my %LES;
my %Life;
my %Lines;
my %Lumens;
my %Mated;
my %MaximumPressure;
my %Material;
my %Melting;
my %Memory;
my %MemoryFormat;
my %MemorySize;
my %MOQ;
my %Mounting;
my %NumberOfCircuits;
my %OperateTime;
my %OperatingPressure;
my %Opforce;
my %Opforce2;
my %OpTemp;
my %OpTempH;
my %OpTempL;
my %Orientation;
my %Output;
my %OutputCount;
my %OutputType;
my %Outline;
my %Package;
my %PackageCase;
my %PhaseCount;
my %Pitch;
my %PNLink;
my %PortSize;
my %PortStyle;
my %Position;
my %Power;
my %PowerRating;
my %PressureType;
my %Protection;
my %PropagationDelay;
my %Pulses;
my %Q;
my %Qg;
my %Ratings;
my %Rds;
my %RelayType;
my %ReleaseTime;
my %Reliability;
my %Res25;
my %Resistance;
my %Resolution;
my %ResponseTime;
my %ResTolerance;
my %ReverseLeakageCurrent;
my %Ripple;
my %RiseFallTime;
my %Ron;
my %Rotation;
my %RotationalLife;
my %ScreenSize;
my %SensorType;
my %Series;
my %Series1;
my %Series2;
my %Shape;
my %Shielding;
my %Size;
my %Speed;
my %SPQ;
my %StartDate;
my %Status;
my %SupplierPackage;
my %Swf;
my %SwitchingVoltage;
my %Synchronous;
my %Tech;
my %Technology;
my %Term;
my %Termination;
my %TerminationCount;
my %Temperature;
my %Temperature_Coefficient;
my %TempLocal;
my %TempMin;
my %TempMax;
my %TempRemote;
my %TestCondition;
my %ThermalConductivity;
my %ThermalResistivity;
my %Thickness;
my %Tolerance;
my %Topology;
my %trr;
my %TurnOnVoltage;
my %TurnOffVoltage;
my %Type;
my %Type1;
my %Type2;
my %Usage;
my %VAC;
my %Vce;
my %VDC;
my %Vds;
my %Vf;
my %Vgemax;
my %Vgsmax;
my %Vgsth;
my %ViewingAngle;
my %Vin;
my %VinMax;
my %VinMin;
my %Vmax;
my %Vmin;
my %Vout;
my %Voltage;
my %VoltageIsolation,
my %VoltageRatingAC;
my %VoltageRatingDC;
my %Volume;
my %Vr;
my %Vtyp;
my %Width;
my %Wavelength;

#-----
# - reference Library -
#-----
my %supplier;
my @supplier = ();
my %casecode;
my @casecode = ();
my %refMounting;
my @refMounting = ();
my %refTerm;
my @refTerm = ();
my %refCurrency;
my %refCurrencyH;
my @refCurrency = ();



#===========
# - Sub routine
#===========
                    
sub subStatus_old{
    my ($i) = @_;
    if ($i =~/Digi-Reel/){next;}
    elsif ($i =~/Obsolete/){next;}
    elsif ($i =~/Not For New Designs/){next;}
    elsif ($i =~/Discontinued at Digi-Key/){next;}
    elsif ($i =~/Preliminary/){next;}
    elsif ($i =~/Last Time Buy/){next;}
    return "$i";
}

sub subStatus{
    my ($i) = @_;
    if ($i =~/Digi-Reel/ || $i =~/Obsolete/ || $i =~/Not For New Designs/ || $i =~/Discontinued at Digi-Key/ || $i =~/Preliminary/ || $i =~/Last Time Buy/){
        return "1";
    }else{
        return "0";
    }
}

sub subMOQ{
    my ($i) = @_;
    $i =~ s/ Minimum.*//; $i =~s/Non-Stock.*//; $i =~s/-//;
    #Arrow
    $i =~ s/Per Unit/1/; $i =~s/\+//;
    return "$i";
    #if ($i ne '1'){next;}
}

sub subPN_daily{
    my ($i, $file) = @_;
    $i =~ s/; Learn More//;
    $PN = "$i";
    if(! grep {$_ eq $PN} @pnlist_daily) {
        push(@pnlist_daily,$PN);
        return "0";
    }else{
        print "\[WARNING\]: PN $i is duplicated.\n";
        return "1";
    }
}

sub subPN{
    my ($i, $file) = @_;
    $i =~ s/; Learn More//;
    $PN = "$i";
    if(! grep {$_ eq $PN} @pnlist) {
         push(@pnlist,$PN);
         $StartDate{$Disty}{$PN} = "$date";
         $SumOfTransaction{$Disty}{$PN} = "0";
         $SumOfQuantity{$Disty}{$PN} = "0";
    }
}

sub subMPN{
    my ($i, $file) = @_;
    $MPN = "$i";
    if(! grep {$_ eq $MPN} @mpnlist) {
         push(@mpnlist,$MPN);
    }
}

sub subSupplier{
    my ($i, $file) = @_;
    $i =~ s/; .*//;
    if($i eq ''){
        return '';
    }elsif(grep {$_ eq "$i"} @supplier) {
        return $supplier{"$i"};
    }else{
        print "\[WARNING\]: Supplier $i not Found. line $lc of $file\n";
        return "$i";
    }
}

sub subTime{
    my ($i,$file) = @_;
    $i =~ s/\s//g;
    if($i eq ''){
        return '';
    }elsif($i =~/[0-9]ps/){
        $i =~ s/ps/E-12/;
        return "$i";
    }elsif($i =~/[0-9]ns/){
        $i =~ s/ns/E-9/;
        return "$i";
    }elsif($i =~/[0-9]us/){
        $i =~ s/us/E-6/;
        return "$i";
    }elsif($i =~/[0-9]µs/){
	$i =~ s/µs/E-6/;
        return "$i";
    }elsif($i =~/[0-9]µs/){
	$i =~ s/µs/E-6/;
        return "$i";
    }elsif($i =~/[0-9]ms/){
        $i =~ s/ms/E-3/;
        return "$i";
    }elsif($i =~/[0-9]s/){
        $i =~ s/s//;
        return "$i";
    }elsif($i eq '-'){
        return "";
    }else{
        print "\[WARNING\]: subTime, Unknown unit $i line $lc of $file\n";
        return "$i";
    }
}

sub subCap{
    my ($i,$file) = @_;
    $i =~ s/\s//g;
    if($i eq ''){
        return '';
    }elsif($i =~/[0-9]pF/){
        $i =~ s/pF/E-12/;
        return "$i";
    }elsif($i =~/[0-9]nF/){
        $i =~ s/nF/E-9/;
        return "$i";
    }elsif($i =~/[0-9]uF/){
        $i =~ s/uF/E-6/;
        return "$i";
    }elsif($i =~/[0-9]µF/){
	$i =~ s/µF/E-6/;
        return "$i";
    }elsif($i =~/[0-9]µF/){
	$i =~ s/µF/E-6/;
        return "$i";
    }elsif($i =~/[0-9]mF/){
        $i =~ s/mF/E-3/;
        return "$i";
    }elsif($i =~/[0-9]F/){
        $i =~ s/F//;
        return "$i";
    }elsif($i eq '-'){
        return "";
    }else{
        print "\[WARNING\]: subCap, Unknown unit $i line $lc of $file\n";
        return "$i";
    }
}

sub subInd{
    my ($i,$file) = @_;
    $i =~ s/\s//g;
    if($i eq ''){
        return '';
    }elsif($i =~/[0-9]nH/){
        $i =~ s/nH/E-9/;
        return "$i";
    }elsif($i =~/[0-9]uH/){
        $i =~ s/uH/E-6/;
        return "$i";
    }elsif($i =~/[0-9]µH/){
	$i =~ s/µH/E-6/;
        return "$i";
    }elsif($i =~/[0-9]mH/){
	$i =~ s/mH/E-3/;
        return "$i";
    }elsif($i =~/[0-9]H/){
	$i =~ s/H//;
        return "$i";
    }elsif($i eq '-'){
        return "";
    }else{
        print "\[WARNING\]: subInd, Unknown unit $i line $lc of $file\n";
        return "$i";
    }
}

sub subCur{
    my ($i,$file) = @_;
    $i =~ s/\s//g;
    $i =~ s/rms//g;
    if($i eq ''){
        return '';
    }elsif($i =~/[0-9]pA/){
        $i =~ s/pA/E-12/;
        return "$i";
    }elsif($i =~/[0-9]nA/){
        $i =~ s/nA/E-9/;
        return "$i";
    }elsif($i =~/[0-9]uA/){
        $i =~ s/uA/E-6/;
        return "$i";
    }elsif($i =~/[0-9]µA/){
	$i =~ s/µA/E-6/;
        return "$i";
    }elsif($i =~/[0-9]mA/){
        $i =~ s/mA/E-3/;
        return "$i";
    }elsif($i =~/[0-9]kA/){
        $i =~ s/kA/E+3/;
        return "$i";
    }elsif($i =~/[0-9]A/){
	$i =~ s/A//;
        return "$i";
    }elsif($i eq '-'){
        return "";
    }else{
        print "\[WARNING\]: subCur, Unknown unit $i line $lc of $file\n";
        return "$i";
    }
}


sub subVol{
    my ($i,$file) = @_;
    $i =~ s/\s//g;
    $i =~ s/VAC/V/g; $i =~ s/VDC/V/g;
    if($i eq ''){
        return '';
    }elsif($i =~/[0-9]mV/){
        $i =~ s/mV/E-3/;
        return "$i";
    }elsif($i =~/[0-9]kV/){
        $i =~ s/kV/E+3/;
        return "$i";
    }elsif($i =~/[0-9]V/){
        $i =~ s/V//;
        return "$i";
    }elsif($i eq '-'){
        return "";
    }else{
        print "\[WARNING\]: subVol, Unknown unit $i line $lc of $file\n";
        return "$i";
    } 
} 

sub subRes{
    my ($i,$file) = @_;
    $i =~ s/\s//g;
    $i =~ s/Ohm.*//;
    if($i eq ''){
        return '';
    }elsif($i =~/[0-9]u/){
        $i =~ s/u/E-6/;
        return "$i";
    }elsif($i =~/[0-9]µ/){
	$i =~ s/µ/E-6/;
        return "$i";
    }elsif($i =~/[0-9]µ/){
	$i =~ s/µ/E-6/;
        return "$i";
    }elsif($i =~/[0-9]m/){
        $i =~ s/m/E-3/;
        return "$i";
    }elsif($i =~/[0-9]k/){
        $i =~ s/k/E+3/;
        return "$i";
    }elsif($i =~/[0-9]M/){
        $i =~ s/M/E+6/;
        return "$i";
    }elsif($i eq '-'){
        return "";
    }else{
        #print "\[WARNING\]: subRes, Unknown unit $i line $lc of $file\n";
        return "$i";
    }
}

sub subOptemp{
    my ($i,$file) = @_;
    $i =~ s/\s//g;
    if($i eq ''){
        return '';
    }elsif($i =~/°C/){
        $i =~ s/°C//g;
        return "$i";
    }elsif($i =~/C/){
        $i =~ s/C//g; $i =~ s/to\+/~/g;
        return "$i";
    }elsif($i eq '-'){
        return "";
    }else{
        print "\[WARNING\]: subOptemp, Unknown unit $i line $lc of $file\n";
        return "$i";
    }
}

sub subLen{
    my ($i,$file) = @_;
    $i =~ s/\s//g;
    if($i eq ''){
        return '';
    }elsif($i =~/nm/){
        $i =~ s/nm/E-9/;
        return "$i";
    }elsif($i =~/um/){
        $i =~ s/um/E-6/;
        return "$i";
    }elsif($i =~/µm/){
	$i =~ s/µm/E-6/;
        return "$i";
    }elsif($i =~/mm/){
    	$i =~s/mm/E-3/;
        return "$i";
    }elsif($i =~/m/){
    	$i =~s/m//;
        return "$i";
    }elsif($i =~/in/){
    	$i =~s/in//; $i = $i*0.0254;
        return "$i";
    }elsif($i eq '-'){
        return "";
    }else{
        print "\[WARNING\]: subLen, Unknown unit $i line $lc of $file\n";
        return "$i";
    }
}

sub subCasecode{
    my ($i,$file) = @_;
    if(grep {$_ eq "$i"} @casecode) {
        return $casecode{"$i"};
    }elsif($i eq ""){
        return "$i";
    }else{
        print "\[WARNING\]: Casecode $i not Found. line $lc of $file\n";
        return "$i";
    }
}

sub subMounting{
    my ($i,$file) = @_;
    if(grep {$_ eq "$i"} @refMounting) {
        return $refMounting{"$i"};
    }elsif($i eq ""){
        return "$i";
    }else{
        print "\[WARNING\]: Mounting $i not Found. line $lc of $file\n";
        return "$i";
    }
}

sub subTerm{
    my ($i,$file) = @_;
    if(grep {$_ eq "$i"} @refTerm) {
        return $refTerm{"$i"};
    }elsif($i eq ""){
        return "$i";
    }else{
        print "\[WARNING\]: Term $i not Found. line $lc of $file\n";
        return "$i";
    }
}

sub subStock{
    my ($i,$j,$file) = @_;
    # Mouser
    if($i =~/Lead-Time/ || $i =~/Non-Stocked/ || $i =~/Non-stocked/ || $i =~/Not Available/ || $i =~/Learn/ || $i =~/N\/A/ || $i =~/On Order/ || $i =~/Awaiting Delivery/ ||  $i =~/Drop Ship/ || $i eq ""){ $i = "0";}
    $i =~ s/; In Stock.*//; $i =~ s/In Stock.*//; $i =~ s/ in stock.*//; $i =~ s/Stock Available.*//; $i =~ s/ Available.*//;
    # Digikey
    if($i =~/Standard Lead Time/){ $i =~ s/Standard Lead Time.*$//g;}
    if($i =~/Value Added Item/){ $i =~ s/Value Added Item.*$/0/g;}
    $i =~ s/\s//g; $i =~ s/[;-].*//g;
    if($i =~ /^[0-9]+$/){
	 if(defined $Stock{"$Disty"}{"$PN"}){
            $DiffStock{"$Disty"}{"$PN"} = $i - $Stock{"$Disty"}{"$PN"};
            if($DiffStock{"$Disty"}{"$PN"} < 0){
                $Quantity{"$Disty"}{"$PN"} = -$DiffStock{"$Disty"}{"$PN"};
                $Transaction{"$Disty"}{"$PN"} = '1';
                $SumOfTransaction{"$Disty"}{"$PN"} += '1';
                $SumOfQuantity{"$Disty"}{"$PN"} += $Quantity{$Disty}{$PN};
            }else{
                $Quantity{"$Disty"}{"$PN"} = '0';
                $Transaction{"$Disty"}{"$PN"} = '0';
            }
        }else{
            $DiffStock{"$Disty"}{"$PN"} = "0";
            $Quantity{"$Disty"}{"$PN"} = '0';
            $Transaction{"$Disty"}{"$PN"} = '0';
        }
        $Stock{"$Disty"}{"$PN"} = "$i";
    }else{
        #print "\[ERROR\]: Stock $i is not number. line $lc of $file\n";
    }
    # ======================
    # Price
    # ======================
    $j =~ s/\s//g; $j =~ s/[;-].*//g; $j =~ s/\$//g;
    if($j =~ /^[0-9.]+$/){
        if(defined $Price{"$Disty"}{"$PN"}){
            $PrevPrice{"$Disty"}{"$PN"} = $Price{"$Disty"}{"$PN"};
            $DiffPrice{"$Disty"}{"$PN"} = $j - $Price{"$Disty"}{"$PN"};
            if($DiffPrice{"$Disty"}{"$PN"} != 0){
                $DiffPriceFlag{"$Disty"}{"$PN"} = '1';
                $DiffPriceCount{"$Disty"}{"$PN"} += '1';
            }
        }else{
            $PrevPrice{"$Disty"}{"$PN"} = "0";
            $DiffPrice{"$Disty"}{"$PN"} = "0";
            $DiffPriceFlag{"$Disty"}{"$PN"} = '0';
        }
        $Price{"$Disty"}{"$PN"} = "$j";
    }else{
        #print "\[ERROR\]: Price $j is not number. line $lc of $file\n";
        $PrevPrice{"$Disty"}{"$PN"} = "";
        $DiffPrice{"$Disty"}{"$PN"} = "";
        $DiffPriceFlag{"$Disty"}{"$PN"} = '';
    }
}

sub subUnitPrice{
    my ($i) = @_;
    $i =~ s/\\n//g;
    $i =~ s/Cut Tape  Cut Tape; //;
    $i =~ s/Cut Tape  Cut Tape //;
    $i =~ s/Reel  Reel; //;
    $i =~ s/Reel  Reel //;
    $i =~ s/1://;
    $i =~ s/[0-9]+:.*//;
    $i =~ s/\s//g;
    $i =~ s/\$//g;
    $i =~ s/[a-zA-Z]*//g;
    $i =~ s/;.*//;
    if ($i =~ /£/){ 
	$i =~ s/£//;
        $i = $i*$refCurrency{"$date2"};
        $i = $i*$refCurrencyH{'GBP'}{"$date2"};
        $i = sprintf("%.2f", $i);
        #print "\[LOG\]: refCurrency " . $refCurrency{"$date2"} . "\n";
        #$i = "$i" . " x " . $refCurrency{"$date2"} . " = " . $i*$refCurrency{"$date2"};
        #$i = "$i" . " x " . "$date2";
        return ("$i","1");
    }elsif ($i !~ /:/){
        return ("$i","1");
    }elsif ($i =~ /^1:/){
        #$i =~ s/;.*//;
        $i =~ s/1://;
        return ("$i","1");
    }else{
        #$i =~ s/;.*//;
        #return ("NA",substr($i,0,index($i, ":")));
        return (substr($i,index($i, ":")+1),substr($i,0,index($i, ":")));
    }
}
sub subLyticAntiV{
    $AntiV{$Disty}{$PN} = '';
    if($Supplier{$Disty}{$PN} eq 'Panasonic'){
        if($MPN{$Disty}{$PN} =~ /V$/){$AntiV{$Disty}{$PN} = 'AntiV';}
    }elsif($Supplier{$Disty}{$PN} eq 'Nichicon'){
        if($MPN{$Disty}{$PN} =~ /MCS/ || $MPN{$Disty}{$PN} =~ /MNS/ || $MPN{$Disty}{$PN} =~ /MRS/){$AntiV{$Disty}{$PN} = 'AntiV';}
    }elsif($Supplier{$Disty}{$PN} eq 'United Chemi-Con'){
        if(substr($MPN{$Disty}{$PN},7,1,) eq 'G'){$AntiV{$Disty}{$PN} = 'AntiV';}
    }elsif($Supplier{$Disty}{$PN} eq 'Rubycon'){
        if($MPN{$Disty}{$PN} =~ /VB/){$AntiV{$Disty}{$PN} = 'AntiV';}
    }elsif($Supplier{$Disty}{$PN} eq 'Cornell'){
        if($MPN{$Disty}{$PN} =~ /VT/){$AntiV{$Disty}{$PN} = 'AntiV';}
    }else{
    }
}
    

sub subOutspecDisty{
    my ($Disty,$Prod) = @_;

    #---------------------------
    # common header
    #---------------------------
    #print OFILE0 "StartDate,EndDate,EndUnitPrice,EndStock,SumOfTransaction,SumOfQuantity,Product,Disty,DistyPN,Supplier,MPN\n";
    print OFILE3 "StartDate,EndDate,EndUnitPrice,EndStock,SumOfTransaction,SumOfQuantity,MOQ,Product,Disty,DistyPN,Supplier,MPN,";

    #---------------------------
    # product header
    #---------------------------
    given("$Prod"){
        #01;
	when('Ta_Polymer'){
            print OFILE3 "ImageLink,Cap,Vol_V,Esr,OpTemp,Mounting,CaseCode,Height_mm,Reliabilitye\n";
        #02
	}when('Al_Polymer'){
            print OFILE3 "ImageLink,Cap,Vol_V,Esr,Ripple,Type,Life,OpTemp,Mounting,CaseCode,Height_mm,Package,Series\n";
        #03
	}when('Thermistor'){
            print OFILE3 "Res25_Ohm,ResTolerance_%,BValue,OpTemp,Mounting,CaseCode\n";
        #04
	}when('SMD_Lytic'){
            print OFILE3 "ImageLink,Description,Cap,Vol_V,Esr,Life,OpTemp,Ripple,Size,Height_mm,AntiV\n";
        #05
        }when ('TH_Lytic'){
            print OFILE3 "ImageLink,Description,Cap,Vol_V,Esr,Life,OpTemp,Ripple,Size,Height_mm\n";
        #06
        }when('Inductor'){
            print OFILE3 "Description,Series,Type,Core,Inductance_H,Tolerance,CurrentRating,CurrentSaturation,Shielding,DCR,Q,Frequency,AEC-Q200,OpTemp,TempMin,TempMax,FrequencyTest,Mounting,Size,HeightMax\n";
        #07
        }when('Tact_Switch'){
            print OFILE3 "ImageLink,PNLink,SPQ,Description,Outline,Actuator Height,Operating Force,Operating Force2,Termination Style,Mounting Type,Current Rating,Voltage Rating DC,Voltage Rating AC,Power Rating,Protection,Orientation,OpTemp,OpTempL,OpTempH\n";
        #08
        }when('PhotoMOS'){
            print OFILE3 "Description,Package,Current,Voltage\n";
        #10
        }when('SD_Card'){
            print OFILE3 "Description,MemorySize,Type1,Type2,OpTemp\n";
        #11
        }when('eMMC'){
            print OFILE3 "Description,MemoryFormat,MemorySize,Memory,Voltage,OpTemp,PackageCase\n";
        #12
        }when('BtoB'){
            print OFILE3 "Series,Description,Pitch,Mated,Position\n";
        #13
        }when('FPC'){
            print OFILE3 "Series,Description,Pitch,Contact,Position\n";
        #20
        }when('LCD'){
            print OFILE3 "Description,ScreenSize,Resolution\n";
        #21
        }when('Battery'){
            print OFILE3 "Description,Series,Chemistry,Cell,Voltage,Capacity,Size,Termination\n";
        #22
        }when('Si_GaN_SiCFET'){
            print OFILE3 "Description,Series,Tech,Vds,Current,Vgsth,Qg,Vgsmax,Ron,OpTemp,Mounting,Package,Status,Power\n";
        #22
        }when('IGBT_PENDING'){
            print OFILE3 "Description,Vce,Current,OpTemp,Mounting,Package,Vgemax,Power,Qg\n";
        #23
        }when('Thermal'){
            print OFILE3 "Description,Series,Usage,Type,Shape,Outline,Thickness,Material,Adhesive,BackingCarrier,Color,ThermalResistivity,ThermalConductivity,UnitPrice,StartDate\n";
        #24
        }when('SSD'){
            print OFILE3 "Description,MemorySize,Type1,Type2,OpTemp\n";
        #25
        }when('PMIC_Switch_Control_PENDING'){
            print OFILE3 "ImageLink,PNLink,Description,Series1,Series2,Function,Topology,OutputCount,PhaseCount,Vin,Swf,Synchronous,Control,OpTemp,Package\n";
        #25
        }when('PMIC_Switch_Regulator_PENDING'){
            print OFILE3 "ImageLink,PNLink,Description,Series1,Series2,Function,Topology,OutputCount,Vin,Vout,Iout,Swf,Synchronous,OpTemp,Package\n";
        #26
        }when('MLCC'){
            print OFILE3 "Description,Series,Cap,Tolerance,Vol_V,Temperature_Coefficient,OpTemp,Application,Mounting,Package,Size,Thickness\n";
        #27
        }when('DCDC_Converters_PENDING'){
            print OFILE3 "ImageLink,PNLink,Description,Series1,Series2,Type,OutputCount,Vin,Vout,Iout,Power,Application,OpTemp,Efficiency,Mounting,Package,Size\n";
        #28
        }when('EDLC'){
            print OFILE3 "MOQ,Series,Capacitance,Tolerance,Voltage,Esr,Life,Package,OpTemp,Size,LeadSpacing,Length,Width,Diameter2,Diameter,Type,Volume\n";
        #30
        }when('RF_Relay'){
            print OFILE3 "Description,Series,CoilType,CoilCurrent,CoilVoltage,ContactForm,ContactRating,SwitchingVoltage,TurnOnVoltage,TurnOffVoltage,OperateTime,ReleaseTime,Features,Mounting,Termination,OpTemp,Frequency,Power\n";
        #31
        }when ('Power_Relay'){
            print OFILE3 "ImageLink,PNLink,Description,Series,RelayType,CoilType,CoilCurrent,CoilVoltageAC,CoilVoltageDC,ContactForm,ContactRating,SwitchingVoltage,TurnOnVoltage,TurnOffVoltage,OperateTime,ReleaseTime,Features,Mounting,Termination,OpTempL,OpTempH,Length,Width,Height\n";
        #32
        }when ('Signal_Relay'){
            print OFILE3 "ImageLink,PNLink,Description,Series,RelayType,CoilType,CoilCurrent,CoilVoltageAC,CoilVoltageDC,ContactForm,ContactRating,SwitchingVoltage,TurnOnVoltage,TurnOffVoltage,OperateTime,ReleaseTime,Features,Mounting,Termination,OpTempL,OpTempH,Length,Width,Height\n";
        #34
        }when('Silicon_Capacitor'){
            print OFILE3 "Description\n";
        #35
        }when('LED'){
            print OFILE3 "Description,Series,Type,Color,CCT,Wavelength,Configuration,Flux,CurrentTest,Temperature,Voltage,Lumens,CurrentMax,CRI,ViewingAngle,Features,Size,Height,LES,LensType\n";
        #36
        }when('TTP'){
            print OFILE3 "Description,ScreenSize,Interface,Type\n";
        #37
        }when ('Film_Capacitor'){
            print OFILE3 "Description,Series,Capacitance,Tolerance,VAC,VDC,Dielectric,Esr,OpTemp,Mounting,PackageCase,Size,Height,Termination,LeadSpacing,Application\n";
        #39
        }when ('Encoder'){
            print OFILE3 "ImageLink,PNLink,Description,Series,EncodeType,OutputType,Pulses,Voltage,ActuatorType,Detent,BuiltInSwitch,Mounting,Orientation,Termination,RotationalLife\n";
        #40
        }when ('Potentiometer'){
            print OFILE3 "ImageLink,PNLink,Description,Package,Series,Resistance,Tolerance,Power,Adjustment,Temperature_Coefficient,Rotation,Material,Termination,ActuatorType,Length,Diameter,Bushing\n";
        #41
        }when ('Diode'){
            print OFILE3 "ImageLink,PNLink,Description,Series,Status,Type,Vr,Io,Vf,Speed,trr,ReverseLeakageCurrent,Capacitance,Mounting,PackageCase,Package,OpTemp\n";
        #42
        }when ('Isolator'){
            print OFILE3 "ImageLink,PNLink,Description,Series,Technology,Channels,VoltageIsolation,CMTI,PropagationDelay,Distortion,RiseFallTime,Current,CurrentPeak,Vf,If,Vout,OpTemp,Mounting,Package,SupplierPackage,Approvals\n";
        #43
        }when ('Coupler'){
            print OFILE3 "ImageLink,PNLink,Description,Series,Channels,Inputs,VoltageIsolation,CMTI,InputType,OutputType,Current,DataRate,PropagationDelay,RiseFallTime,Vf,If,Voltage,OpTemp,Mounting,PackageCase,Package\n";
        #44
        }when ('Varistor'){
            print OFILE3 "ImageLink,PNLink,Description,Series,VAC,VDC,Vmin,Vtyp,Vmax,CurrentSurge,Energy,NumberOfCircuits,Capacitance,OpTemp,Mounting,Package\n";
        #45
        }when ('CMNF'){
            print OFILE3 "ImageLink,PNLink,Description,Series,FilterType,Lines,CurrentRating,Resistance,VDC,VAC,OpTemp,Ratings,Approvals,Features,Mounting,Size,Height,PackageCase\n";
        #46
        }when ('Fuse'){
            print OFILE3 "ImageLink,PNLink,Description,Series,CurrentRating,VAC,VDC,ResponseTime,PackageCase,BreakingCapacity,Melting,Approvals,OpTemp,Size,Color\n";
        #47
        }when ('Temperature_Sensor'){
            print OFILE3 "ImageLink,PNLink,Description,Series,SensorType,TempLocal,TempRemote,OutputType,Voltage,Resolution,Features,Accuracy,TestCondition,OpTemp,Mounting,PackageCase,Package\n";
        #48
        }when ('Pressure_Sensor'){
            print OFILE3 "ImageLink,PNLink,Description,Series,PressureType,OperatingPressure,OutputType,Output,Accuracy,Voltage,PortSize,PortStyle,Features,Termination,MaximumPressure,OpTemp,PackageCase,Package\n";
        #49
        }when ('Resistor'){
            print OFILE3 "ImageLink,PNLink,Description,Series,Resistance,Tolerance,Power,Features,Temperature_Coefficient,OpTemp,PackageCase,Package,Size,Height,TerminationCount,FailureRate,Composition\n";
        #50
        }when ('LED_Drivers_Offboard'){
            print OFILE3 "ImageLink,PNLink,Description,Series,Topology,OutputCount,VinMin,VinMax,Vout,Iout,Power,VoltageIsolation,Dimming,Features,Ratings,OpTemp,Efficiency,Termination,Size\n";
        }
    }#given
    

    foreach $PN (@pnlist){
        #---------------------------
        # common spec
        #---------------------------
        if(defined $StartDate{$Disty}{$PN} && defined $date{$Disty}{$PN} && defined $UnitPrice{$Disty}{$PN} && defined $Stock{$Disty}{$PN} && defined $SumOfTransaction{$Disty}{$PN} && defined $SumOfQuantity{$Disty}{$PN} && defined $MOQ{$Disty}{$PN} && defined $Prod && defined $Disty && defined $PN && defined $Supplier{$Disty}{$PN} && defined $MPN{$Disty}{$PN}){
            print OFILE0 "$StartDate{$Disty}{$PN},$date{$Disty}{$PN},$UnitPrice{$Disty}{$PN},$Stock{$Disty}{$PN},$SumOfTransaction{$Disty}{$PN},$SumOfQuantity{$Disty}{$PN},$MOQ{$Disty}{$PN},$Prod,$Disty,$PN,$Supplier{$Disty}{$PN},$MPN{$Disty}{$PN}\n";
            print OFILE3 "$StartDate{$Disty}{$PN},$date{$Disty}{$PN},$UnitPrice{$Disty}{$PN},$Stock{$Disty}{$PN},$SumOfTransaction{$Disty}{$PN},$SumOfQuantity{$Disty}{$PN},$MOQ{$Disty}{$PN},$Prod,$Disty,$PN,$Supplier{$Disty}{$PN},$MPN{$Disty}{$PN},";
        }else{
            print "\[ERROR\]: Couldn't output outspec file for $PN due to undefined variables in common spec.\n";
	}

        #---------------------------
        # product spec
        #---------------------------
        given($Prod){
    	    when('Ta_Polymer'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$Capacitance{$Disty}{$PN},$Voltage{$Disty}{$PN},$Esr{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Mounting{$Disty}{$PN},$CaseCodeI{$Disty}{$PN},$Height{$Disty}{$PN},$Reliability{$Disty}{$PN}\n";
            #02
            }when('Al_Polymer'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$Capacitance{$Disty}{$PN},$Voltage{$Disty}{$PN},$Esr{$Disty}{$PN},$Ripple{$Disty}{$PN},$Type{$Disty}{$PN},$Life{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Mounting{$Disty}{$PN},$CaseCodeI{$Disty}{$PN},$Height{$Disty}{$PN},$Package{$Disty}{$PN},$Series{$Disty}{$PN}\n";
            #03
            }when('Thermistor'){
                print OFILE3 "$Res25{$Disty}{$PN},$ResTolerance{$Disty}{$PN},$BValue{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Mounting{$Disty}{$PN},$CaseCodeI{$Disty}{$PN}\n";
            #04
            }when('SMD_Lytic'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$Description{$Disty}{$PN},$Capacitance{$Disty}{$PN},$Voltage{$Disty}{$PN},$Esr{$Disty}{$PN},$Life{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Ripple{$Disty}{$PN},$Size{$Disty}{$PN},$Height{$Disty}{$PN},$AntiV{$Disty}{$PN}\n";
            #05
            }when('TH_Lytic'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$Description{$Disty}{$PN},$Capacitance{$Disty}{$PN},$Voltage{$Disty}{$PN},$Esr{$Disty}{$PN},$Life{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Ripple{$Disty}{$PN},$Size{$Disty}{$PN},$Height{$Disty}{$PN}\n";
            #06
            }when('Inductor'){
                print OFILE3 "$Description{$Disty}{$PN},$Series{$Disty}{$PN},$Type{$Disty}{$PN},$Core{$Disty}{$PN},$Inductance{$Disty}{$PN},$Tolerance{$Disty}{$PN},$CurrentRating{$Disty}{$PN},$CurrentSaturation{$Disty}{$PN},$Shielding{$Disty}{$PN},$DCR{$Disty}{$PN},$Q{$Disty}{$PN},$Frequency{$Disty}{$PN},$AECQ200{$Disty}{$PN},$OpTemp{$Disty}{$PN},$TempMin{$Disty}{$PN},$TempMax{$Disty}{$PN},$FrequencyTest{$Disty}{$PN},$Mounting{$Disty}{$PN},$Size{$Disty}{$PN},$HeightMax{$Disty}{$PN}\n";
            #07
            }when('Tact_Switch'){
                if(defined $ImageLink{$Disty}{$PN} && defined $PNLink{$Disty}{$PN} && defined $SPQ{$Disty}{$MPN{$Disty}{$PN}} && defined $Description{$Disty}{$PN} && defined $Size{$Disty}{$PN} && defined $Height{$Disty}{$PN} && defined $Opforce{$Disty}{$PN} && defined $Opforce2{$Disty}{$PN} && defined $Term{$Disty}{$PN} && defined $Mounting{$Disty}{$PN} && defined $CurrentRating{$Disty}{$PN} && defined $VoltageRatingDC{$Disty}{$PN} && defined $VoltageRatingAC{$Disty}{$PN} && defined $PowerRating{$Disty}{$PN} && defined $Protection{$Disty}{$PN} && defined $Orientation{$Disty}{$PN} && defined $OpTemp{$Disty}{$PN} && defined $OpTempL{$Disty}{$PN} && defined $OpTempH{$Disty}{$PN}){
                    print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$SPQ{$Disty}{$MPN{$Disty}{$PN}},$Description{$Disty}{$PN},$Size{$Disty}{$PN},$Height{$Disty}{$PN},$Opforce{$Disty}{$PN},$Opforce2{$Disty}{$PN},$Term{$Disty}{$PN},$Mounting{$Disty}{$PN},$CurrentRating{$Disty}{$PN},$VoltageRatingDC{$Disty}{$PN},$VoltageRatingAC{$Disty}{$PN},$PowerRating{$Disty}{$PN},$Protection{$Disty}{$PN},$Orientation{$Disty}{$PN},$OpTemp{$Disty}{$PN},$OpTempL{$Disty}{$PN},$OpTempH{$Disty}{$PN}\n";
                }else{
                    print "\[ERROR\]: Couldn't output outspec file for $PN due to undefined variables in product spec.\n";
	        }
            #08
            }when('PhotoMOS'){
                print OFILE3 "$Description{$Disty}{$PN},$Package{$Disty}{$PN},$Current{$Disty}{$PN},$Voltage{$Disty}{$PN}\n";
            #10
            }when('SD_Card'){
                if(defined $Description{$Disty}{$PN} && defined $MemorySize{$Disty}{$PN} && defined $Type1{$Disty}{$PN} && defined $Type2{$Disty}{$PN} && defined $OpTemp{$Disty}{$PN}){
                    print OFILE3 "$Description{$Disty}{$PN},$MemorySize{$Disty}{$PN},$Type1{$Disty}{$PN},$Type2{$Disty}{$PN},$OpTemp{$Disty}{$PN}\n";
                }else{
                    print "\[ERROR\]: Couldn't output outspec file for $PN due to undefined variables in product spec.\n";
	        }
            #11
            }when('eMMC'){
                print OFILE3 "$Description{$Disty}{$PN},$MemoryFormat{$Disty}{$PN},$MemorySize{$Disty}{$PN},$Memory{$Disty}{$PN},$Voltage{$Disty}{$PN},$OpTemp{$Disty}{$PN},$PackageCase{$Disty}{$PN}\n";
            #12
            }when('BtoB'){
                print OFILE3 "$Series{$Disty}{$PN},$Description{$Disty}{$PN},$Pitch{$Disty}{$PN},$Mated{$Disty}{$PN},$Position{$Disty}{$PN}\n";
            #13
            }when('FPC'){
                print OFILE3 "$Series{$Disty}{$PN},$Description{$Disty}{$PN},$Pitch{$Disty}{$PN},$Contact{$Disty}{$PN},$Position{$Disty}{$PN}\n";
            #20
            }when('LCD'){
                print OFILE3 "$Description{$Disty}{$PN},$ScreenSize{$Disty}{$PN},$Resolution{$Disty}{$PN}\n";
            #21
            }when('Battery'){
                print OFILE3 "$Description{$Disty}{$PN},$Series{$Disty}{$PN},$Chemistry{$Disty}{$PN},$Cell{$Disty}{$PN},$Voltage{$Disty}{$PN},$Capacity{$Disty}{$PN},$Size{$Disty}{$PN},$Term{$Disty}{$PN}\n";
            #22
            }when('Si_GaN_SiCFET'){
                print OFILE3 "$Description{$Disty}{$PN},$Series{$Disty}{$PN},$Tech{$Disty}{$PN},$Vds{$Disty}{$PN},$Current{$Disty}{$PN},$Vgsth{$Disty}{$PN},$Qg{$Disty}{$PN},$Vgsmax{$Disty}{$PN},$Ron{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Mounting{$Disty}{$PN},$Package{$Disty}{$PN},$Status{$Disty}{$PN},$Power{$Disty}{$PN}\n";
            #22
            }when('IGBT_PENDING'){
                print OFILE3 "$Description{$Disty}{$PN},$Vce{$Disty}{$PN},$Current{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Mounting{$Disty}{$PN},$Package{$Disty}{$PN},$Vgemax{$Disty}{$PN},$Power{$Disty}{$PN},$Qg{$Disty}{$PN}\n";
            #23
            }when('Thermal'){
                print OFILE3 "$Description{$Disty}{$PN},$Series{$Disty}{$PN},$Usage{$Disty}{$PN},$Type{$Disty}{$PN},$Shape{$Disty}{$PN},$Outline{$Disty}{$PN},$Thickness{$Disty}{$PN},$Material{$Disty}{$PN},$Adhesive{$Disty}{$PN},$BackingCarrier{$Disty}{$PN},$Color{$Disty}{$PN},$ThermalResistivity{$Disty}{$PN},$ThermalConductivity{$Disty}{$PN},$UnitPrice{$Disty}{$PN},$StartDate{$Disty}{$PN}\n";
            #24
            }when('SSD'){
                print OFILE3 "$Description{$Disty}{$PN},$MemorySize{$Disty}{$PN},$Type1{$Disty}{$PN},$Type2{$Disty}{$PN},$OpTemp{$Disty}{$PN}\n";
            #25
            }when('PMIC_Switch_Control_PENDING'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$Description{$Disty}{$PN},$Series1{$Disty}{$PN},$Series2{$Disty}{$PN},$Function{$Disty}{$PN},$Topology{$Disty}{$PN},$OutputCount{$Disty}{$PN},$PhaseCount{$Disty}{$PN},$Vin{$Disty}{$PN},$Swf{$Disty}{$PN},$Synchronous{$Disty}{$PN},$Control{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Package{$Disty}{$PN}\n";
            #25
            }when('PMIC_Switch_Regulator_PENDING'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$Description{$Disty}{$PN},$Series1{$Disty}{$PN},$Series2{$Disty}{$PN},$Function{$Disty}{$PN},$Topology{$Disty}{$PN},$OutputCount{$Disty}{$PN},$Vin{$Disty}{$PN},$Vout{$Disty}{$PN},$Iout{$Disty}{$PN},$Swf{$Disty}{$PN},$Synchronous{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Package{$Disty}{$PN}\n";
            #26
            }when('MLCC'){
                print OFILE3 "$Description{$Disty}{$PN},$Series{$Disty}{$PN},$Capacitance{$Disty}{$PN},$Tolerance{$Disty}{$PN},$Voltage{$Disty}{$PN},$Temperature_Coefficient{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Application{$Disty}{$PN},$Mounting{$Disty}{$PN},$Package{$Disty}{$PN},$Size{$Disty}{$PN},$Thickness{$Disty}{$PN}\n";
            #27
            }when('DCDC_Converters_PENDING'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$Description{$Disty}{$PN},$Series1{$Disty}{$PN},$Series2{$Disty}{$PN},$Type{$Disty}{$PN},$OutputCount{$Disty}{$PN},$Vin{$Disty}{$PN},$Vout{$Disty}{$PN},$Iout{$Disty}{$PN},$Power{$Disty}{$PN},$Application{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Efficiency{$Disty}{$PN},$Mounting{$Disty}{$PN},$Package{$Disty}{$PN},$Size{$Disty}{$PN}\n";
            #28
            }when('EDLC'){
                print OFILE3 "$MOQ{$Disty}{$PN},$Series{$Disty}{$PN},$Capacitance{$Disty}{$PN},$Tolerance{$Disty}{$PN},$Voltage{$Disty}{$PN},$Esr{$Disty}{$PN},$Life{$Disty}{$PN},$Package{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Size{$Disty}{$PN},$LeadSpacing{$Disty}{$PN},$Length{$Disty}{$PN},$Width{$Disty}{$PN},$Diameter2{$Disty}{$PN},$Diameter{$Disty}{$PN},$Type{$Disty}{$PN},$Volume{$Disty}{$PN}\n";
            #30
            }when('RF_Relay'){
                print OFILE3 "$Description{$Disty}{$PN},$Series{$Disty}{$PN},$CoilType{$Disty}{$PN},$CoilCurrent{$Disty}{$PN},$CoilVoltage{$Disty}{$PN},$ContactForm{$Disty}{$PN},$ContactRating{$Disty}{$PN},$SwitchingVoltage{$Disty}{$PN},$TurnOnVoltage{$Disty}{$PN},$TurnOffVoltage{$Disty}{$PN},$OperateTime{$Disty}{$PN},$ReleaseTime{$Disty}{$PN},$Features{$Disty}{$PN},$Mounting{$Disty}{$PN},$Term{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Frequency{$Disty}{$PN},$Power{$Disty}{$PN}\n";
            #31
            }when ('Power_Relay'){
                if(defined $ImageLink{$Disty}{$PN} && defined $PNLink{$Disty}{$PN} && defined $Description{$Disty}{$PN} && defined $Series{$Disty}{$PN} && defined $RelayType{$Disty}{$PN} && defined $CoilType{$Disty}{$PN} && defined $CoilCurrent{$Disty}{$PN} && defined $CoilVoltageAC{$Disty}{$PN} && defined $CoilVoltageDC{$Disty}{$PN} && defined $ContactForm{$Disty}{$PN} && defined $ContactRating{$Disty}{$PN} && defined $SwitchingVoltage{$Disty}{$PN} && defined $TurnOnVoltage{$Disty}{$PN} && defined $TurnOffVoltage{$Disty}{$PN} && defined $OperateTime{$Disty}{$PN} && defined $ReleaseTime{$Disty}{$PN} && defined $Features{$Disty}{$PN} && defined $Mounting{$Disty}{$PN} && defined $Termination{$Disty}{$PN} && defined $OpTempL{$Disty}{$PN} && defined $OpTempH{$Disty}{$PN} && defined $Length{$Disty}{$PN} && defined $Width{$Disty}{$PN} && defined $Height{$Disty}{$PN}){
                    print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$Description{$Disty}{$PN},$Series{$Disty}{$PN},$RelayType{$Disty}{$PN},$CoilType{$Disty}{$PN},$CoilCurrent{$Disty}{$PN},$CoilVoltageAC{$Disty}{$PN},$CoilVoltageDC{$Disty}{$PN},$ContactForm{$Disty}{$PN},$ContactRating{$Disty}{$PN},$SwitchingVoltage{$Disty}{$PN},$TurnOnVoltage{$Disty}{$PN},$TurnOffVoltage{$Disty}{$PN},$OperateTime{$Disty}{$PN},$ReleaseTime{$Disty}{$PN},$Features{$Disty}{$PN},$Mounting{$Disty}{$PN},$Termination{$Disty}{$PN},$OpTempL{$Disty}{$PN},$OpTempH{$Disty}{$PN},$Length{$Disty}{$PN},$Width{$Disty}{$PN},$Height{$Disty}{$PN}\n";
                }else{
                    print "\[ERROR\]: Couldn't output outspec file for $PN due to undefined variables in product spec.\n";
	        }
            #32
            }when ('Signal_Relay'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$Description{$Disty}{$PN},$Series{$Disty}{$PN},$RelayType{$Disty}{$PN},$CoilType{$Disty}{$PN},$CoilCurrent{$Disty}{$PN},$CoilVoltageAC{$Disty}{$PN},$CoilVoltageDC{$Disty}{$PN},$ContactForm{$Disty}{$PN},$ContactRating{$Disty}{$PN},$SwitchingVoltage{$Disty}{$PN},$TurnOnVoltage{$Disty}{$PN},$TurnOffVoltage{$Disty}{$PN},$OperateTime{$Disty}{$PN},$ReleaseTime{$Disty}{$PN},$Features{$Disty}{$PN},$Mounting{$Disty}{$PN},$Termination{$Disty}{$PN},$OpTempL{$Disty}{$PN},$OpTempH{$Disty}{$PN},$Length{$Disty}{$PN},$Width{$Disty}{$PN},$Height{$Disty}{$PN}\n";
            #34
            }when('Silicon_Capacitor'){
                print OFILE3 "$Description{$Disty}{$PN}\n";
            #35
            }when('LED'){
                print OFILE3 "$Description{$Disty}{$PN},$Series{$Disty}{$PN},$Type{$Disty}{$PN},$Color{$Disty}{$PN},$CCT{$Disty}{$PN},$Wavelength{$Disty}{$PN},$Configuration{$Disty}{$PN},$Flux{$Disty}{$PN},$CurrentTest{$Disty}{$PN},$Temperature{$Disty}{$PN},$Voltage{$Disty}{$PN},$Lumens{$Disty}{$PN},$CurrentMax{$Disty}{$PN},$CRI{$Disty}{$PN},$ViewingAngle{$Disty}{$PN},$Features{$Disty}{$PN},$Size{$Disty}{$PN},$Height{$Disty}{$PN},$LES{$Disty}{$PN},$LensType{$Disty}{$PN}\n";
            #36
            }when('TTP'){
                print OFILE3 "$Description{$Disty}{$PN},$ScreenSize{$Disty}{$PN},$Interface{$Disty}{$PN},$Type{$Disty}{$PN}\n";
            #37
            }when ('Film_Capacitor'){
                print OFILE3 "$Description{$Disty}{$PN},$Series{$Disty}{$PN},$Capacitance{$Disty}{$PN},$Tolerance{$Disty}{$PN},$VAC{$Disty}{$PN},$VDC{$Disty}{$PN},$Dielectric{$Disty}{$PN},$Esr{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Mounting{$Disty}{$PN},$PackageCase{$Disty}{$PN},$Size{$Disty}{$PN},$Height{$Disty}{$PN},$Termination{$Disty}{$PN},$LeadSpacing{$Disty}{$PN},$Application{$Disty}{$PN}\n";
            #39
            }when ('Encoder'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$Description{$Disty}{$PN},$Series{$Disty}{$PN},$EncodeType{$Disty}{$PN},$OutputType{$Disty}{$PN},$Pulses{$Disty}{$PN},$Voltage{$Disty}{$PN},$ActuatorType{$Disty}{$PN},$Detent{$Disty}{$PN},$BuiltInSwitch{$Disty}{$PN},$Mounting{$Disty}{$PN},$Orientation{$Disty}{$PN},$Termination{$Disty}{$PN},$RotationalLife{$Disty}{$PN}\n";
            #40
            }when ('Potentiometer'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$Description{$Disty}{$PN},$Package{$Disty}{$PN},$Series{$Disty}{$PN},$Resistance{$Disty}{$PN},$Tolerance{$Disty}{$PN},$Power{$Disty}{$PN},$Adjustment{$Disty}{$PN},$Temperature_Coefficient{$Disty}{$PN},$Rotation{$Disty}{$PN},$Material{$Disty}{$PN},$Termination{$Disty}{$PN},$ActuatorType{$Disty}{$PN},$Length{$Disty}{$PN},$Diameter{$Disty}{$PN},$Bushing{$Disty}{$PN}\n";
            #41
            }when ('Diode'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$Description{$Disty}{$PN},$Series{$Disty}{$PN},$Status{$Disty}{$PN},$Type{$Disty}{$PN},$Vr{$Disty}{$PN},$Io{$Disty}{$PN},$Vf{$Disty}{$PN},$Speed{$Disty}{$PN},$trr{$Disty}{$PN},$ReverseLeakageCurrent{$Disty}{$PN},$Capacitance{$Disty}{$PN},$Mounting{$Disty}{$PN},$PackageCase{$Disty}{$PN},$Package{$Disty}{$PN},$OpTemp{$Disty}{$PN}\n";
            #42
            }when ('Isolator'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$Description{$Disty}{$PN},$Series{$Disty}{$PN},$Technology{$Disty}{$PN},$Channels{$Disty}{$PN},$VoltageIsolation{$Disty}{$PN},$CMTI{$Disty}{$PN},$PropagationDelay{$Disty}{$PN},$Distortion{$Disty}{$PN},$RiseFallTime{$Disty}{$PN},$Current{$Disty}{$PN},$CurrentPeak{$Disty}{$PN},$Vf{$Disty}{$PN},$If{$Disty}{$PN},$Vout{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Mounting{$Disty}{$PN},$Package{$Disty}{$PN},$SupplierPackage{$Disty}{$PN},$Approvals{$Disty}{$PN}\n";
            #43
            }when ('Coupler'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$Description{$Disty}{$PN},$Series{$Disty}{$PN},$Channels{$Disty}{$PN},$Inputs{$Disty}{$PN},$VoltageIsolation{$Disty}{$PN},$CMTI{$Disty}{$PN},$InputType{$Disty}{$PN},$OutputType{$Disty}{$PN},$Current{$Disty}{$PN},$DataRate{$Disty}{$PN},$PropagationDelay{$Disty}{$PN},$RiseFallTime{$Disty}{$PN},$Vf{$Disty}{$PN},$If{$Disty}{$PN},$Voltage{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Mounting{$Disty}{$PN},$PackageCase{$Disty}{$PN},$Package{$Disty}{$PN}\n";
            #44
            }when ('Varistor'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$Description{$Disty}{$PN},$Series{$Disty}{$PN},$VAC{$Disty}{$PN},$VDC{$Disty}{$PN},$Vmin{$Disty}{$PN},$Vtyp{$Disty}{$PN},$Vmax{$Disty}{$PN},$CurrentSurge{$Disty}{$PN},$Energy{$Disty}{$PN},$NumberOfCircuits{$Disty}{$PN},$Capacitance{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Mounting{$Disty}{$PN},$Package{$Disty}{$PN}\n";
            #45
            }when ('CMNF'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$Description{$Disty}{$PN},$Series{$Disty}{$PN},$FilterType{$Disty}{$PN},$Lines{$Disty}{$PN},$CurrentRating{$Disty}{$PN},$Resistance{$Disty}{$PN},$VDC{$Disty}{$PN},$VAC{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Ratings{$Disty}{$PN},$Approvals{$Disty}{$PN},$Features{$Disty}{$PN},$Mounting{$Disty}{$PN},$Size{$Disty}{$PN},$Height{$Disty}{$PN},$PackageCase{$Disty}{$PN}\n";
            #46
            }when ('Fuse'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$Description{$Disty}{$PN},$Series{$Disty}{$PN},$CurrentRating{$Disty}{$PN},$VAC{$Disty}{$PN},$VDC{$Disty}{$PN},$ResponseTime{$Disty}{$PN},$PackageCase{$Disty}{$PN},$BreakingCapacity{$Disty}{$PN},$Melting{$Disty}{$PN},$Approvals{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Size{$Disty}{$PN},$Color{$Disty}{$PN}\n";
            #47
            }when ('Temperature_Sensor'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$Description{$Disty}{$PN},$Series{$Disty}{$PN},$SensorType{$Disty}{$PN},$TempLocal{$Disty}{$PN},$TempRemote{$Disty}{$PN},$OutputType{$Disty}{$PN},$Voltage{$Disty}{$PN},$Resolution{$Disty}{$PN},$Features{$Disty}{$PN},$Accuracy{$Disty}{$PN},$TestCondition{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Mounting{$Disty}{$PN},$PackageCase{$Disty}{$PN},$Package{$Disty}{$PN}\n";
            #48
            }when ('Pressure_Sensor'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$Description{$Disty}{$PN},$Series{$Disty}{$PN},$PressureType{$Disty}{$PN},$OperatingPressure{$Disty}{$PN},$OutputType{$Disty}{$PN},$Output{$Disty}{$PN},$Accuracy{$Disty}{$PN},$Voltage{$Disty}{$PN},$PortSize{$Disty}{$PN},$PortStyle{$Disty}{$PN},$Features{$Disty}{$PN},$Termination{$Disty}{$PN},$MaximumPressure{$Disty}{$PN},$OpTemp{$Disty}{$PN},$PackageCase{$Disty}{$PN},$Package{$Disty}{$PN}\n";
            #49
            }when ('Resistor'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$Description{$Disty}{$PN},$Series{$Disty}{$PN},$Resistance{$Disty}{$PN},$Tolerance{$Disty}{$PN},$Power{$Disty}{$PN},$Features{$Disty}{$PN},$Temperature_Coefficient{$Disty}{$PN},$OpTemp{$Disty}{$PN},$PackageCase{$Disty}{$PN},$Package{$Disty}{$PN},$Size{$Disty}{$PN},$Height{$Disty}{$PN},$TerminationCount{$Disty}{$PN},$FailureRate{$Disty}{$PN},$Composition{$Disty}{$PN}\n";
            #50
            }when ('LED_Drivers_Offboard'){
                print OFILE3 "$ImageLink{$Disty}{$PN},$PNLink{$Disty}{$PN},$Description{$Disty}{$PN},$Series{$Disty}{$PN},$Topology{$Disty}{$PN},$OutputCount{$Disty}{$PN},$VinMin{$Disty}{$PN},$VinMax{$Disty}{$PN},$Vout{$Disty}{$PN},$Iout{$Disty}{$PN},$Power{$Disty}{$PN},$VoltageIsolation{$Disty}{$PN},$Dimming{$Disty}{$PN},$Features{$Disty}{$PN},$Ratings{$Disty}{$PN},$OpTemp{$Disty}{$PN},$Efficiency{$Disty}{$PN},$Termination{$Disty}{$PN},$Size{$Disty}{$PN}\n";
            }
        }#given
    }#foreach
}


#===========
# [1] Lib file
#===========
#open(IFILE, "< ./lib/table_supplier.csv") or die("error :$!" );
open(IFILE, "< $libdir/table_supplier.csv") or die("error :$!" );
    $lc = "0";
    while (my $line = <IFILE>){
        $lc++;
        $line =~ s/\x0D?\x0A$//g;
        my @line = split(/"/,$line); for (my $i = 0; $i < @line; $i++){ if ($i % 2 != 0){ $line[$i] =~ s/,//g; } } $line = "@line";
	my @field = split(/,/,$line);
	if($lc eq '1'){next;}
        #print "$line\n";
        if(grep {$_ eq $field[0]} @supplier) {
            print "\[ERROR\]: Found duplicated $field[0] in line $lc\n";
	}else{
	    push(@supplier,$field[0]);
            $supplier{"$field[0]"} = "$field[1]";
        }
    }
    #foreach my $key(keys(%supplier)){
    #    print "$supplier{$key}\n";
    #}
close(IFILE);

#open(IFILE, "< ./lib/casecode.csv") or die("error :$!" );
open(IFILE, "< $libdir/casecode.csv") or die("error :$!" );
    $lc = "0";
    while (my $line = <IFILE>){
        $lc++;
        $line =~ s/\x0D?\x0A$//g;
        my @line = split(/"/,$line); for (my $i = 0; $i < @line; $i++){ if ($i % 2 != 0){ $line[$i] =~ s/,//g; } } $line = "@line";
	my @field = split(/,/,$line);
	if($lc eq '1'){next;}
        #print "$line\n";
        if(grep {$_ eq $field[0]} @casecode) {
            print "\[ERROR\]: Found duplicated $field[0] in line $lc\n";
	}else{
	    push(@casecode,$field[0]);
            $casecode{"$field[0]"} = "$field[1]";
        }
    }
close(IFILE);

#open(IFILE, "< ./lib/refMounting.csv") or die("error :$!" );
open(IFILE, "< $libdir/refMounting.csv") or die("error :$!" );
    $lc = "0";
    while (my $line = <IFILE>){
        $lc++;
        $line =~ s/\x0D?\x0A$//g;
        my @line = split(/"/,$line); for (my $i = 0; $i < @line; $i++){ if ($i % 2 != 0){ $line[$i] =~ s/,//g; } } $line = "@line";
	my @field = split(/,/,$line);
	if($lc eq '1'){next;}
        #print "$line\n";
        if(grep {$_ eq $field[0]} @refMounting) {
            print "\[ERROR\]: Found duplicated $field[0] in line $lc\n";
	}else{
	    push(@refMounting,$field[0]);
            $refMounting{"$field[0]"} = "$field[1]";
        }
    }
close(IFILE);

#open(IFILE, "< ./lib/refTerm.csv") or die("error :$!" );
open(IFILE, "< $libdir/refTerm.csv") or die("error :$!" );
    $lc = "0";
    while (my $line = <IFILE>){
        $lc++;
        $line =~ s/\x0D?\x0A$//g;
        my @line = split(/"/,$line); for (my $i = 0; $i < @line; $i++){ if ($i % 2 != 0){ $line[$i] =~ s/,//g; } } $line = "@line";
	my @field = split(/,/,$line);
	if($lc eq '1'){next;}
        #print "$line\n";
        if(grep {$_ eq $field[0]} @refTerm) {
            print "\[ERROR\]: Found duplicated $field[0] in line $lc\n";
	}else{
	    push(@refTerm,$field[0]);
            $refTerm{"$field[0]"} = "$field[1]";
        }
    }
close(IFILE);

open(IFILE, "< $libdir/xe.csv") or die("error :$!" );
    $lc = "0";
    while (my $line = <IFILE>){
        $lc++;
        $line =~ s/\x0D?\x0A$//g;
        my @line = split(/"/,$line); for (my $i = 0; $i < @line; $i++){ if ($i % 2 != 0){ $line[$i] =~ s/,//g; } } $line = "@line";
        $line =~ s/\t//g; $line =~ s/\s//g;
	my @field = split(/,/,$line);
	if($lc eq '1'){next;}
        #print "$line\n";
	my @subfield = split(/=/,$field[0]);
	$subfield[2] =~ s/-//g;
        if($field[1] eq 'GBP'){
	    $refCurrency{"$subfield[2]"} = "$field[5]";
            #print "\[LOG\]: Date " . "$subfield[2]" . " Currency " . "$field[1]" . " Ratio " . $refCurrency{"$subfield[2]"} . "\n";
        }
        if($field[1] eq 'GBP' || $field[1] eq 'EUR'){
	    $refCurrencyH{"$field[1]"}{"$subfield[2]"} = "$field[5]";
            print "\[LOG\]: Date " . "$subfield[2]" . " Currency " . "$field[1]" . " Ratio " . $refCurrencyH{"$field[1]"}{"$subfield[2]"} . "\n";
        }
        #$refCurrency{"$subfield[2]"}{"$field[1]"} = "$field[5]";
        #print "\[LOG\]: Date " . "$subfield[2]" . " Currency " . "$field[1]" . " Ratio " . $refCurrency{"$subfield[2]"}{"$field[1]"} . "\n";
    }
close(IFILE);

#open(IFILE, "< ./lib/SD.csv") or die("error :$!" );
#    $lc = "0";
#    @sdpnlist = ();
#    while (my $line = <IFILE>){
#        $lc++;
#        $line =~ s/\x0D?\x0A$//g;
#        my @line = split(/"/,$line); for (my $i = 0; $i < @line; $i++){ if ($i % 2 != 0){ $line[$i] =~ s/,//g; } } $line = "@line";
#	my @field = split(/,/,$line);
#	if($lc eq '1'){next;}
#        #print "$line\n";
#        if(grep {$_ eq $field[0]} @sdpnlist) {
#            print "\[ERROR\]: Found duplicated $field[0] in line $lc of ./bin/SD.csv\n";
#	}else{
#	    $PN = "$field[0]";
#	    push(@sdpnlist,$field[0]);
#        }
#        if(defined $field[2]){ $MemorySize{$PN} = "$field[2]";}else{$MemorySize{$PN} = '';}
#        if(defined $field[3]){ $OpTemp{$PN} = "$field[3]"; }else{$OpTemp{$PN} = ''; }
#        if(defined $field[4]){ $Type1{$PN} = "$field[4]";}else{$Type1{$PN} = '';}
#        if(defined $field[5]){ $Type2{$PN} = "$field[5]";}else{$Type2{$PN} = '';}
#        #print "$PN $MemorySize{$PN} $OpTemp{$PN} $Type1{$PN} $Type2{$PN}\n"; 
#
#    }
#close(IFILE);


#============================
# Make file header of OFILE0
#============================
$ofile0 = "outdistyweb.csv";
open(OFILE0, ">> $ofile0") or die("error :$!" );
print OFILE0 "StartDate,EndDate,EndUnitPrice,EndStock,SumOfTransaction,SumOfQuantity,MOQ,Product,Disty,DistyPN,Supplier,MPN\n";

#============================
# Make file header of OFILE4
#============================
$ofile4 = "outLineCount.csv";
open(OFILE4, ">> $ofile4") or die("error :$!" );
print OFILE4 "Extractor,Date,LineCount\n";

#===========
# [1] Input file
#===========

foreach $file (@filelist){
    if($file !~ /.csv/){next;};
    if($file =~ /^out/){next;};

    #=====
    # Delete return code of windows file system
    #=====
    $file =~ s/\x0D?\x0A$//g;

    #print "file: $file\n";
    $f = $file;
    $f =~ s/.csv.gz//g;
    $f =~ s/.csv//g;

    #my @afile = split(/_/,$f);
    my @afile = split(/-/,$f);


    #===========
    # When file header(disty and product) is changed,
    #===========



    if($Disty ne $afile[1] || $Prod ne $afile[2]){
        #=====
        # Output previous $Disty-$Prod data into outspec_*.csv
        #=====
        if($Disty ne '' && $Prod ne ''){ &subOutspecDisty("$Disty","$Prod"); }

        #=====
        # Initialize $fc, @pnlist, $skipfile
        #=====
        $fc = 1; @pnlist = (); $skipfile = 'n';

        #=====
        # Define $Disty, $Prod
        #=====
        $f0 = "$afile[0]" . "-" . "$afile[1]" . "-" . "$afile[2]";
        $f1 = "$afile[1]" . "-" . "$afile[2]";
        $Disty = "$afile[1]";
        $Prod = "$afile[2]";
        #$ofile = "out_" . "$f1" . ".csv";
        $ofile2 = "outstock_" . "$f1" . ".csv";
        $ofile3 = "outspec2_" . "$f1" . ".csv";

        print "\[LOG\]: Start " . "$afile[0]" . "-" . "$afile[1]" . "-" . "$afile[2] " . `date "+%Y%m%d-%H%M%S"`;
        print "\[LOG\]: Reading " . "$file " . `date "+%Y%m%d-%H%M%S"`;
    }else{
        if($skipfile eq 'y'){next;}
        $fc++;
        print "\[LOG\]: Reading " . "$file " . `date "+%Y%m%d-%H%M%S"`;
    }


    #open(OFILE1, ">> $ofile") or die("error :$!" );
    open(OFILE2, ">> $ofile2") or die("error :$!" );
    open(OFILE3, ">> $ofile3") or die("error :$!" );

    #===========
    # Format date
    #    $date = 04/01/2017  # MM/DD/YYYY
    #    $date2 = 20170401    # YYYYMMDD
    #===========
    @adate = ($afile[8],substr($afile[9],0,2),$afile[7]);
    #$date = "$adate[0]" . "/" . "$adate[1]" . "/" . "$adate[2]\n";
    #$date2 = "$adate[2]" . "$adate[0]" . "$adate[1]\n";
    #$date =~ s/\x0D?\x0A$//g;
    $date = "$adate[0]" . "/" . "$adate[1]" . "/" . "$adate[2]";
    $date2 = "$adate[2]" . "$adate[0]" . "$adate[1]";

    #===========
    # Open zipped csv file or normal csv file
    #===========
    if($file =~ /.csv.gz/){
        #=====
        # Discard stderr (2>/dev/null)
        #=====
        open(IFILE1, "zcat \'$fdir/$file\' 2>/dev/null |") or die("error :$!" );
    }elsif($file =~ /.csv/){
        open(IFILE1, "< $fdir/$file") or die("error :$!" );
    }

    #line count default
    $lc = "0";

    #pnlist per daily
    @pnlist_daily = ();

    #===========
    # [2] line level
    #===========
    while (my $line = <IFILE1>){

        #=====
        #[2-1]Trimming
        #=====

        #=====
        #Return code of Unix is LF but that of Windows is CRLF
	#In case of Windows file system, use below script instead of chomp()
        #=====
        $line =~ s/\x0D?\x0A$//g;

        #=====
        #Delete special Meta-charactor 
        #=====
	$line =~ s/Â//g;


        #=====
        #Append line which is splited return code between " "
        #=====
        $preline = "$preline" . "$line";
        $count++ while($line =~ m/\"/g);
	#print "$line\n";
	#print "$count\n";
        if ($count % 2 != 0){
	    next;
	}else{
            $line = "$preline";
            $preline = '';
            $count = "0";
	}
	#print "LINE: $line\n";
	#print "LINE: $count\n";

        #=====
        #line count
        #=====
        $lc++;
	#print "LINE COUNT:$lc\n";


        #=====
        #Delete comma within "". "1,200" -> 1200. A file alignment collapse by the comma
        #=====
        my @line = split(/"/,$line);
        for (my $i = 0; $i < @line; $i++){
	    if ($i % 2 != 0){
                $line[$i] =~ s/,//g;
	    }
	}
        $line = "@line";
        $line =~ s/\s,/,/g;
        $line =~ s/,\s/,/g;

        #=====
        #Delete "MultiSIM BLUE field" in case Mouser
        #=====
	if ($Disty eq 'MS'){
            if($Prod eq 'Thermistor' && $date2 > '20170403'){
            }elsif($Prod eq 'PhotoMOS'){
            }elsif($Prod eq 'TH_Lytic'){
            }else{
	        $line =~ s/,Available in MultiSIM BLUE,/,/;
	        $line =~ s/Available in MultiSIM BLUE//;
            }
        }

        #=====
        #Split field by ","
        #=====
	my @field = split(/,/,$line);
	

        #=====
        #[2-2]Print header
        #=====
	if($lc eq '1'){
	    if($fc eq '1'){
		print OFILE2 "Date,Disty,ProductGr,PN,Stock,DiffStock,Quantity,Transaction,UnitPrice,PrevPrice,DiffPrice,MOQ,MPN,Supplier\n";
            }
            next;
        }

        #=====
        #[2-3]Identify Product
        #=====
        given($Prod){
        #01
        when('Ta_Polymer'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[15]") eq "1"){next;}

                if(defined $field[7] && $field[7] ne ''){ &subPN("$field[7]" ,$file);
		}else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[9]){ $MPN{$Disty}{$PN} = "$field[9]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[15]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[15]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[14]){ &subStock("$field[14]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[11]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[11]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[16]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[16]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[4]){ if($field[4] =~/NoPhoto/ || $field[4] eq ''){$field[4] = 'NoPhoto';}else{$field[4] = 'Photo';}$ImageLink{$Disty}{$PN} = "$field[4]";}else{$ImageLink{$Disty}{$PN} = 'NoPhoto';}
                if(defined $field[13]){ $Description{$Disty}{$PN} = "$field[13]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[20]){ $Series{$Disty}{$PN} = "$field[20]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[23]){ $Capacitance{$Disty}{$PN} = &subCap("$field[23]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[25]){ $Voltage{$Disty}{$PN} = &subVol("$field[25]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                if(defined $field[27]){ $Esr{$Disty}{$PN} = &subRes("$field[27]", $file); }else{$Esr{$Disty}{$PN} = ''; }
                if(defined $field[28]){ $OpTemp{$Disty}{$PN} = &subOptemp("$field[28]", $file); }else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[30]){ $Mounting{$Disty}{$PN} = "$field[30]";}else{ $Mounting{$Disty}{$PN} = '';}
                if(defined $field[31]){ $CaseCodeI{$Disty}{$PN} = &subCasecode("$field[31]", $file);}else{ $CaseCodeI{$Disty}{$PN} = '';}
                if(defined $field[33]){ $Height{$Disty}{$PN} = "$field[33]";}else{$Height{$Disty}{$PN} = '';}
                if(defined $field[35]){ $Reliability{$Disty}{$PN} = "$field[35]";}else{$Reliability{$Disty}{$PN} = '';}
    
            }elsif($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[8]){ $field[8] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[8]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[16]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[16]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[15]){ &subStock("$field[15]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[10]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[10]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[1]){ if($field[1] =~/NoPhoto/ || $field[1] eq ''){$field[1] = 'NoPhoto';}else{$field[1] = 'Photo';}$ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = 'NoPhoto';}
                if(defined $field[12]){ $Description{$Disty}{$PN} = "$field[12]";}else{ $Description{$Disty}{$PN} = '';}
                if(defined $field[39]){ $Series{$Disty}{$PN} = "$field[39]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[33]){ $Capacitance{$Disty}{$PN} = &subCap("$field[33]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[34]){ $Voltage{$Disty}{$PN} = &subVol("$field[34]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                if(defined $field[35]){ $Esr{$Disty}{$PN} = &subRes("$field[35]", $file); }else{$Esr{$Disty}{$PN} = ''; }
                if(defined $field[40]){ $OpTemp{$Disty}{$PN} = &subOptemp("$field[40]", $file); }else{$OpTemp{$Disty}{$PN} = ''; }
                $Mounting{$Disty}{$PN} = "Surface Mount";
                if(defined $field[36]){ $CaseCodeI{$Disty}{$PN} = &subCasecode("$field[36]", $file); }else{$CaseCodeI{$Disty}{$PN} = '';}
                if(defined $field[38]){ $Height{$Disty}{$PN} = &subLen("$field[38]", $file); }else{$Height{$Disty}{$PN} = ''; }
                $Reliability{$Disty}{$PN} = "";

	      }else{
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[4]){ $field[4] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[4]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[7]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[7]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[1]){ if($field[1] =~/NoPhoto/ || $field[1] eq ''){$field[1] = 'NoPhoto';}else{$field[1] = 'Photo';}$ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = 'NoPhoto';}
                if(defined $field[9]){ $Description{$Disty}{$PN} = "$field[9]";}else{ $Description{$Disty}{$PN} = '';}
                if(defined $field[17]){ $Series{$Disty}{$PN} = "$field[17]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[18]){ $Capacitance{$Disty}{$PN} = &subCap("$field[18]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[19]){ $Voltage{$Disty}{$PN} = &subVol("$field[19]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                if(defined $field[21]){ $Esr{$Disty}{$PN} = &subRes("$field[21]", $file); }else{$Esr{$Disty}{$PN} = ''; }
                if(defined $field[26] && defined $field[27]){ $OpTemp{$Disty}{$PN} = "$field[26]" . " to " . "$field[27]"; }else{$OpTemp{$Disty}{$PN} = ''; }
                $Mounting{$Disty}{$PN} = "Surface Mount";
                if(defined $field[22]){ $CaseCodeI{$Disty}{$PN} = &subCasecode("$field[22]", $file); }else{$CaseCodeI{$Disty}{$PN} = '';}
                if(defined $field[24]){ $Height{$Disty}{$PN} = &subLen("$field[24]", $file); }else{$Height{$Disty}{$PN} = ''; }
                $Reliability{$Disty}{$PN} = "";
	      }
    
            }elsif($Disty eq 'AR'){
                if ($field[8] ne '1+' && $field[8] ne 'Per Unit'){next;}
    
                $PN = "$field[1]";
                if(defined $field[9]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[9]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[20]){ &subStock("$field[20]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                $Supplier{$Disty}{$PN} = &subSupplier("$field[23]", $file);

                $Description{$Disty}{$PN} = "$field[25]";
                $Series{$Disty}{$PN} = "";
        	if($field[26] eq ''){
                    $Capacitance{$Disty}{$PN} = "$field[26]";
    	        }elsif($field[26] =~/uF/){
                    $field[26] =~ s/uF//g; $Capacitance{$Disty}{$PN} = "$field[26]";
    	        }else{
                    $Capacitance{$Disty}{$PN} = "$field[26]" . " " . "UnrecognizedUnit";
                }
    	        if($field[27] eq ''){
                    $Voltage{$Disty}{$PN} = "$field[27]";
    	        }elsif($field[27] =~/VDC/){
                    $field[27] =~ s/VDC//g; $Voltage{$Disty}{$PN} = "$field[27]";
    	        }else{
                    $Voltage{$Disty}{$PN} = "$field[27]" . " " . "UnrecognizedUnit";
                }
    
                $Esr{$Disty}{$PN} = "$field[28]";
                $OpTemp{$Disty}{$PN} = "$field[32]";
                $Mounting{$Disty}{$PN} = "";
                if(defined $field[30]){ $CaseCodeI{$Disty}{$PN} = &subCasecode("$field[30]", $file); }
                $Height{$Disty}{$PN} = "";
                $Reliability{$Disty}{$PN} = "$field[33]";
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }
        #02
        }when('Al_Polymer'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[12]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[13]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[13]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[3]){ if($field[3] =~/NoPhoto/ || $field[3] eq ''){$field[3] = 'NoPhoto';}else{$field[3] = 'Photo';}$ImageLink{$Disty}{$PN} = "$field[3]";}else{$ImageLink{$Disty}{$PN} = 'NoPhoto';}
                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[17]){ $Series{$Disty}{$PN} = "$field[17]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[19]){ $Type{$Disty}{$PN} = "$field[19]";}else{$Type{$Disty}{$PN} = '';}
                if(defined $field[20]){ $Capacitance{$Disty}{$PN} = &subCap("$field[20]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[21]){ $Voltage{$Disty}{$PN} = &subVol("$field[21]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                if(defined $field[22]){ $Esr{$Disty}{$PN} = &subRes("$field[22]", $file); }else{$Esr{$Disty}{$PN} = ''; }
                if(defined $field[23]){ $Life{$Disty}{$PN} = "$field[23]"; }else{$Life{$Disty}{$PN} = ''; }
                if(defined $field[24]){ $OpTemp{$Disty}{$PN} = &subOptemp("$field[24]", $file); }else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[27]){ $field[27] =~ s/\s.*$//; $Ripple{$Disty}{$PN} = &subCur("$field[27]", $file);}else{$Ripple{$Disty}{$PN} = '';}
                if(defined $field[32]){ $Mounting{$Disty}{$PN} = "$field[32]";}else{ $Mounting{$Disty}{$PN} = '';}
                if(defined $field[33]){ $Package{$Disty}{$PN} = "$field[33]";}else{ $Package{$Disty}{$PN} = '';}
                if(defined $field[29]){ $CaseCodeI{$Disty}{$PN} = &subCasecode("$field[29]", $file);}else{ $CaseCodeI{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Height{$Disty}{$PN} = "$field[30]";}else{$Height{$Disty}{$PN} = '';}
    
            }elsif($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[8]){ $field[8] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[8]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[20]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[20]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[17]){ &subStock("$field[17]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[10]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[10]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[1]){ if($field[1] =~/NoPhoto/ || $field[1] eq ''){$field[1] = 'NoPhoto';}else{$field[1] = 'Photo';}$ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = 'NoPhoto';}
                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{ $Description{$Disty}{$PN} = '';}
                if(defined $field[26]){$Series{$Disty}{$PN} = "$field[26]";}else{$Series{$Disty}{$PN} = '';}
                if($date2 <= '20180201'){
                    if(defined $field[28]){ $Capacitance{$Disty}{$PN} = &subCap("$field[28]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                }elsif($date2 > '20180201'){
                    if(defined $field[27]){ $Capacitance{$Disty}{$PN} = &subCap("$field[27]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                }
                if($date2 <= '20180201'){
                    if(defined $field[29]){ $Voltage{$Disty}{$PN} = &subVol("$field[29]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                }elsif($date2 > '20180201'){
                    if(defined $field[28]){ $Voltage{$Disty}{$PN} = &subVol("$field[28]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                }
                if($date2 <= '20180201'){
                    if(defined $field[30]){ $Esr{$Disty}{$PN} = &subRes("$field[30]", $file); }else{$Esr{$Disty}{$PN} = ''; }
                }elsif($date2 > '20180201'){
                    $Esr{$Disty}{$PN} = '';
                }
                $OpTemp{$Disty}{$PN} = '';
                $Type{$Disty}{$PN} = '';
                if($date2 <= '20180201'){
                    if(defined $field[34]){$Ripple{$Disty}{$PN} = "$field[34]";}else{$Ripple{$Disty}{$PN} = '';}
                }elsif($date2 > '20180201'){
                    $Ripple{$Disty}{$PN} = '';
                }
                if($date2 <= '20180201'){
                    if(defined $field[27]){$Mounting{$Disty}{$PN} = "$field[27]";}else{$Mounting{$Disty}{$PN} = '';}
                }elsif($date2 > '20180201'){
                    $Mounting{$Disty}{$PN} = '';
                }
                $CaseCodeI{$Disty}{$PN} = '';
                $Height{$Disty}{$PN} = '';
                $Package{$Disty}{$PN} = '';
                $Life{$Disty}{$PN} = '';
                $Reliability{$Disty}{$PN} = "";

	      }else{
   
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[4]){ $field[4] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[4]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[7]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[7]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[1]){ if($field[1] =~/NoPhoto/ || $field[1] eq ''){$field[1] = 'NoPhoto';}else{$field[1] = 'Photo';}$ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = 'NoPhoto';}
                if(defined $field[9]){ $Description{$Disty}{$PN} = "$field[9]";}else{ $Description{$Disty}{$PN} = '';}
                if(defined $field[31]){$Series{$Disty}{$PN} = "$field[31]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[18]){ $Capacitance{$Disty}{$PN} = &subCap("$field[18]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[19]){ $Voltage{$Disty}{$PN} = &subVol("$field[19]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                if(defined $field[21]){ $Esr{$Disty}{$PN} = &subRes("$field[21]", $file); }else{$Esr{$Disty}{$PN} = ''; }
                if(defined $field[22] && defined $field[23]){ $OpTemp{$Disty}{$PN} = "$field[22]" . " to " . "$field[23]"; }else{$OpTemp{$Disty}{$PN} = ''; }
                $Type{$Disty}{$PN} = '';
                if(defined $field[28]){$Ripple{$Disty}{$PN} = &subCur("$field[28]", $file);}else{$Ripple{$Disty}{$PN} = '';}
                if(defined $field[16]){$Mounting{$Disty}{$PN} = "$field[16]";}else{$Mounting{$Disty}{$PN} = '';}
                $CaseCodeI{$Disty}{$PN} = '';
                if(defined $field[27]){ $Height{$Disty}{$PN} = &subLen("$field[27]", $file); }else{$Height{$Disty}{$PN} = ''; }
                $Package{$Disty}{$PN} = '';
                if(defined $field[29]){$Life{$Disty}{$PN} = "$field[29]";}else{$Life{$Disty}{$PN} = '';}
                $Reliability{$Disty}{$PN} = "";
	      }

            }elsif($Disty eq 'AR'){
                if ($field[8] ne '1+' && $field[8] ne 'Per Unit'){next;}
    
                $PN = "$field[1]";
                if(defined $field[9]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[9]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[20]){ &subStock("$field[20]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                $Supplier{$Disty}{$PN} = &subSupplier("$field[23]", $file);

                $Description{$Disty}{$PN} = "$field[25]";
                $Series{$Disty}{$PN} = "";
        	if($field[26] eq ''){
                    $Capacitance{$Disty}{$PN} = "$field[26]";
    	        }elsif($field[26] =~/uF/){
                    $field[26] =~ s/uF//g; $Capacitance{$Disty}{$PN} = "$field[26]";
    	        }else{
                    $Capacitance{$Disty}{$PN} = "$field[26]" . " " . "UnrecognizedUnit";
                }
    
    	        if($field[27] eq ''){
                    $Voltage{$Disty}{$PN} = "$field[27]";
    	        }elsif($field[27] =~/VDC/){
                    $field[27] =~ s/VDC//g; $Voltage{$Disty}{$PN} = "$field[27]";
    	        }else{
                    $Voltage{$Disty}{$PN} = "$field[27]" . " " . "UnrecognizedUnit";
                }
    
                $Esr{$Disty}{$PN} = "$field[28]";
                $OpTemp{$Disty}{$PN} = "$field[32]";
                $Mounting{$Disty}{$PN} = "";
                if(defined $field[30]){ $CaseCodeI{$Disty}{$PN} = &subCasecode("$field[30]", $file); }
                $Height{$Disty}{$PN} = "";
                $Reliability{$Disty}{$PN} = "$field[33]";
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }
        #03
        }when('Thermistor'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[16]") eq "1"){next;}

                if(defined $field[8] && $field[8] ne ''){ &subPN("$field[8]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[10]){ $MPN{$Disty}{$PN} = "$field[10]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[16]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[16]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[15]){ &subStock("$field[15]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[17]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[17]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[21]){ $Series{$Disty}{$PN} = "$field[21]"; }else{$Series{$Disty}{$PN} = '';}
                if(defined $field[24]){
                    $field[24] =~ s/\s//g;
                    if($field[24] =~/[0-9]k/){
			$field[24] =~ s/k/E3/g;
                        $Res25{$Disty}{$PN} = "$field[24]";
                    }else{
                        $Res25{$Disty}{$PN} = "$field[24]";
                    }
                }else{
		    $Res25{$Disty}{$PN} = '';
		}
                if(defined $field[25]){ $ResTolerance{$Disty}{$PN} = "$field[25]"; }else{$ResTolerance{$Disty}{$PN} = '';}
                # field[27-31] B050, B2550, B2575, B2585, B25100,
                if(defined $field[27] && $field[27] =~ /K/){
		    $BValue{$Disty}{$PN} = $field[27];
		}elsif(defined $field[28] && $field[28] =~ /K/){
		    $BValue{$Disty}{$PN} = $field[28];
		}elsif(defined $field[29] && $field[29] =~ /K/){
		    $BValue{$Disty}{$PN} = $field[29];
		}elsif(defined $field[30] && $field[30] =~ /K/){
		    $BValue{$Disty}{$PN} = $field[30];
		}elsif(defined $field[31] && $field[31] =~ /K/){
		    $BValue{$Disty}{$PN} = $field[31];
		}else{
		    $BValue{$Disty}{$PN} = '';
		}
                if(defined $field[32]){ $OpTemp{$Disty}{$PN} = &subOptemp("$field[32]", $file); }else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[35]){ $Mounting{$Disty}{$PN} = "$field[35]";}else{$Mounting{$Disty}{$PN} = '';}
                if(defined $field[36]){ $CaseCodeI{$Disty}{$PN} = &subCasecode("$field[36]", $file); }else{$CaseCodeI{$Disty}{$PN} = '';}
    
            }elsif($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[8]){ $field[8] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[8]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[25]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[25]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[22]){ &subStock("$field[22]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[15]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[15]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[17]){ $Description{$Disty}{$PN} = "$field[17]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[33]){ $Series{$Disty}{$PN} = "$field[33]"; }else{$Series{$Disty}{$PN} = '';}
                if(defined $field[35]){ $Res25{$Disty}{$PN} = &subRes("$field[35]", $file); }else{$Res25{$Disty}{$PN} = ''; }
                if(defined $field[37]){ $ResTolerance{$Disty}{$PN} = "$field[37]"; }else{$ResTolerance{$Disty}{$PN} = '';}
                if(defined $field[34]){ $BValue{$Disty}{$PN} = "$field[34]"; }else{$BValue{$Disty}{$PN} = '';}
                if(defined $field[39] && defined $field[40]){ $OpTemp{$Disty}{$PN} = "$field[39]" . " to " . "$field[40]"; }else{$OpTemp{$Disty}{$PN} = ''; }
                $Mounting{$Disty}{$PN} = '';
                $CaseCodeI{$Disty}{$PN} = '';

	      }else{
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[4]){ $field[4] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[4]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[7]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[7]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[9]){ $Description{$Disty}{$PN} = "$field[9]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[17]){ $Series{$Disty}{$PN} = "$field[17]"; }else{$Series{$Disty}{$PN} = '';}
                if(defined $field[19]){ $Res25{$Disty}{$PN} = &subRes("$field[19]", $file); }else{$Res25{$Disty}{$PN} = ''; }
                if(defined $field[21]){ $ResTolerance{$Disty}{$PN} = "$field[21]"; }else{$ResTolerance{$Disty}{$PN} = '';}
                if(defined $field[18]){ $BValue{$Disty}{$PN} = "$field[18]"; }else{$BValue{$Disty}{$PN} = '';}
                if(defined $field[23] && defined $field[24]){ $OpTemp{$Disty}{$PN} = "$field[23]" . " to " . "$field[24]"; }else{$OpTemp{$Disty}{$PN} = ''; }
                $Mounting{$Disty}{$PN} = '';
                $CaseCodeI{$Disty}{$PN} = '';
	      }


            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }
        #04
        }when('SMD_Lytic'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[12]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[13]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[13]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[1]){ if($field[1] =~/NoPhoto/ || $field[1] eq ''){$field[1] = 'NoPhoto';}else{$field[1] = 'Photo';}$ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = 'NoPhoto';}
                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[19]){ $Capacitance{$Disty}{$PN} = &subCap("$field[19]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[20]){ $Voltage{$Disty}{$PN} = &subVol("$field[20]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                if(defined $field[21]){ $Esr{$Disty}{$PN} = &subRes("$field[21]", $file); }else{$Esr{$Disty}{$PN} = ''; }
                if(defined $field[22]){ $Life{$Disty}{$PN} = "$field[22]"; }else{$Life{$Disty}{$PN} = ''; }
                if(defined $field[23]){ $OpTemp{$Disty}{$PN} = &subOptemp("$field[23]", $file); }else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[26]){ $Ripple{$Disty}{$PN} = "$field[26]";}else{ $Ripple{$Disty}{$PN} = '';}
                if(defined $field[29]){ $Size{$Disty}{$PN} = "$field[29]";}else{$Size{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Height{$Disty}{$PN} = "$field[30]";}else{$Height{$Disty}{$PN} = '';}
                &subLyticAntiV;
    
            }elsif($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[8]){ $field[8] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[8]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[18]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[18]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[17]){ &subStock("$field[17]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[10]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[10]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[1]){ if($field[1] =~/NoPhoto/ || $field[1] eq ''){$field[1] = 'NoPhoto';}else{$field[1] = 'Photo';}$ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = 'NoPhoto';}
                if(defined $field[12]){ $Description{$Disty}{$PN} = "$field[12]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Capacitance{$Disty}{$PN} = &subCap("$field[27]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[28]){ $Voltage{$Disty}{$PN} = &subVol("$field[28]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                if(defined $field[29]){ $Esr{$Disty}{$PN} = &subRes("$field[29]", $file); }else{$Esr{$Disty}{$PN} = ''; }
                if(defined $field[33]){ $Life{$Disty}{$PN} = "$field[33]"; }else{$Life{$Disty}{$PN} = ''; }
                if(defined $field[30]){ $OpTemp{$Disty}{$PN} = &subOptemp("$field[30]", $file); }else{$OpTemp{$Disty}{$PN} = ''; }
                $Ripple{$Disty}{$PN} = "";
                $Size{$Disty}{$PN} = "";
                $Height{$Disty}{$PN} = "";
                &subLyticAntiV;

	      }else{
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[4]){ $field[4] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[4]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[7]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[7]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[1]){ if($field[1] =~/NoPhoto/ || $field[1] eq ''){$field[1] = 'NoPhoto';}else{$field[1] = 'Photo';}$ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = 'NoPhoto';}
                if(defined $field[8]){ $Description{$Disty}{$PN} = "$field[8]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[17]){ $Capacitance{$Disty}{$PN} = &subCap("$field[17]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[18]){ $Voltage{$Disty}{$PN} = &subVol("$field[18]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                if(defined $field[20]){ $Esr{$Disty}{$PN} = &subRes("$field[20]", $file); }else{$Esr{$Disty}{$PN} = ''; }
                if(defined $field[27]){ $Life{$Disty}{$PN} = "$field[27]"; }else{$Life{$Disty}{$PN} = ''; }
                if(defined $field[21] && defined $field[22]){ $OpTemp{$Disty}{$PN} = "$field[21]" . " to " . "$field[22]"; }else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[28]){ $Ripple{$Disty}{$PN} = &subCur("$field[28]", $file);}else{ $Ripple{$Disty}{$PN} = '';}
                $Size{$Disty}{$PN} = "";
                if(defined $field[26]){ $Height{$Disty}{$PN} = &subLen("$field[26]", $file); }else{$Height{$Disty}{$PN} = ''; }
                &subLyticAntiV;
              }	


            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            } 
        #05
        }when('TH_Lytic'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[16]") eq "1"){next;}

                if(defined $field[8] && $field[8] ne ''){ &subPN("$field[8]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[10]){ $MPN{$Disty}{$PN} = "$field[10]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[16]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[16]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[15]){ &subStock("$field[15]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[17]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[17]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[5]){ if($field[5] =~/NoPhoto/ || $field[5] eq ''){$field[5] = 'NoPhoto';}else{$field[5] = 'Photo';}$ImageLink{$Disty}{$PN} = "$field[5]";}else{$ImageLink{$Disty}{$PN} = 'NoPhoto';}
                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[23]){ $Capacitance{$Disty}{$PN} = &subCap("$field[23]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[24]){ $Voltage{$Disty}{$PN} = &subVol("$field[24]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                if(defined $field[25]){ $Esr{$Disty}{$PN} = &subRes("$field[25]", $file); }else{$Esr{$Disty}{$PN} = ''; }
                if(defined $field[26]){ $Life{$Disty}{$PN} = "$field[26]"; }else{$Life{$Disty}{$PN} = ''; }
                if(defined $field[27]){ $OpTemp{$Disty}{$PN} = &subOptemp("$field[27]", $file); }else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[29]){ $Ripple{$Disty}{$PN} = &subCur("$field[29]", $file);}else{ $Ripple{$Disty}{$PN} = '';}
                if(defined $field[33]){ $Size{$Disty}{$PN} = "$field[33]";}else{$Size{$Disty}{$PN} = '';}
                if(defined $field[34]){ $Height{$Disty}{$PN} = "$field[34]";}else{$Height{$Disty}{$PN} = '';}
    
            }elsif($Disty eq 'MS'){
              if($date2 <= '20171115'){
	        # 667-EEV-FK1H561M had been registered in TH_Lytic incorrectly till 20171115
                if(defined $field[5] && $field[5] eq '667-EEV-FK1H561M'){next;}

                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[7]){ $field[7] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[7]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[22]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[22]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[19]){ &subStock("$field[19]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[1]){ if($field[1] =~/NoPhoto/ || $field[1] eq ''){$field[1] = 'NoPhoto';}else{$field[1] = 'Photo';}$ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = 'NoPhoto';}
                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[35]){ $Capacitance{$Disty}{$PN} = &subCap("$field[35]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                $Voltage{$Disty}{$PN} = "";
                $Esr{$Disty}{$PN} = "";
                $Life{$Disty}{$PN} = "";
                if(defined $field[39] && defined $field[40]){ $OpTemp{$Disty}{$PN} = "$field[39]" . " - " . "$field[40]";}else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[38]){ $Ripple{$Disty}{$PN} = &subCur("$field[38]", $file);}else{ $Ripple{$Disty}{$PN} = '';}
                $Size{$Disty}{$PN} = "";
                $Height{$Disty}{$PN} = "";
              }elsif($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[8]){ $field[8] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[8]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[16]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[16]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[15]){ &subStock("$field[15]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[10]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[10]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[1]){ if($field[1] =~/NoPhoto/ || $field[1] eq ''){$field[1] = 'NoPhoto';}else{$field[1] = 'Photo';}$ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = 'NoPhoto';}
                if(defined $field[12]){ $Description{$Disty}{$PN} = "$field[12]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Capacitance{$Disty}{$PN} = &subCap("$field[22]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[23]){ $Voltage{$Disty}{$PN} = &subVol("$field[23]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                if(defined $field[31]){ $Esr{$Disty}{$PN} = &subRes("$field[31]", $file); }else{$Esr{$Disty}{$PN} = ''; }
                if(defined $field[30]){ $Life{$Disty}{$PN} = "$field[30]"; }else{$Life{$Disty}{$PN} = ''; }
                if(defined $field[25] && defined $field[26]){ $OpTemp{$Disty}{$PN} = "$field[25]" . " - " . "$field[26]";}else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[24]){ $Ripple{$Disty}{$PN} = &subCur("$field[24]", $file);}else{ $Ripple{$Disty}{$PN} = '';}
                $Size{$Disty}{$PN} = "";
                $Height{$Disty}{$PN} = "";
              }else{
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[4]){ $field[4] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[4]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[7]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[7]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[1]){ if($field[1] =~/NoPhoto/ || $field[1] eq ''){$field[1] = 'NoPhoto';}else{$field[1] = 'Photo';}$ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = 'NoPhoto';}
                if(defined $field[8]){ $Description{$Disty}{$PN} = "$field[8]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[18]){ $Capacitance{$Disty}{$PN} = &subCap("$field[18]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[19]){ $Voltage{$Disty}{$PN} = &subVol("$field[19]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                if(defined $field[29]){ $Esr{$Disty}{$PN} = &subRes("$field[29]", $file); }else{$Esr{$Disty}{$PN} = ''; }
                if(defined $field[28]){ $Life{$Disty}{$PN} = "$field[28]"; }else{$Life{$Disty}{$PN} = ''; }
                if(defined $field[22] && defined $field[23]){ $OpTemp{$Disty}{$PN} = "$field[22]" . " to " . "$field[23]";}else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[21]){ $Ripple{$Disty}{$PN} = &subCur("$field[21]", $file);}else{ $Ripple{$Disty}{$PN} = '';}
                $Size{$Disty}{$PN} = "";
                $Height{$Disty}{$PN} = "";
              } 
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            } 
        #06
        }when('Inductor'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[12]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[13]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[13]", $file);}else{$MOQ{$Disty}{$PN} = '';}
                if(defined $field[18]){ $Series{$Disty}{$PN} = "$field[18]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[19]){ $Type{$Disty}{$PN} = "$field[19]";}else{$Type{$Disty}{$PN} = '';}
                if(defined $field[20]){ $Core{$Disty}{$PN} = "$field[20]";}else{$Core{$Disty}{$PN} = '';}
                if(defined $field[21]){ $Inductance{$Disty}{$PN} = &subInd("$field[21]", $file);}else{$Inductance{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Tolerance{$Disty}{$PN} = "$field[22]";}else{$Tolerance{$Disty}{$PN} = '';}
                if(defined $field[23]){ $CurrentRating{$Disty}{$PN} = &subCur("$field[23]", $file);}else{$CurrentRating{$Disty}{$PN} = '';}
                if(defined $field[24]){ $CurrentSaturation{$Disty}{$PN} = &subCur("$field[24]", $file);}else{$CurrentSaturation{$Disty}{$PN} = '';}
                if(defined $field[25]){ $Shielding{$Disty}{$PN} = "$field[25]";}else{$Shielding{$Disty}{$PN} = '';}
                if(defined $field[26]){ $DCR{$Disty}{$PN} = "$field[26]";}else{$DCR{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Q{$Disty}{$PN} = "$field[27]";}else{$Q{$Disty}{$PN} = '';}
                if(defined $field[28]){ $Frequency{$Disty}{$PN} = "$field[28]";}else{$Frequency{$Disty}{$PN} = '';}
                $AECQ200{$Disty}{$PN} = "";
                if(defined $field[29]){ $OpTemp{$Disty}{$PN} = "$field[29]";}else{$OpTemp{$Disty}{$PN} = '';}
                if(defined $field[29]){ $TempMin{$Disty}{$PN} = substr("$field[29]",0,index($field[29],"~"));}else{$TempMin{$Disty}{$PN} = '';}
                if(defined $field[29]){ $TempMax{$Disty}{$PN} = substr("$field[29]",index($field[29],"~")+1,);}else{$TempMax{$Disty}{$PN} = '';}
                if(defined $field[30]){ $FrequencyTest{$Disty}{$PN} = "$field[30]";}else{$FrequencyTest{$Disty}{$PN} = '';}
                $Mounting{$Disty}{$PN} = "";
                if(defined $field[33]){ $Size{$Disty}{$PN} = "$field[33]";}else{$Size{$Disty}{$PN} = '';}
                if(defined $field[34]){ $HeightMax{$Disty}{$PN} = "$field[34]";}else{$HeightMax{$Disty}{$PN} = '';}

            }elsif($Disty eq 'MS'){
              if($date2 <= '20180412'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[8]){ $field[8] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[8]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[20]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[20]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[17]){ &subStock("$field[17]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[10]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[10]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                $Description{$Disty}{$PN} = '';
                $Series{$Disty}{$PN} = '';
                $Type{$Disty}{$PN} = '';
                $Core{$Disty}{$PN} = '';
                $Inductance{$Disty}{$PN} = '';
                $Tolerance{$Disty}{$PN} = '';
		$CurrentRating{$Disty}{$PN} = '';
		$CurrentSaturation{$Disty}{$PN} = '';
		$Shielding{$Disty}{$PN} = '';
		$DCR{$Disty}{$PN} = '';
                $Q{$Disty}{$PN} = '';
		$Frequency{$Disty}{$PN} = '';
		$AECQ200{$Disty}{$PN} = '';
		$OpTemp{$Disty}{$PN} = '';
		$TempMin{$Disty}{$PN} = '';
		$TempMax{$Disty}{$PN} = '';
		$FrequencyTest{$Disty}{$PN} = '';
		$Mounting{$Disty}{$PN} = '';
		$Size{$Disty}{$PN} = ''; 
		$HeightMax{$Disty}{$PN} = '';

              }elsif($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[8]){ $field[8] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[8]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[21]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[21]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[20]){ &subStock("$field[20]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[13]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[13]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                $Description{$Disty}{$PN} = '';
                $MOQ{$Disty}{$PN} = '';
                $Series{$Disty}{$PN} = '';
                $Type{$Disty}{$PN} = '';
                $Core{$Disty}{$PN} = '';
                $Inductance{$Disty}{$PN} = '';
                $Tolerance{$Disty}{$PN} = '';
		$CurrentRating{$Disty}{$PN} = '';
		$CurrentSaturation{$Disty}{$PN} = '';
		$Shielding{$Disty}{$PN} = '';
		$DCR{$Disty}{$PN} = '';
                $Q{$Disty}{$PN} = '';
		$Frequency{$Disty}{$PN} = '';
		$AECQ200{$Disty}{$PN} = '';
		$OpTemp{$Disty}{$PN} = '';
		$TempMin{$Disty}{$PN} = '';
		$TempMax{$Disty}{$PN} = '';
		$FrequencyTest{$Disty}{$PN} = '';
		$Mounting{$Disty}{$PN} = '';
		$Size{$Disty}{$PN} = ''; 
		$HeightMax{$Disty}{$PN} = '';

              }else{
                if(defined $field[4] && $field[4] ne ''){ $field[4] =~ s/; [a-z]*//; &subPN("$field[4]" ,$file); if ( &subPN_daily("$field[4]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[3]){ $field[3] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[3]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[11]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[11]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[10]){ &subStock("$field[10]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[5]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[5]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[7]){ $Description{$Disty}{$PN} = "$field[7]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[34]){ $Series{$Disty}{$PN} = "$field[34]";}else{$Series{$Disty}{$PN} = '';}
                $Type{$Disty}{$PN} = '';
                $Core{$Disty}{$PN} = '';
                if(defined $field[17]){ $Inductance{$Disty}{$PN} = &subInd("$field[17]", $file);}else{$Inductance{$Disty}{$PN} = '';}
                if(defined $field[18]){ $Tolerance{$Disty}{$PN} = "$field[18]";}else{$Tolerance{$Disty}{$PN} = '';}
                if(defined $field[19]){ $CurrentRating{$Disty}{$PN} = &subCur("$field[19]", $file);}else{$CurrentRating{$Disty}{$PN} = '';}
                if(defined $field[22]){ $CurrentSaturation{$Disty}{$PN} = &subCur("$field[22]", $file);}else{$CurrentSaturation{$Disty}{$PN} = '';}
                if(defined $field[16]){ $Shielding{$Disty}{$PN} = "$field[16]";}else{$Shielding{$Disty}{$PN} = '';}
                if(defined $field[20]){ $DCR{$Disty}{$PN} = &subRes("$field[20]", $file); }else{$DCR{$Disty}{$PN} = ''; }
                $Q{$Disty}{$PN} = '';
                if(defined $field[21]){ $Frequency{$Disty}{$PN} = "$field[21]";}else{$Frequency{$Disty}{$PN} = '';}
                if(defined $field[33]){ $AECQ200{$Disty}{$PN} = "$field[33]";}else{$AECQ200{$Disty}{$PN} = '';}
                if(defined $field[23] && defined $field[24]){ $OpTemp{$Disty}{$PN} = "$field[23]" . " to " . "$field[24]";}else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[23]){ $TempMin{$Disty}{$PN} = "$field[23]";}else{$TempMin{$Disty}{$PN} = '';}
                if(defined $field[24]){ $TempMax{$Disty}{$PN} = "$field[24]";}else{$TempMax{$Disty}{$PN} = '';}
                if(defined $field[25]){ $FrequencyTest{$Disty}{$PN} = "$field[25]";}else{$FrequencyTest{$Disty}{$PN} = '';}
                if(defined $field[15]){ $Mounting{$Disty}{$PN} = "$field[15]";}else{$Mounting{$Disty}{$PN} = '';}
                if(defined $field[29] && defined $field[30]){ $Size{$Disty}{$PN} = "$field[29]" . " x " . "$field[30]";}else{$Size{$Disty}{$PN} = ''; }
                if(defined $field[31]){ $HeightMax{$Disty}{$PN} = "$field[31]";}else{$HeightMax{$Disty}{$PN} = '';}
              }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }
        #07
        }when('Tact_Switch'){
            if($Disty eq 'DK'){
              if($date2 <= '20190116'){
                if (&subStatus("$field[12]") eq "1"){next;}
                #if ($field[12] =~/Digi-Reel/){next;}
                #$field[13] =~ s/ Minimum.*//; $field[13] =~s/Non-Stock.*//; $field[13] =~s/-//; if ($field[13] ne '1'){$SPQ{$Disty}{"$field[6]"} = "$field[13]"; next;}
                $field[13] =~ s/ Minimum.*//; $field[13] =~s/Non-Stock.*//; $field[13] =~s/-//; if ($field[13] ne '1'){$SPQ{$Disty}{"$field[6]"} = "$field[13]";}
		if(defined $SPQ{$Disty}{"$field[6]"}){}else{$SPQ{$Disty}{"$field[6]"} = '1';}
                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[1]){ $ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[5]){ $PNLink{$Disty}{$PN} = "$field[5]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[13]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[13]", $file);}else{$MOQ{$Disty}{$PN} = '';}
                if(defined $field[24]){ $Orientation{$Disty}{$PN} = "$field[24]";}else{$Orientation{$Disty}{$PN} = '';}
                if(defined $field[26]){ $Size{$Disty}{$PN} = "$field[26]";}else{$Size{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Height{$Disty}{$PN} = &subLen("$field[22]", $file);}else{$Height{$Disty}{$PN} = '';}
                if(defined $field[27]){ 
		    if($field[27] eq '-'){
		        $Opforce{$Disty}{$PN} = ''; $Opforce2{$Disty}{$PN} = '';
		    }else{
		        $field[27] =~ s/gf//g; $field[27] =~ s/~/\//g; my @subfield = split(/\//,$field[27]);
		        if(defined $subfield[0]){ $Opforce{$Disty}{$PN} = $subfield[0]*0.01;}else{$Opforce{$Disty}{$PN} = '';}
		        if(defined $subfield[1]){ $Opforce2{$Disty}{$PN} = $subfield[1]*0.01;}else{$Opforce2{$Disty}{$PN} = '';}
		    }
		}else{
		    $Opforce{$Disty}{$PN} = ''; $Opforce2{$Disty}{$PN} = '';
		}
                if(defined $field[28]){ $Protection{$Disty}{$PN} = "$field[28]";}else{$Protection{$Disty}{$PN} = '';}
                if(defined $field[25]){ $Term{$Disty}{$PN} = "$field[25]";}else{$Term{$Disty}{$PN} = '';}
                if(defined $field[21]){ $Mounting{$Disty}{$PN} = &subMounting("$field[21]", $file); }else{$Mounting{$Disty}{$PN} = ''; }
                if(defined $field[19]){ 
                    my @subfield = split(/@/,$field[19]);
                    if($subfield[0] =~/VA/){
		        $subfield[0] =~ s/VA//;
		        $CurrentRating{$Disty}{$PN} = '';
			$PowerRating{$Disty}{$PN} = "$subfield[0]";
                    }elsif($subfield[0] =~/A/){
		        $subfield[0] =~ s/A//;
		        $CurrentRating{$Disty}{$PN} = "$subfield[0]";
		        $PowerRating{$Disty}{$PN} = '';
		    }else{
		        $CurrentRating{$Disty}{$PN} = "$subfield[0]";
		        $PowerRating{$Disty}{$PN} = '';
		    }
                    if($subfield[1] =~/VAC\/DC/){
		        $subfield[1] =~ s/VAC\/DC//;
		        $VoltageRatingAC{$Disty}{$PN} = "$subfield[1]";
		        $VoltageRatingDC{$Disty}{$PN} = "$subfield[1]";
                    }elsif($subfield[1] =~/VAC/){
		        $subfield[1] =~ s/VAC//;
		        $VoltageRatingAC{$Disty}{$PN} = "$subfield[1]";
		        $VoltageRatingDC{$Disty}{$PN} = '';
                    }elsif($subfield[1] =~/VDC/){
		        $subfield[1] =~ s/VDC//;
		        $VoltageRatingAC{$Disty}{$PN} = '';
		        $VoltageRatingDC{$Disty}{$PN} = "$subfield[1]";
                    }else{
		        $VoltageRatingAC{$Disty}{$PN} = '';
		        $VoltageRatingDC{$Disty}{$PN} = "$subfield[1]";
		    }
		}else{
		        $CurrentRating{$Disty}{$PN} = '';
		        $PowerRating{$Disty}{$PN} = '';
		        $VoltageRatingAC{$Disty}{$PN} = '';
		        $VoltageRatingDC{$Disty}{$PN} = '';
		}
                $OpTemp{$Disty}{$PN} = ''; $OpTempL{$Disty}{$PN} = ''; $OpTempH{$Disty}{$PN} = '';
              }else{
                if (&subStatus("$field[22]") eq "1"){next;}
                if ($field[14] =~/Digi-Reel/){next;}
                $field[15] =~ s/ Minimum.*//; $field[15] =~s/Non-Stock.*//;  $field[15] =~s/-//; if ($field[15] ne '1'){$SPQ{$Disty}{"$field[7]"} = "$field[15]"; next;}
		if(defined $SPQ{$Disty}{"$field[7]"}){}else{$SPQ{$Disty}{"$field[7]"} = '1';}
                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[7]){ $MPN{$Disty}{$PN} = "$field[7]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[14]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[14]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[9]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[9]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[1]){ $ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[5]){ $PNLink{$Disty}{$PN} = "$field[5]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[11]){ $Description{$Disty}{$PN} = "$field[11]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[15]){ $MOQ{$Disty}{$PN} = "$field[15]";}else{$MOQ{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Orientation{$Disty}{$PN} = "$field[30]";}else{$Orientation{$Disty}{$PN} = '';}
                if(defined $field[32]){ $Size{$Disty}{$PN} = "$field[32]";}else{$Size{$Disty}{$PN} = '';}
                if(defined $field[28]){ $Height{$Disty}{$PN} = &subLen("$field[28]", $file);}else{$Height{$Disty}{$PN} = '';}
                if(defined $field[33]){ 
		    if($field[33] eq '-'){
		        $Opforce{$Disty}{$PN} = ''; $Opforce2{$Disty}{$PN} = '';
		    }else{
		        $field[33] =~ s/gf//g; $field[33] =~ s/~/\//g; my @subfield = split(/\//,$field[33]);
		        if(defined $subfield[0]){ $Opforce{$Disty}{$PN} = $subfield[0]*0.01;}else{$Opforce{$Disty}{$PN} = '';}
		        if(defined $subfield[1]){ $Opforce2{$Disty}{$PN} = $subfield[1]*0.01;}else{$Opforce2{$Disty}{$PN} = '';}
		    }
		}else{
		    $Opforce{$Disty}{$PN} = ''; $Opforce2{$Disty}{$PN} = '';
		}
                if(defined $field[34]){ $Protection{$Disty}{$PN} = "$field[34]";}else{$Protection{$Disty}{$PN} = '';}
                if(defined $field[31]){ $Term{$Disty}{$PN} = "$field[31]";}else{$Term{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Mounting{$Disty}{$PN} = &subMounting("$field[27]", $file); }else{$Mounting{$Disty}{$PN} = ''; }
                if(defined $field[25]){ 
                    my @subfield = split(/@/,$field[25]);
                    if($subfield[0] =~/VA/){
		        $subfield[0] =~ s/VA//;
		        $CurrentRating{$Disty}{$PN} = '';
			$PowerRating{$Disty}{$PN} = "$subfield[0]";
                    }elsif($subfield[0] =~/A/){
		        $subfield[0] =~ s/A//;
		        $CurrentRating{$Disty}{$PN} = "$subfield[0]";
		        $PowerRating{$Disty}{$PN} = '';
		    }else{
		        $CurrentRating{$Disty}{$PN} = "$subfield[0]";
		        $CurrentRating{$Disty}{$PN} = '';
		    }
                    if($subfield[1] =~/VAC\/DC/){
		        $subfield[1] =~ s/VAC\/DC//;
		        $VoltageRatingAC{$Disty}{$PN} = "$subfield[1]";
		        $VoltageRatingDC{$Disty}{$PN} = "$subfield[1]";
                    }elsif($subfield[1] =~/VAC/){
		        $subfield[1] =~ s/VAC//;
		        $VoltageRatingAC{$Disty}{$PN} = "$subfield[1]";
		        $VoltageRatingDC{$Disty}{$PN} = '';
                    }elsif($subfield[1] =~/VDC/){
		        $subfield[1] =~ s/VDC//;
		        $VoltageRatingAC{$Disty}{$PN} = '';
		        $VoltageRatingDC{$Disty}{$PN} = "$subfield[1]";
                    }else{
		        $VoltageRatingAC{$Disty}{$PN} = '';
		        $VoltageRatingDC{$Disty}{$PN} = "$subfield[1]";
		    }
		}else{
		        $CurrentRating{$Disty}{$PN} = '';
		        $PowerRating{$Disty}{$PN} = '';
		        $VoltageRatingAC{$Disty}{$PN} = '';
		        $VoltageRatingDC{$Disty}{$PN} = '';
		}
                if(defined $field[36]){ 
		    $OpTemp{$Disty}{$PN} = &subOptemp("$field[36]", $file);
                    if($OpTemp{$Disty}{$PN} =~/~/){
		        my @subfield = split(/~/,$OpTemp{$Disty}{$PN}); $OpTempL{$Disty}{$PN} = $subfield[0]; $OpTempH{$Disty}{$PN} = $subfield[1];
		    }else{
		        $OpTempL{$Disty}{$PN} = ''; $OpTempH{$Disty}{$PN} = '';
		    }
		}else{
		    $OpTemp{$Disty}{$PN} = ''; $OpTempL{$Disty}{$PN} = ''; $OpTempH{$Disty}{$PN} = '';
		}
	      }

            }elsif($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[8]){ $field[8] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[8]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[20]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[20]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[19]){ &subStock("$field[19]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}
		$SPQ{$Disty}{$MPN{$Disty}{$PN}} = '';

                $ImageLink{$Disty}{$PN} = '';
                $PNLink{$Disty}{$PN} = '';
                $Description{$Disty}{$PN} = '';
                $Orientation{$Disty}{$PN} = '';
                $Size{$Disty}{$PN} = '';
                $Height{$Disty}{$PN} = '';
		$Opforce{$Disty}{$PN} = '';
		$Opforce2{$Disty}{$PN} = '';
                $Protection{$Disty}{$PN} = '';
                $Term{$Disty}{$PN} = '';
                $Mounting{$Disty}{$PN} = '';
                $CurrentRating{$Disty}{$PN} = '';
                $VoltageRatingDC{$Disty}{$PN} = '';
                $VoltageRatingAC{$Disty}{$PN} = '';
                $PowerRating{$Disty}{$PN} = '';
                $OpTemp{$Disty}{$PN} = ''; $OpTempL{$Disty}{$PN} = ''; $OpTempH{$Disty}{$PN} = '';

	      }else{
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[4]){ $field[4] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[4]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[7]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[7]", $file);}else{$Supplier{$Disty}{$PN} = '';}
		$SPQ{$Disty}{$MPN{$Disty}{$PN}} = '';

                if(defined $field[1]){ $ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[5]){ $PNLink{$Disty}{$PN} = "$field[5]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[9]){ $Description{$Disty}{$PN} = "$field[9]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[19]){ $Orientation{$Disty}{$PN} = "$field[19]";}else{$Orientation{$Disty}{$PN} = '';}
                if(defined $field[30] || defined $field[31]){ $Size{$Disty}{$PN} = "$field[30]" . " x " . "$field[31]";}else{$Size{$Disty}{$PN} = '';}
                if(defined $field[32]){ $Height{$Disty}{$PN} =  &subLen("$field[32]", $file);}else{$Height{$Disty}{$PN} = '';}
                if(defined $field[22]){ 
                    $field[22] =~ s/g[fF]/g/g; $field[22] =~ s/N /N\//; $field[22] =~ s/g /g\//;  $field[22] =~ s/-//;
		    my @subfield = split(/\//,$field[22]);
                    if($field[22] =~/g/){ 
		        if(defined $subfield[0]){ $subfield[0] =~ s/g//g; $Opforce{$Disty}{$PN} = $subfield[0]*0.01;}else{$Opforce{$Disty}{$PN} = '';}
                        if(defined $subfield[1]){ $subfield[1] =~ s/g//g; $Opforce2{$Disty}{$PN} = $subfield[1]*0.01;}else{$Opforce2{$Disty}{$PN} = '';}
                    }elsif($field[22] =~/N/){ 
		        if(defined $subfield[0]){ $subfield[0] =~ s/N//g; $Opforce{$Disty}{$PN} = $subfield[0];}else{$Opforce{$Disty}{$PN} = '';}
		        if(defined $subfield[1]){ $subfield[1] =~ s/N//g; $Opforce2{$Disty}{$PN} = $subfield[1];}else{$Opforce2{$Disty}{$PN} = '';}
		    }else{
		        if(defined $subfield[0]){ $Opforce{$Disty}{$PN} = $subfield[0];}else{$Opforce{$Disty}{$PN} = '';}
		        if(defined $subfield[1]){ $Opforce2{$Disty}{$PN} = $subfield[1];}else{$Opforce2{$Disty}{$PN} = '';}
		    }
		}else{
		    $Opforce{$Disty}{$PN} = '';
		    $Opforce2{$Disty}{$PN} = '';
		}
                if(defined $field[34]){ $Protection{$Disty}{$PN} = "$field[34]";}else{$Protection{$Disty}{$PN} = '';}
                if(defined $field[28]){ $Term{$Disty}{$PN} = "$field[28]";}else{$Term{$Disty}{$PN} = '';}
                if(defined $field[18]){ $Mounting{$Disty}{$PN} = &subMounting("$field[18]", $file); }else{$Mounting{$Disty}{$PN} = ''; }
                if(defined $field[23]){ $CurrentRating{$Disty}{$PN} = &subCur("$field[23]", $file); }else{$CurrentRating{$Disty}{$PN} = ''; }
                if(defined $field[24]){ $field[24] =~ s/VDC//; $VoltageRatingDC{$Disty}{$PN} = "$field[24]"; }else{$VoltageRatingDC{$Disty}{$PN} = ''; }
                $VoltageRatingAC{$Disty}{$PN} = '';
                if(defined $field[25]){ $PowerRating{$Disty}{$PN} = "$field[25]"; }else{$PowerRating{$Disty}{$PN} = ''; }
                $OpTemp{$Disty}{$PN} = ''; $OpTempL{$Disty}{$PN} = ''; $OpTempH{$Disty}{$PN} = '';
	      }

            }elsif($Disty eq 'FN'){
                if(defined $field[8] && $field[8] ne ''){ &subPN("$field[8]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[1]){ $MPN{$Disty}{$PN} = "$field[1]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[33]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[33]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[31]){ &subStock("$field[31]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[20]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[20]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[32]){ $field[32] =~ s/\+//; $MOQ{$Disty}{$PN} = "$field[32]";}else{$MOQ{$Disty}{$PN} = '';}
		$SPQ{$Disty}{$MPN{$Disty}{$PN}} = '';

                if(defined $field[5]){ $ImageLink{$Disty}{$PN} = "$field[5]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[2]){ $PNLink{$Disty}{$PN} = "$field[2]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[12]){ $Description{$Disty}{$PN} = "$field[12]";}else{$Description{$Disty}{$PN} = '';}
                $Orientation{$Disty}{$PN} = '';
                $Size{$Disty}{$PN} = '';
                $Height{$Disty}{$PN} = '';
		$Opforce{$Disty}{$PN} = '';
                $Opforce2{$Disty}{$PN} = "";
                $Protection{$Disty}{$PN} = "";
                $Term{$Disty}{$PN} = "";
		$Mounting{$Disty}{$PN} = '';
                $VoltageRatingDC{$Disty}{$PN} = '';
		$CurrentRating{$Disty}{$PN} = ''; 
                $VoltageRatingDC{$Disty}{$PN} = ""; $VoltageRatingAC{$Disty}{$PN} = "";
                $PowerRating{$Disty}{$PN} = "";
                $OpTemp{$Disty}{$PN} = ''; $OpTempL{$Disty}{$PN} = ''; $OpTempH{$Disty}{$PN} = '';

            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }
        #08
        }when('PhotoMOS'){
            if($Disty eq 'DK'){
              if($date2 <= '20181028'){
                if (&subStatus("$field[12]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[13]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[13]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Package{$Disty}{$PN} = "$field[27]";}else{$Package{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Current{$Disty}{$PN} = &subCur("$field[22]", $file); }else{$Current{$Disty}{$PN} = ''; }
                if(defined $field[24]){ $field[24] =~ s/.*\~//; $Voltage{$Disty}{$PN} = &subVol("$field[24]", $file); }else{$Voltage{$Disty}{$PN} = ''; }

              }else{
                if (&subStatus("$field[13]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[14]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[14]", $file);}else{$MOQ{$Disty}{$PN} = '';}
                if(defined $field[29]){ $Package{$Disty}{$PN} = "$field[29]";}else{$Package{$Disty}{$PN} = '';}
                if(defined $field[26]){ $Current{$Disty}{$PN} = &subCur("$field[26]", $file); }else{$Current{$Disty}{$PN} = ''; }
                if(defined $field[25]){ $field[25] =~ s/.*\~//; $Voltage{$Disty}{$PN} = &subVol("$field[25]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
              } 
            }elsif($Disty eq 'MS'){
              if($date2 <= '20170805'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[8]){ $field[8] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[8]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[22]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[22]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[19]){ &subStock("$field[19]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[34]){ $Package{$Disty}{$PN} = "$field[34]";}else{$Package{$Disty}{$PN} = '';}
                if(defined $field[32]){ $field[32] =~ s/.*to//; $Current{$Disty}{$PN} = &subCur("$field[32]", $file); }else{$Current{$Disty}{$PN} = ''; }
                if(defined $field[31]){ $field[31] =~ s/.*to//; if($field[31] =~/VAC/ && $field[31] =~/VDC/){$field[31] =~ s/.*VAC//;} $Voltage{$Disty}{$PN} = &subVol("$field[31]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
              }elsif($date2 <= '20180227'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[8]){ $field[8] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[8]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[22]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[22]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[19]){ &subStock("$field[19]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[35]){ $Package{$Disty}{$PN} = "$field[35]";}else{$Package{$Disty}{$PN} = '';}
                if(defined $field[31]){ $field[31] =~ s/.*to//; $Current{$Disty}{$PN} = &subCur("$field[31]", $file); }else{$Current{$Disty}{$PN} = ''; }
                if(defined $field[32]){ $field[32] =~ s/.*to//; if($field[32] =~/VAC/ && $field[32] =~/VDC/){$field[32] =~ s/.*VAC//;} $Voltage{$Disty}{$PN} = &subVol("$field[32]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
              }elsif($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[8]){ $field[8] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[8]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[22]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[22]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[19]){ &subStock("$field[19]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[35]){ $Package{$Disty}{$PN} = "$field[35]";}else{$Package{$Disty}{$PN} = '';}
                if(defined $field[32]){ $field[32] =~ s/.*to//; $Current{$Disty}{$PN} = &subCur("$field[32]", $file); }else{$Current{$Disty}{$PN} = ''; }
                if(defined $field[33]){ $field[33] =~ s/.*to//; if($field[33] =~/VAC/ && $field[33] =~/VDC/){$field[33] =~ s/.*VAC//;} $Voltage{$Disty}{$PN} = &subVol("$field[33]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
              }else{
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[4]){ $field[4] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[4]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[11]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[11]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[10]){ &subStock("$field[10]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[7]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[7]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[9]){ $Description{$Disty}{$PN} = "$field[9]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[20]){ $Package{$Disty}{$PN} = "$field[20]";}else{$Package{$Disty}{$PN} = '';}
                if(defined $field[17]){ $field[17] =~ s/.*to//; $Current{$Disty}{$PN} = &subCur("$field[17]", $file); }else{$Current{$Disty}{$PN} = ''; }
                if(defined $field[18]){ $field[18] =~ s/.*to//; if($field[18] =~/VAC/ && $field[18] =~/VDC/){$field[18] =~ s/.*VAC//;} $Voltage{$Disty}{$PN} = &subVol("$field[18]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
              }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            } 
        #10 
        }when('SD_Card'){
            if($Disty eq 'DK'){
              if($date2 <= '20170431'){
                if (&subStatus("$field[12]") eq "1"){next;}

                if(defined $field[6] && $field[6] ne ''){ &subPN("$field[6]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[12]){ $MPN{$Disty}{$PN} = "$field[12]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[17]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[17]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[17]){ $MemorySize{$Disty}{$PN} = "$field[17]";}else{$MemorySize{$Disty}{$PN} = '';}
                if(defined $field[20]){ $OpTemp{$Disty}{$PN} = "$field[20]"; }else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[16]){ $Type1{$Disty}{$PN} = "$field[16]";}else{$Type1{$Disty}{$PN} = '';}
                if(defined $field[19]){ $Type2{$Disty}{$PN} = "$field[19]";}else{$Type2{$Disty}{$PN} = '';}

              }else{
                if (&subStatus("$field[18]") eq "1"){next;}

                if(defined $field[8] && $field[8] ne ''){ &subPN("$field[8]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[12]){ $MPN{$Disty}{$PN} = "$field[12]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[18]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[18]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[17]){ &subStock("$field[17]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[14]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[14]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[19]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[19]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[16]){ $Description{$Disty}{$PN} = "$field[16]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[25]){ $MemorySize{$Disty}{$PN} = "$field[25]";}else{$MemorySize{$Disty}{$PN} = '';}
                if(defined $field[28]){ $OpTemp{$Disty}{$PN} = "$field[28]"; }else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[24]){ $Type1{$Disty}{$PN} = "$field[24]";}else{$Type1{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Type2{$Disty}{$PN} = "$field[27]";}else{$Type2{$Disty}{$PN} = '';}
	      }
            }elsif($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[7]){ $field[7] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[7]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[22]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[22]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[19]){ &subStock("$field[19]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Type1{$Disty}{$PN} = "$field[27]";}else{$Type1{$Disty}{$PN} = '';}
                if(defined $field[28]){ $MemorySize{$Disty}{$PN} = "$field[28]";}else{$MemorySize{$Disty}{$PN} = '';}
                $Type2{$Disty}{$PN} = "";
                $OpTemp{$Disty}{$PN} = "";
	      }else{
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[4]){ $field[4] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[4]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[7]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[7]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[9]){ $Description{$Disty}{$PN} = "$field[9]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[17]){ $Type1{$Disty}{$PN} = "$field[17]";}else{$Type1{$Disty}{$PN} = '';}
                if(defined $field[18]){ $MemorySize{$Disty}{$PN} = "$field[18]";}else{$MemorySize{$Disty}{$PN} = '';}
                $Type2{$Disty}{$PN} = "";
                $OpTemp{$Disty}{$PN} = "";
	      }
    
            }elsif($Disty eq 'AR'){
                if(defined $field[3] && $field[3] ne ''){ &subPN("$field[3]" ,$file); if ( &subPN_daily("$field[3]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[3]){ $MPN{$Disty}{$PN} = "$field[3]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[9]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[9]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[23]){ &subStock("$field[23]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[26]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[26]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[8]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[8]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[27]){ $Description{$Disty}{$PN} = "$field[27]";}else{$Description{$Disty}{$PN} = '';}
                $Series{$Disty}{$PN} = "";
                $Type1{$Disty}{$PN} = '';
                $Type2{$Disty}{$PN} = '';
                $MemorySize{$Disty}{$PN} = '';
                if(defined $field[33]){ $OpTemp{$Disty}{$PN} = "$field[33]"; }else{$OpTemp{$Disty}{$PN} = ''; }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            } 
        #11
        }when('eMMC'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[18]") eq "1"){next;}

                if(defined $field[8] && $field[8] ne ''){ &subPN("$field[8]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[12]){ $MPN{$Disty}{$PN} = "$field[12]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[18]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[18]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[17]){ &subStock("$field[17]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[14]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[14]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[19]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[19]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[16]){ $Description{$Disty}{$PN} = "$field[16]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[26]){ $MemoryFormat{$Disty}{$PN} = "$field[26]";}else{$MemoryFormat{$Disty}{$PN} = '';}
                if(defined $field[28]){ $MemorySize{$Disty}{$PN} = "$field[28]";}else{$MemorySize{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Memory{$Disty}{$PN} = "$field[30]";}else{$Memory{$Disty}{$PN} = '';}
                if(defined $field[31]){ $Voltage{$Disty}{$PN} = "$field[31]";}else{$Voltage{$Disty}{$PN} = '';}
                if(defined $field[32]){ $OpTemp{$Disty}{$PN} = "$field[32]";}else{$OpTemp{$Disty}{$PN} = '';}
                if(defined $field[34]){ $PackageCase{$Disty}{$PN} = "$field[34]";}else{$PackageCase{$Disty}{$PN} = '';}
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }
        #12
        }when('BtoB'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[14]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[14]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[14]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[15]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[15]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[19]){ $Series{$Disty}{$PN} = "$field[19]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[23]){ $field[23] =~ s/.*\(//; $field[23] =~ s/\)//; 
		    $Pitch{$Disty}{$PN} = &subLen("$field[23]", $file);}else{$Pitch{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Mated{$Disty}{$PN} = "$field[27]";}else{$Mated{$Disty}{$PN} = '';}
                if(defined $field[22]){ $field[22] =~ s/\(.*//;
                    $Position{$Disty}{$PN} = "$field[22]";}else{$Position{$Disty}{$PN} = '';}
    
            }elsif($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[8]){ $field[8] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[8]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[22]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[22]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[19]){ &subStock("$field[19]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[37]){ $Series{$Disty}{$PN} = "$field[37]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[32]){ $Pitch{$Disty}{$PN} = &subLen("$field[32]", $file);}else{$Pitch{$Disty}{$PN} = '';}
                $Mated{$Disty}{$PN} = '';
                if(defined $field[31]){
                    my @pfile = split(/ /,$field[31]);
                    if($#pfile eq '1'){$Position{$Disty}{$PN} = $pfile[0];}elsif($#pfile eq '3'){$Position{$Disty}{$PN} = $pfile[0]+$pfile[2];}else{$Position{$Disty}{$PN} = "$field[31]";}
	    	    }else{$Position{$Disty}{$PN} = '';}
	      }else{
                if(defined $field[11] && $field[11] ne ''){ $field[11] =~ s/; [a-z]*//; &subPN("$field[11]" ,$file); if ( &subPN_daily("$field[11]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[9]){ $field[9] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[9]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[20]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[20]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[17]){ &subStock("$field[17]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[13]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[13]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[1]){ $Description{$Disty}{$PN} = "$field[1]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[29]){ $Series{$Disty}{$PN} = "$field[29]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[26]){ $Pitch{$Disty}{$PN} = &subLen("$field[26]", $file);}else{$Pitch{$Disty}{$PN} = '';}
                $Mated{$Disty}{$PN} = '';
                if(defined $field[25]){
                    my @pfile = split(/ /,$field[25]);
                    if($#pfile eq '1'){$Position{$Disty}{$PN} = $pfile[0];}elsif($#pfile eq '3'){$Position{$Disty}{$PN} = $pfile[0]+$pfile[2];}else{$Position{$Disty}{$PN} = "$field[25]";}
	    	    }else{$Position{$Disty}{$PN} = '';}
	      }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            } 
        #13
        }when('FPC'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[12]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[13]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[13]", $file);}else{$MOQ{$Disty}{$PN} = '';}
                if(defined $field[17]){ $Series{$Disty}{$PN} = "$field[17]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[25]){ $Pitch{$Disty}{$PN} = "$field[25]";}else{$Pitch{$Disty}{$PN} = '';}
                if(defined $field[25]){ $field[25] =~ s/.*\(//; $field[25] =~ s/\)//; 
		    $Pitch{$Disty}{$PN} = &subLen("$field[25]", $file);}else{$Pitch{$Disty}{$PN} = '';}
                if(defined $field[23]){ $Contact{$Disty}{$PN} = "$field[23]";}else{$Contact{$Disty}{$PN} = '';}
                if(defined $field[24]){ $Position{$Disty}{$PN} = "$field[24]";}else{$Position{$Disty}{$PN} = '';}
    
            }elsif($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[8]){ $field[8] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[8]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[22]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[22]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[19]){ &subStock("$field[19]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[36]){ $Series{$Disty}{$PN} = "$field[36]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Pitch{$Disty}{$PN} = &subLen("$field[30]", $file);}else{$Pitch{$Disty}{$PN} = '';}
                if(defined $field[33]){ $Contact{$Disty}{$PN} = "$field[33]";}else{$Contact{$Disty}{$PN} = '';}
                if(defined $field[29]){ $field[29] =~ s/ Position//; $field[29] =~ s/ Positon//; $Position{$Disty}{$PN} = "$field[29]";}else{$Position{$Disty}{$PN} = '';}

              }else{
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[4]){ $field[4] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[4]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[7]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[7]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[9]){ $Description{$Disty}{$PN} = "$field[9]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[25]){ $Series{$Disty}{$PN} = "$field[25]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[19]){ $Pitch{$Disty}{$PN} = &subLen("$field[19]", $file);}else{$Pitch{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Contact{$Disty}{$PN} = "$field[22]";}else{$Contact{$Disty}{$PN} = '';}
                if(defined $field[18]){ $field[18] =~ s/ Position//; $field[18] =~ s/ Positon//; $Position{$Disty}{$PN} = "$field[18]";}else{$Position{$Disty}{$PN} = '';}
              }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            } 
        #20
        }when('LCD'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[12]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[13]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[13]", $file);}else{$MOQ{$Disty}{$PN} = '';}
                if(defined $field[19]){ $ScreenSize{$Disty}{$PN} = "$field[19]";}else{$ScreenSize{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Resolution{$Disty}{$PN} = "$field[22]";}else{$Resolution{$Disty}{$PN} = '';}
    
            }elsif($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[7]){ $field[7] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[7]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[20]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[20]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[19]){ &subStock("$field[19]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[26]){ $ScreenSize{$Disty}{$PN} = "$field[26]";}else{$ScreenSize{$Disty}{$PN} = '';}
                if(defined $field[28]){ $Resolution{$Disty}{$PN} = "$field[28]";}else{$Resolution{$Disty}{$PN} = '';}
              }else{
                if(defined $field[11] && $field[11] ne ''){ $field[11] =~ s/; [a-z]*//; &subPN("$field[11]" ,$file); if ( &subPN_daily("$field[11]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[9]){ $field[9] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[9]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[19]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[19]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[16]){ &subStock("$field[16]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[1]){ $Description{$Disty}{$PN} = "$field[1]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[23]){ $ScreenSize{$Disty}{$PN} = "$field[23]";}else{$ScreenSize{$Disty}{$PN} = '';}
                if(defined $field[25]){ $Resolution{$Disty}{$PN} = "$field[25]";}else{$Resolution{$Disty}{$PN} = '';}
	      }
    
            }elsif($Disty eq 'FN'){
              if($date2 <= '20180111'){
                if(defined $field[3] && $field[3] ne ''){ &subPN("$field[3]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[1]){ $MPN{$Disty}{$PN} = "$field[1]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[7]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[7]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[5]){ &subStock("$field[5]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[4]){ $Supplier{$Disty}{$PN} = &subSupplier("substr($field[4],0,rindex($field[4], "-")-1)", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[4]){ $Description{$Disty}{$PN} = "$field[4]";}else{$Description{$Disty}{$PN} = '';}
                $ScreenSize{$Disty}{$PN} = "";
                $Resolution{$Disty}{$PN} = "";
              }else{
                if(defined $field[3] && $field[3] ne ''){ &subPN("$field[3]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[1]){ $MPN{$Disty}{$PN} = "$field[1]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[10]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[10]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[8]){ &subStock("$field[8]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[4]){ $Supplier{$Disty}{$PN} = &subSupplier("substr($field[4],0,rindex($field[4], "-")-1)", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[4]){ $Description{$Disty}{$PN} = "$field[4]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[5]){ $ScreenSize{$Disty}{$PN} = "$field[5]";}else{$ScreenSize{$Disty}{$PN} = '';}
                if(defined $field[6]){ $Resolution{$Disty}{$PN} = "$field[6]";}else{$Resolution{$Disty}{$PN} = '';}
 	      }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
 	    }

        #21
        }when('Battery'){
            if($Disty eq 'DK'){
                #NOTE. Neglect line in case 1)"Minimum Quantity" is not. 1 2)Digi-Reel package
                $field[17] =~ s/ Minimum.*//;
                #if ($field[17] ne '1'){next;}
                #if ($field[16] =~/Digi-Reel/){next;}
                if (&subStatus("$field[16]") eq "1"){next;}

                if(defined $field[8] && $field[8] ne ''){ &subPN("$field[8]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[10]){ $MPN{$Disty}{$PN} = "$field[10]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[16]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[16]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[15]){ &subStock("$field[15]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[18]){ $Series{$Disty}{$PN} = "$field[18]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Chemistry{$Disty}{$PN} = "$field[22]";}else{$Chemistry{$Disty}{$PN} = '';}
                if(defined $field[23]){ $Cell{$Disty}{$PN} = "$field[23]";}else{$Cell{$Disty}{$PN} = '';}
                if(defined $field[24]){ $Voltage{$Disty}{$PN} = "$field[24]";}else{$Voltage{$Disty}{$PN} = '';}
                if(defined $field[25]){ $Capacity{$Disty}{$PN} = "$field[25]";}else{$Capacity{$Disty}{$PN} = '';}
                if(defined $field[26]){ $Size{$Disty}{$PN} = "$field[26]";}else{$Size{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Term{$Disty}{$PN} = "$field[27]";}else{$Term{$Disty}{$PN} = '';}

            }elsif($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[7]){ $field[7] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[7]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[18]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[18]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[14]){ &subStock("$field[14]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[9]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[9]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[11]){ $Description{$Disty}{$PN} = "$field[11]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Series{$Disty}{$PN} = "$field[27]";}else{$Series{$Disty}{$PN} = '';}
                $Chemistry{$Disty}{$PN} = '';
                $Cell{$Disty}{$PN} = '';
                $Voltage{$Disty}{$PN} = '';
                if(defined $field[29]){ $Capacity{$Disty}{$PN} = "$field[29]";}else{$Capacity{$Disty}{$PN} = '';}
                if(defined $field[28]){ $Size{$Disty}{$PN} = "$field[28]";}else{$Size{$Disty}{$PN} = '';}
                $Term{$Disty}{$PN} = '';
	      }else{
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[4]){ $field[4] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[4]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[7]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[7]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[9]){ $Description{$Disty}{$PN} = "$field[9]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[17]){ $Series{$Disty}{$PN} = "$field[17]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[21]){ $Chemistry{$Disty}{$PN} = "$field[21]";}else{$Chemistry{$Disty}{$PN} = '';}
                if(defined $field[19]){ $Voltage{$Disty}{$PN} = "$field[19]";}else{$Voltage{$Disty}{$PN} = '';}
                if(defined $field[20]){ $Capacity{$Disty}{$PN} = "$field[20]";}else{$Capacity{$Disty}{$PN} = '';}
                if(defined $field[18]){ $Cell{$Disty}{$PN} = "$field[18]";}else{$Cell{$Disty}{$PN} = '';}
                $Size{$Disty}{$PN} = '';
                $Term{$Disty}{$PN} = '';
	      }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }
        #22
        }when('Si_GaN_SiCFET'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[15]") eq "1"){next;}

                if(defined $field[7] && $field[7] ne ''){ &subPN("$field[7]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[9]){ $MPN{$Disty}{$PN} = "$field[9]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[15]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[15]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[14]){ &subStock("$field[14]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[11]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[11]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[13]){ $Description{$Disty}{$PN} = "$field[13]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[16]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[16]", $file);}else{$MOQ{$Disty}{$PN} = '';}
                if(defined $field[20]){ $Series{$Disty}{$PN} = "$field[20]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[24]){ $Tech{$Disty}{$PN} = "$field[24]";}else{$Tech{$Disty}{$PN} = '';}
                if(defined $field[25]){ $Vds{$Disty}{$PN} = &subVol("$field[25]", $file); }else{$Vds{$Disty}{$PN} = ''; }
                if(defined $field[26]){ $Current{$Disty}{$PN} = "$field[26]";}else{$Current{$Disty}{$PN} = '';}
                if(defined $field[28]){ $Vgsth{$Disty}{$PN} = "$field[28]";}else{$Vgsth{$Disty}{$PN} = '';}
                if(defined $field[29]){ $Qg{$Disty}{$PN} = "$field[29]";}else{$Qg{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Vgsmax{$Disty}{$PN} = "$field[30]";}else{$Vgsmax{$Disty}{$PN} = '';}
                if(defined $field[34]){ $Ron{$Disty}{$PN} = &subRes("$field[34]", $file); }else{$Ron{$Disty}{$PN} = ''; }
                if(defined $field[35]){ $OpTemp{$Disty}{$PN} = "$field[35]";}else{$OpTemp{$Disty}{$PN} = '';}
                if(defined $field[36]){ $Mounting{$Disty}{$PN} = "$field[36]";}else{$Mounting{$Disty}{$PN} = '';}
                if(defined $field[38]){ $Package{$Disty}{$PN} = "$field[38]";}else{$Package{$Disty}{$PN} = '';}
                if(defined $field[23]){ $Status{$Disty}{$PN} = "$field[23]";}else{$Status{$Disty}{$PN} = '';}
                $Power{$Disty}{$PN} = '';
    
            }elsif($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[9]){ $field[9] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[9]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[23]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[23]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[20]){ &subStock("$field[20]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[13]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[13]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[15]){ $Description{$Disty}{$PN} = "$field[15]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[42]){ $Series{$Disty}{$PN} = "$field[42]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[29]){ $Tech{$Disty}{$PN} = "$field[29]";}else{$Tech{$Disty}{$PN} = '';}
                if(defined $field[33]){ $Vds{$Disty}{$PN} = &subVol("$field[33]", $file); }else{$Vds{$Disty}{$PN} = ''; }
                if(defined $field[34]){ $Current{$Disty}{$PN} = "$field[34]";}else{$Current{$Disty}{$PN} = '';}
                if(defined $field[36]){ $Vgsth{$Disty}{$PN} = "$field[36]";}else{$Vgsth{$Disty}{$PN} = '';}
                if(defined $field[38]){ $Qg{$Disty}{$PN} = "$field[38]";}else{$Qg{$Disty}{$PN} = '';}
                if(defined $field[37]){ $Vgsmax{$Disty}{$PN} = "$field[37]";}else{$Vgsmax{$Disty}{$PN} = '';}
                if(defined $field[35]){ $Ron{$Disty}{$PN} = &subRes("$field[35]", $file); }else{$Ron{$Disty}{$PN} = ''; }
                if(defined $field[39] && defined $field[40]){ $OpTemp{$Disty}{$PN} = "$field[39]" . " - " . "$field[40]";}else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[31]){ $Mounting{$Disty}{$PN} = "$field[31]";}else{$Mounting{$Disty}{$PN} = '';}
                if(defined $field[32]){ $Package{$Disty}{$PN} = "$field[32]";}else{$Package{$Disty}{$PN} = '';}
                $Status{$Disty}{$PN} = '';
                if(defined $field[41]){ $Power{$Disty}{$PN} = "$field[41]";}else{$Power{$Disty}{$PN} = '';}
              }else{
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[3]){ $field[3] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[3]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[6]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[6]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[8]){ $Description{$Disty}{$PN} = "$field[8]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[32]){ $Series{$Disty}{$PN} = "$field[32]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[15]){ $Tech{$Disty}{$PN} = "$field[15]";}else{$Tech{$Disty}{$PN} = '';}
                if(defined $field[20]){ $Vds{$Disty}{$PN} = &subVol("$field[20]", $file); }else{$Vds{$Disty}{$PN} = ''; }
                if(defined $field[21]){ $Current{$Disty}{$PN} = "$field[21]";}else{$Current{$Disty}{$PN} = '';}
                if(defined $field[23]){ $Vgsth{$Disty}{$PN} = "$field[23]";}else{$Vgsth{$Disty}{$PN} = '';}
                if(defined $field[25]){ $Qg{$Disty}{$PN} = "$field[25]";}else{$Qg{$Disty}{$PN} = '';}
                if(defined $field[24]){ $Vgsmax{$Disty}{$PN} = "$field[24]";}else{$Vgsmax{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Ron{$Disty}{$PN} = &subRes("$field[22]", $file); }else{$Ron{$Disty}{$PN} = ''; }
                if(defined $field[26] && defined $field[27]){ $OpTemp{$Disty}{$PN} = "$field[26]" . " - " . "$field[27]";}else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[16]){ $Mounting{$Disty}{$PN} = "$field[16]";}else{$Mounting{$Disty}{$PN} = '';}
                if(defined $field[17]){ $Package{$Disty}{$PN} = "$field[17]";}else{$Package{$Disty}{$PN} = '';}
                $Status{$Disty}{$PN} = '';
                if(defined $field[28]){ $Power{$Disty}{$PN} = "$field[28]";}else{$Power{$Disty}{$PN} = '';}
              }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }
        #22
        }when('IGBT_PENDING'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[17]") eq "1"){next;}

                if(defined $field[7] && $field[7] ne ''){ &subPN("$field[7]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[11]){ $MPN{$Disty}{$PN} = "$field[11]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[17]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[17]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[16]){ &subStock("$field[16]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[13]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[13]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[15]){ $Description{$Disty}{$PN} = "$field[15]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[18]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[18]", $file);}else{$MOQ{$Disty}{$PN} = '';}
                if(defined $field[37]){ $Vce{$Disty}{$PN} = "$field[37]";}else{$Vce{$Disty}{$PN} = '';}
                if(defined $field[24]){ $Current{$Disty}{$PN} = "$field[24]";}else{$Current{$Disty}{$PN} = '';}
                if(defined $field[33]){ $OpTemp{$Disty}{$PN} = "$field[33]";}else{$OpTemp{$Disty}{$PN} = '';}
                if(defined $field[34]){ $Mounting{$Disty}{$PN} = "$field[34]";}else{$Mounting{$Disty}{$PN} = '';}
                if(defined $field[35]){ $Package{$Disty}{$PN} = "$field[35]";}else{$Package{$Disty}{$PN} = '';}
                $Vgemax{$Disty}{$PN} = '';
                $Power{$Disty}{$PN} = '';
                if(defined $field[29]){ $Qg{$Disty}{$PN} = "$field[29]";}else{$Qg{$Disty}{$PN} = '';}

            }elsif($Disty eq 'MS'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[7]){ $field[7] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[7]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[19]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[19]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[18]){ &subStock("$field[18]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[11]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[11]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[13]){ $Description{$Disty}{$PN} = "$field[13]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[29]){ $Vce{$Disty}{$PN} = "$field[29]";}else{$Vce{$Disty}{$PN} = '';}
                if(defined $field[32]){ $Current{$Disty}{$PN} = "$field[32]";}else{$Current{$Disty}{$PN} = '';}
                if(defined $field[34] && defined $field[35]){ $OpTemp{$Disty}{$PN} = "$field[34]" . " - " . "$field[35]";}else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[27]){ $Mounting{$Disty}{$PN} = "$field[27]";}else{$Mounting{$Disty}{$PN} = '';}
                if(defined $field[26]){ $Package{$Disty}{$PN} = "$field[26]";}else{$Package{$Disty}{$PN} = '';}
                if(defined $field[31]){ $Vgemax{$Disty}{$PN} = "$field[31]";}else{$Vgemax{$Disty}{$PN} = '';}
                if(defined $field[33]){ $Power{$Disty}{$PN} = "$field[33]";}else{$Power{$Disty}{$PN} = '';}
                $Qg{$Disty}{$PN} = '';
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }
        #23
        }when('Thermal'){
            if($Disty eq 'DK'){
                #----------- 
                # Thermal specific Notes. Don't consider 'minimum quantity' due to missing minimum quantity field in raw data
                #----------- 
                #if ($field[12] =~/Digi-Reel/){next;}
                if (&subStatus("$field[16]") eq "1"){next;}

                if(defined $field[8] && $field[8] ne ''){ &subPN("$field[8]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[10]){ $MPN{$Disty}{$PN} = "$field[10]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[16]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[16]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[15]){ &subStock("$field[15]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[13]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[13]", $file);}else{$MOQ{$Disty}{$PN} = '';}
                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[17]){ $Series{$Disty}{$PN} = "$field[17]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[20]){ $Usage{$Disty}{$PN} = "$field[20]";}else{$Usage{$Disty}{$PN} = '';}
                $Type{$Disty}{$PN} = '';
                if(defined $field[21]){ $Shape{$Disty}{$PN} = "$field[21]";}else{$Shape{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Outline{$Disty}{$PN} = "$field[22]";}else{$Outline{$Disty}{$PN} = '';}
                if(defined $field[23]){ $Thickness{$Disty}{$PN} = "$field[23]";}else{$Thickness{$Disty}{$PN} = '';}
                if(defined $field[24]){ $Material{$Disty}{$PN} = "$field[24]";}else{$Material{$Disty}{$PN} = '';}
                if(defined $field[25]){ $Adhesive{$Disty}{$PN} = "$field[25]";}else{$Adhesive{$Disty}{$PN} = '';}
                if(defined $field[26]){ $BackingCarrier{$Disty}{$PN} = "$field[26]";}else{$BackingCarrier{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Color{$Disty}{$PN} = "$field[27]";}else{$Color{$Disty}{$PN} = '';}
                if(defined $field[28]){ $ThermalResistivity{$Disty}{$PN} = "$field[28]";}else{$ThermalResistivity{$Disty}{$PN} = '';}
                if(defined $field[29]){ $ThermalConductivity{$Disty}{$PN} = "$field[29]";}else{$ThermalConductivity{$Disty}{$PN} = '';}

            }elsif($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[7]){ $field[7] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[7]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[20]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[20]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[19]){ &subStock("$field[19]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Series{$Disty}{$PN} = "$field[30]";}else{$Series{$Disty}{$PN} = '';}
                $Usage{$Disty}{$PN} = '';
                if(defined $field[25]){ $Type{$Disty}{$PN} = "$field[25]";}else{$Type{$Disty}{$PN} = '';}
                $Shape{$Disty}{$PN} = '';
                if(defined $field[27] && defined $field[28]){ $Outline{$Disty}{$PN} = "$field[27]" . " - " . "$field[28]";}else{$Outline{$Disty}{$PN} = ''; }
                if(defined $field[29]){ $Thickness{$Disty}{$PN} = "$field[29]";}else{$Thickness{$Disty}{$PN} = '';}
                if(defined $field[26]){ $Material{$Disty}{$PN} = "$field[26]";}else{$Material{$Disty}{$PN} = '';}
                $Adhesive{$Disty}{$PN} = '';
                $BackingCarrier{$Disty}{$PN} = '';
                $Color{$Disty}{$PN} = '';
                $ThermalResistivity{$Disty}{$PN} = '';
                $ThermalConductivity{$Disty}{$PN} = '';
	      }else{
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[4]){ $field[4] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[4]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[7]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[7]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[9]){ $Description{$Disty}{$PN} = "$field[9]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Series{$Disty}{$PN} = "$field[22]";}else{$Series{$Disty}{$PN} = '';}
                $Usage{$Disty}{$PN} = '';
                if(defined $field[17]){ $Type{$Disty}{$PN} = "$field[17]";}else{$Type{$Disty}{$PN} = '';}
                $Shape{$Disty}{$PN} = '';
                if(defined $field[19] && defined $field[20]){ $Outline{$Disty}{$PN} = "$field[19]" . " - " . "$field[20]";}else{$Outline{$Disty}{$PN} = ''; }
                if(defined $field[21]){ $Thickness{$Disty}{$PN} = "$field[21]";}else{$Thickness{$Disty}{$PN} = '';}
                if(defined $field[18]){ $Material{$Disty}{$PN} = "$field[18]";}else{$Material{$Disty}{$PN} = '';}
                $Adhesive{$Disty}{$PN} = '';
                $BackingCarrier{$Disty}{$PN} = '';
                $Color{$Disty}{$PN} = '';
                $ThermalResistivity{$Disty}{$PN} = '';
                $ThermalConductivity{$Disty}{$PN} = '';
	      }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }
        #24
        }when('SSD'){
            if($Disty eq 'DK'){
                #NOTE. Neglect line in case 1)"Minimum Quantity" is not. 1 2)Digi-Reel package
                #if ($field[16] =~/Digi-Reel/){next;}
                if (&subStatus("$field[18]") eq "1"){next;}

                if(defined $field[8] && $field[8] ne ''){ &subPN("$field[8]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[10]){ $MPN{$Disty}{$PN} = "$field[10]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[16]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[16]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[15]){ &subStock("$field[15]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[17]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[17]", $file);}else{$MOQ{$Disty}{$PN} = '';}
                if(defined $field[21]){ $MemorySize{$Disty}{$PN} = "$field[21]";}else{$MemorySize{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Type1{$Disty}{$PN} = "$field[22]";}else{$Type1{$Disty}{$PN} = '';}
                if(defined $field[23]){ $Type2{$Disty}{$PN} = "$field[23]";}else{$Type1{$Disty}{$PN} = '';}
		$OpTemp{$Disty}{$PN} = '';
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            } 
        #25
        }when('PMIC_Switch_Control_PENDING'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[12]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[1]){ $ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[7]){ $PNLink{$Disty}{$PN} = "$field[7]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[13]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[13]", $file);}else{$MOQ{$Disty}{$PN} = '';}
                if(defined $field[17]){ $Series1{$Disty}{$PN} = "$field[17]";}else{$Series1{$Disty}{$PN} = '';}
                if(defined $field[18]){ $Series2{$Disty}{$PN} = "$field[18]";}else{$Series2{$Disty}{$PN} = '';}
                if(defined $field[21]){ $Function{$Disty}{$PN} = "$field[21]";}else{$Function{$Disty}{$PN} = '';}
                if(defined $field[23]){ $Topology{$Disty}{$PN} = "$field[23]";}else{$Topology{$Disty}{$PN} = '';}
                if(defined $field[24]){ $OutputCount{$Disty}{$PN} = "$field[24]";}else{$OutputCount{$Disty}{$PN} = '';}
                if(defined $field[25]){ $PhaseCount{$Disty}{$PN} = "$field[25]";}else{$PhaseCount{$Disty}{$PN} = '';}
                if(defined $field[26]){ $Vin{$Disty}{$PN} = "$field[26]";}else{$Vin{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Swf{$Disty}{$PN} = "$field[27]";}else{$Swf{$Disty}{$PN} = '';}
                if(defined $field[29]){ $Synchronous{$Disty}{$PN} = "$field[29]";}else{$Synchronous{$Disty}{$PN} = '';}
                if(defined $field[32]){ $Control{$Disty}{$PN} = "$field[32]";}else{$Control{$Disty}{$PN} = '';}
                if(defined $field[33]){ $OpTemp{$Disty}{$PN} = "$field[33]";}else{$OpTemp{$Disty}{$PN} = '';}
                if(defined $field[34]){ $Package{$Disty}{$PN} = "$field[34]";}else{$Package{$Disty}{$PN} = '';}
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }
        #25
        }when('PMIC_Switch_Regulator_PENDING'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[12]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[1]){ $ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[7]){ $PNLink{$Disty}{$PN} = "$field[7]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[13]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[13]", $file);}else{$MOQ{$Disty}{$PN} = '';}
                if(defined $field[17]){ $Series1{$Disty}{$PN} = "$field[17]";}else{$Series1{$Disty}{$PN} = '';}
                if(defined $field[18]){ $Series2{$Disty}{$PN} = "$field[18]";}else{$Series2{$Disty}{$PN} = '';}
                if(defined $field[20]){ $Function{$Disty}{$PN} = "$field[20]";}else{$Function{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Topology{$Disty}{$PN} = "$field[22]";}else{$Topology{$Disty}{$PN} = '';}
                if(defined $field[24]){ $OutputCount{$Disty}{$PN} = "$field[24]";}else{$OutputCount{$Disty}{$PN} = '';}
                if(defined $field[25] && defined $field[26]){ $Vin{$Disty}{$PN} = "$field[25]" . " - " . "$field[26]";}else{$Vin{$Disty}{$PN} = '';}
                if(defined $field[27] && defined $field[28]){ $Vout{$Disty}{$PN} = "$field[27]" . " - " . "$field[28]";}else{$Vout{$Disty}{$PN} = '';}
                if(defined $field[29]){ $Iout{$Disty}{$PN} = "$field[29]";}else{$Iout{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Swf{$Disty}{$PN} = "$field[30]";}else{$Swf{$Disty}{$PN} = '';}
                if(defined $field[31]){ $Synchronous{$Disty}{$PN} = "$field[31]";}else{$Synchronous{$Disty}{$PN} = '';}
                if(defined $field[32]){ $OpTemp{$Disty}{$PN} = "$field[32]";}else{$OpTemp{$Disty}{$PN} = '';}
                if(defined $field[33]){ $Package{$Disty}{$PN} = "$field[33]";}else{$Package{$Disty}{$PN} = '';}
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }
        #26
        }when('MLCC'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[12]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[13]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[13]",$file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[17]){ $Series{$Disty}{$PN} = "$field[17]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[20]){ $Capacitance{$Disty}{$PN} = &subCap("$field[20]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[21]){ $Tolerance{$Disty}{$PN} = "$field[21]";}else{$Tolerance{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Voltage{$Disty}{$PN} = &subVol("$field[22]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                if(defined $field[23]){ $Temperature_Coefficient{$Disty}{$PN} = "$field[23]";}else{$Temperature_Coefficient{$Disty}{$PN} = '';}
                if(defined $field[24]){ $OpTemp{$Disty}{$PN} = "$field[24]";}else{$OpTemp{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Application{$Disty}{$PN} = "$field[27]";}else{$Application{$Disty}{$PN} = '';}
                $Mounting{$Disty}{$PN} = "SMD";
                if(defined $field[28]){ $Package{$Disty}{$PN} = "$field[28]";}else{$Package{$Disty}{$PN} = '';}
                if(defined $field[29]){ $Size{$Disty}{$PN} = "$field[29]";}else{$Size{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Thickness{$Disty}{$PN} = "$field[30]";}else{$Thickness{$Disty}{$PN} = '';}
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }
        #27
        }when('DCDC_Converters_PENDING'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[12]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[1]){ $ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[7]){ $PNLink{$Disty}{$PN} = "$field[7]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[13]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[13]", $file);}else{$MOQ{$Disty}{$PN} = '';}
                if(defined $field[17]){ $Series1{$Disty}{$PN} = "$field[17]";}else{$Series1{$Disty}{$PN} = '';}
                if(defined $field[18]){ $Series2{$Disty}{$PN} = "$field[18]";}else{$Series2{$Disty}{$PN} = '';}
                if(defined $field[21]){ $Type{$Disty}{$PN} = "$field[21]";}else{$Type{$Disty}{$PN} = '';}
                if(defined $field[22]){ $OutputCount{$Disty}{$PN} = "$field[22]";}else{$OutputCount{$Disty}{$PN} = '';}
                if(defined $field[23] && defined $field[24]){ $Vin{$Disty}{$PN} = "$field[23]" . " - " . "$field[24]";}else{$Vin{$Disty}{$PN} = '';}
                if(defined $field[25]){ $Vout{$Disty}{$PN} = "$field[25]";}else{$Vout{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Iout{$Disty}{$PN} = "$field[27]";}else{$Iout{$Disty}{$PN} = '';}
                if(defined $field[28]){ $Power{$Disty}{$PN} = "$field[28]";}else{$Power{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Application{$Disty}{$PN} = "$field[30]";}else{$Application{$Disty}{$PN} = '';}
                if(defined $field[32]){ $OpTemp{$Disty}{$PN} = "$field[32]";}else{$OpTemp{$Disty}{$PN} = '';}
                if(defined $field[33]){ $Efficiency{$Disty}{$PN} = "$field[33]";}else{$Efficiency{$Disty}{$PN} = '';}
                if(defined $field[34]){ $Mounting{$Disty}{$PN} = "$field[34]";}else{$Mounting{$Disty}{$PN} = '';}
                if(defined $field[35]){ $Package{$Disty}{$PN} = "$field[35]";}else{$Package{$Disty}{$PN} = '';}
                if(defined $field[36]){ $Size{$Disty}{$PN} = "$field[36]";}else{$Size{$Disty}{$PN} = '';}
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }
        #28
        }when('EDLC'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[16]") eq "1"){next;}

                if(defined $field[8] && $field[8] ne ''){ &subPN("$field[8]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[10] && $field[10] ne ''){ &subMPN("$field[10]" ,$file);
                }else{ print "\[WARNING\]: Missing MPN, line $lc of $file\n"; next; }
                if(defined $field[10]){ $MPN{$Disty}{$PN} = "$field[10]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[16]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[16]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[15]){ &subStock("$field[15]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[17]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[17]", $file);}else{$MOQ{$Disty}{$PN} = '';}
                if(defined $field[19]){ $Series{$Disty}{$PN} = "$field[19]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Capacitance{$Disty}{$PN} = &subCap("$field[22]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[23]){ $Tolerance{$Disty}{$PN} = "$field[23]";}else{$Tolerance{$Disty}{$PN} = '';}
                if(defined $field[24]){ $Voltage{$Disty}{$PN} = &subVol("$field[24]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                if(defined $field[25]){ $Esr{$Disty}{$PN} = &subRes("$field[25]", $file); }else{$Esr{$Disty}{$PN} = ''; }
                if(defined $field[26]){ $Life{$Disty}{$PN} = "$field[26]";}else{$Life{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Package{$Disty}{$PN} = "$field[27]";}else{$Package{$Disty}{$PN} = '';}
                if(defined $field[31]){ $OpTemp{$Disty}{$PN} = "$field[31]";}else{$OpTemp{$Disty}{$PN} = '';}
                if(defined $field[29]){ $Size{$Disty}{$PN} = "$field[29]";}else{$Size{$Disty}{$PN} = '';}
                if(defined $field[28]){ $LeadSpacing{$Disty}{$PN} = "$field[28]";}else{$LeadSpacing{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Length{$Disty}{$PN} = substr("$field[30]",index($field[30],"(")+1,length($field[30])-index($field[30],"(")-2); $Length{$Disty}{$PN} =~ s/mm/E-3/;}else{$Length{$Disty}{$PN} = '';}
                $Diameter2{$Disty}{$PN} = "";
                if(defined $field[29]){
		    if($field[29] =~/Dia x/){
		        $Type{$Disty}{$PN} = "Cell";
                        $Width{$Disty}{$PN} = substr("$field[29]",index($field[29],"(")+1,rindex($field[29]," x ")-index($field[29],"(")); $Width{$Disty}{$PN} =~ s/mm/E-3/;
                        $Length{$Disty}{$PN} = $Width{$Disty}{$PN};
                        $Diameter{$Disty}{$PN} = substr("$field[29]",rindex($field[29]," x ")+3,length($field[29])-rindex($field[29]," x ")-4); $Diameter{$Disty}{$PN} =~ s/mm/E-3/;
                        $Volume{$Disty}{$PN} = $Length{$Disty}{$PN} * $Width{$Disty}{$PN} * $Diameter{$Disty}{$PN};
		    }elsif($field[29] !~/ x /){
		        $Type{$Disty}{$PN} = "Cell";
                        $Width{$Disty}{$PN} = substr("$field[29]",index($field[29],"(")+1,length($field[29])-index($field[29],"(")-2); $Width{$Disty}{$PN} =~ s/mm/E-3/;
                        $Diameter{$Disty}{$PN} = $Width{$Disty}{$PN};
                        $Volume{$Disty}{$PN} = $Length{$Disty}{$PN} * $Width{$Disty}{$PN} * $Diameter{$Disty}{$PN};
		    }elsif($field[29] =~/L x/){
		        $Type{$Disty}{$PN} = "Module";
                        $Width{$Disty}{$PN} = substr("$field[29]",index($field[29],"(")+1,rindex($field[29]," x ")-index($field[29],"(")); $Width{$Disty}{$PN} =~ s/mm/E-3/;
                        $Diameter{$Disty}{$PN} = substr("$field[29]",rindex($field[29]," x ")+3,length($field[29])-rindex($field[29]," x ")-4); $Diameter{$Disty}{$PN} =~ s/mm/E-3/;
                        $Volume{$Disty}{$PN} = $Length{$Disty}{$PN} * $Width{$Disty}{$PN} * $Diameter{$Disty}{$PN};
		    }else{
		        $Type{$Disty}{$PN} = "";
                        $Width{$Disty}{$PN} = "";
                        $Diameter{$Disty}{$PN} = "";
                        $Volume{$Disty}{$PN} = "";
		    }
		}else{
		    $Type{$Disty}{$PN} = "";
                    $Width{$Disty}{$PN} = "";
                    $Diameter{$Disty}{$PN} = "";
                    $Volume{$Disty}{$PN} = "";
		}

            }elsif($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[7] && $field[7] ne ''){  $field[7] =~ s/; [a-z]*//; &subMPN("$field[7]" ,$file);
                }else{ print "\[WARNING\]: Missing MPN, line $lc of $file\n"; next; }
                if(defined $field[7]){ $field[7] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[7]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[22]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[22]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[19]){ &subStock("$field[19]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                $Series{$Disty}{$PN} = "";
                if(defined $field[38]){ $Capacitance{$Disty}{$PN} = &subCap("$field[38]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[40]){ $Tolerance{$Disty}{$PN} = "$field[40]";}else{$Tolerance{$Disty}{$PN} = '';}
                if(defined $field[39]){ $Voltage{$Disty}{$PN} = &subVol("$field[39]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                if(defined $field[41]){ $Esr{$Disty}{$PN} = &subRes("$field[41]", $file); }else{$Esr{$Disty}{$PN} = ''; }
                $Life{$Disty}{$PN} = "";
                if(defined $field[37]){ $Package{$Disty}{$PN} = "$field[37]";}else{$Package{$Disty}{$PN} = '';}
                if(defined $field[42]){ $OpTemp{$Disty}{$PN} = "$field[42]";}else{$OpTemp{$Disty}{$PN} = '';}
                $Size{$Disty}{$PN} = "";
                $LeadSpacing{$Disty}{$PN} = "";
                if(defined $field[45]){ $Length{$Disty}{$PN} = "$field[45]";}else{$Length{$Disty}{$PN} = '';}
                if(defined $field[43]){ $Width{$Disty}{$PN} = "$field[43]";}else{$Width{$Disty}{$PN} = '';}
                if(defined $field[44]){ $Diameter2{$Disty}{$PN} = "$field[44]";}else{$Diameter2{$Disty}{$PN} = '';}
                if(defined $field[46]){ $Diameter{$Disty}{$PN} = "$field[46]";}else{$Diameter{$Disty}{$PN} = '';}
                $Type{$Disty}{$PN} = "";
                $Volume{$Disty}{$PN} = "";
	      }else{
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[4] && $field[4] ne ''){  $field[4] =~ s/; [a-z]*//; &subMPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing MPN, line $lc of $file\n"; next; }
                if(defined $field[4]){ $field[4] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[4]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[7]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[7]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                $Series{$Disty}{$PN} = "";
                if(defined $field[18]){ $Capacitance{$Disty}{$PN} = &subCap("$field[18]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[20]){ $Tolerance{$Disty}{$PN} = "$field[20]";}else{$Tolerance{$Disty}{$PN} = '';}
                if(defined $field[19]){ $Voltage{$Disty}{$PN} = &subVol("$field[19]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                if(defined $field[21]){ $Esr{$Disty}{$PN} = &subRes("$field[21]", $file); }else{$Esr{$Disty}{$PN} = ''; }
                $Life{$Disty}{$PN} = "";
                if(defined $field[17]){ $Package{$Disty}{$PN} = "$field[17]";}else{$Package{$Disty}{$PN} = '';}
                if(defined $field[22]){ $OpTemp{$Disty}{$PN} = "$field[22]" . " to " . "$field[23]";}else{$OpTemp{$Disty}{$PN} = '';}
                $Size{$Disty}{$PN} = "";
                $LeadSpacing{$Disty}{$PN} = "";
                if(defined $field[26]){ $Length{$Disty}{$PN} = "$field[26]";}else{$Length{$Disty}{$PN} = '';}
                if(defined $field[24]){ $Width{$Disty}{$PN} = "$field[24]";}else{$Width{$Disty}{$PN} = '';}
                if(defined $field[25]){ $Diameter2{$Disty}{$PN} = "$field[25]";}else{$Diameter2{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Diameter{$Disty}{$PN} = "$field[27]";}else{$Diameter{$Disty}{$PN} = '';}
                $Type{$Disty}{$PN} = "";
                $Volume{$Disty}{$PN} = "";
              }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }

                if(! defined $Supplier{$Disty}{$MPN}){$Supplier{$Disty}{$MPN} = "$Supplier{$Disty}{$PN}";}
                if(! defined $Series{$Disty}{$MPN}){$Series{$Disty}{$MPN} = "$Series{$Disty}{$PN}";}
                if(! defined $Capacitance{$Disty}{$MPN}){$Capacitance{$Disty}{$MPN} = "$Capacitance{$Disty}{$PN}";}
                if(! defined $Tolerance{$Disty}{$MPN}){$Tolerance{$Disty}{$MPN} = "$Tolerance{$Disty}{$PN}";}
                if(! defined $Voltage{$Disty}{$MPN}){$Voltage{$Disty}{$MPN} = "$Voltage{$Disty}{$PN}";}
                if(! defined $Esr{$Disty}{$MPN}){$Esr{$Disty}{$MPN} = "$Esr{$Disty}{$PN}";}
                if(! defined $Life{$Disty}{$MPN}){$Life{$Disty}{$MPN} = "$Life{$Disty}{$PN}";}
                if(! defined $Package{$Disty}{$MPN}){$Package{$Disty}{$MPN} = "$Package{$Disty}{$PN}";}
                if(! defined $OpTemp{$Disty}{$MPN}){$OpTemp{$Disty}{$MPN} = "$OpTemp{$Disty}{$PN}";}
                if(! defined $Size{$Disty}{$MPN}){$Size{$Disty}{$MPN} = "$Size{$Disty}{$PN}";}
                if(! defined $LeadSpacing{$Disty}{$MPN}){$LeadSpacing{$Disty}{$MPN} = "$LeadSpacing{$Disty}{$PN}";}
                if(! defined $Length{$Disty}{$MPN}){$Length{$Disty}{$MPN} = "$Length{$Disty}{$PN}";}
                if(! defined $Width{$Disty}{$MPN}){$Width{$Disty}{$MPN} = "$Width{$Disty}{$PN}";}
                if(! defined $Diameter2{$Disty}{$MPN}){$Diameter2{$Disty}{$MPN} = "$Diameter2{$Disty}{$PN}";}
                if(! defined $Diameter{$Disty}{$MPN}){$Diameter{$Disty}{$MPN} = "$Diameter{$Disty}{$PN}";}
                if(! defined $Type{$Disty}{$MPN}){$Type{$Disty}{$MPN} = "$Type{$Disty}{$PN}";}
                if(! defined $Volume{$Disty}{$MPN}){$Volume{$Disty}{$MPN} = "$Volume{$Disty}{$PN}";}

        #30
        }when('RF_Relay'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[19]") eq "1"){next;}

                if(defined $field[7] && $field[7] ne ''){ &subPN("$field[7]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[11]){ $MPN{$Disty}{$PN} = "$field[11]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[19]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[19]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[16]){ &subStock("$field[16]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[13]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[13]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[15]){ $Description{$Disty}{$PN} = "$field[15]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[20]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[20]", $file);}else{$MOQ{$Disty}{$PN} = '';}
                if(defined $field[24]){ $Series{$Disty}{$PN} = "$field[24]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[27]){ $CoilType{$Disty}{$PN} = "$field[27]"; }else{$CoilType{$Disty}{$PN} = ''; }
                if(defined $field[28]){ $CoilCurrent{$Disty}{$PN} = &subCur("$field[28]", $file); }else{$CoilCurrent{$Disty}{$PN} = ''; }
                if(defined $field[29]){ $CoilVoltage{$Disty}{$PN} = &subVol("$field[29]", $file); }else{$CoilVoltage{$Disty}{$PN} = ''; }
                if(defined $field[30]){ $ContactForm{$Disty}{$PN} = "$field[30]"; }else{$ContactForm{$Disty}{$PN} = ''; }
                if(defined $field[31]){ $ContactRating{$Disty}{$PN} = &subCur("$field[31]", $file); }else{$ContactRating{$Disty}{$PN} = ''; }
                if(defined $field[32]){ $SwitchingVoltage{$Disty}{$PN} = "$field[32]"; }else{$SwitchingVoltage{$Disty}{$PN} = ''; }
                if(defined $field[33]){ $TurnOnVoltage{$Disty}{$PN} = &subVol("$field[33]", $file); }else{$TurnOnVoltage{$Disty}{$PN} = ''; }
                if(defined $field[34]){ $TurnOffVoltage{$Disty}{$PN} = &subVol("$field[34]", $file); }else{$TurnOffVoltage{$Disty}{$PN} = ''; }
                if(defined $field[35]){ $OperateTime{$Disty}{$PN} = "$field[35]"; }else{$OperateTime{$Disty}{$PN} = ''; }
                if(defined $field[36]){ $ReleaseTime{$Disty}{$PN} = "$field[36]"; }else{$ReleaseTime{$Disty}{$PN} = ''; }
                if(defined $field[37]){ $Features{$Disty}{$PN} = "$field[37]"; }else{$Features{$Disty}{$PN} = ''; }
                if(defined $field[38]){ $Mounting{$Disty}{$PN} = "$field[38]"; }else{$Mounting{$Disty}{$PN} = ''; }
                if(defined $field[39]){ $Term{$Disty}{$PN} = "$field[39]"; }else{$Term{$Disty}{$PN} = ''; }
                if(defined $field[40]){ $OpTemp{$Disty}{$PN} = "$field[40]"; }else{$OpTemp{$Disty}{$PN} = ''; }
                $Frequency{$Disty}{$PN} = "";
                $Power{$Disty}{$PN} = "";

            }elsif($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[8]){ $field[8] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[8]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[22]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[22]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[19]){ &subStock("$field[19]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[39]){ $Series{$Disty}{$PN} = "$field[39]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[35]){ $CoilType{$Disty}{$PN} = "$field[35]"; }else{$CoilType{$Disty}{$PN} = ''; }
                $CoilCurrent{$Disty}{$PN} = "";
                if(defined $field[30]){ $CoilVoltage{$Disty}{$PN} = &subVol("$field[30]", $file); }else{$CoilVoltage{$Disty}{$PN} = ''; }
                if(defined $field[31]){ $ContactForm{$Disty}{$PN} = "$field[31]"; }else{$ContactForm{$Disty}{$PN} = ''; }
                if(defined $field[32]){ $ContactRating{$Disty}{$PN} = &subCur("$field[32]", $file); }else{$ContactRating{$Disty}{$PN} = ''; }
                $SwitchingVoltage{$Disty}{$PN} = "";
                $TurnOnVoltage{$Disty}{$PN} = "";
                $TurnOffVoltage{$Disty}{$PN} = "";
                $OperateTime{$Disty}{$PN} = "";
                $ReleaseTime{$Disty}{$PN} = "";
                $Features{$Disty}{$PN} = "";
                $Mounting{$Disty}{$PN} = "";
                if(defined $field[34]){ $Term{$Disty}{$PN} = "$field[34]"; }else{$Term{$Disty}{$PN} = ''; }
                $OpTemp{$Disty}{$PN} = "";
                if(defined $field[33]){ $Frequency{$Disty}{$PN} = "$field[33]"; }else{$Frequency{$Disty}{$PN} = ''; }
                if(defined $field[36]){ $Power{$Disty}{$PN} = "$field[36]"; }else{$Power{$Disty}{$PN} = ''; }
	      }else{
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[4]){ $field[4] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[4]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[7]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[7]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[9]){ $Description{$Disty}{$PN} = "$field[9]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Series{$Disty}{$PN} = "$field[27]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[23]){ $CoilType{$Disty}{$PN} = "$field[23]"; }else{$CoilType{$Disty}{$PN} = ''; }
                $CoilCurrent{$Disty}{$PN} = "";
                if(defined $field[17]){ $CoilVoltage{$Disty}{$PN} = &subVol("$field[17]", $file); }else{$CoilVoltage{$Disty}{$PN} = ''; }
                if(defined $field[18]){ $ContactForm{$Disty}{$PN} = "$field[18]"; }else{$ContactForm{$Disty}{$PN} = ''; }
                if(defined $field[19]){ $ContactRating{$Disty}{$PN} = &subCur("$field[19]", $file); }else{$ContactRating{$Disty}{$PN} = ''; }
                $SwitchingVoltage{$Disty}{$PN} = "";
                $TurnOnVoltage{$Disty}{$PN} = "";
                $TurnOffVoltage{$Disty}{$PN} = "";
                $OperateTime{$Disty}{$PN} = "";
                $ReleaseTime{$Disty}{$PN} = "";
                $Features{$Disty}{$PN} = "";
                $Mounting{$Disty}{$PN} = "";
                if(defined $field[21]){ $Term{$Disty}{$PN} = "$field[21]"; }else{$Term{$Disty}{$PN} = ''; }
                $OpTemp{$Disty}{$PN} = "";
                if(defined $field[33]){ $Frequency{$Disty}{$PN} = "$field[33]"; }else{$Frequency{$Disty}{$PN} = ''; }
                if(defined $field[24]){ $Power{$Disty}{$PN} = "$field[24]"; }else{$Power{$Disty}{$PN} = ''; }
	      }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }

        #31
        }when ('Power_Relay'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[16]") eq "1"){next;}

                if(defined $field[8] && $field[8] ne ''){ &subPN("$field[8]" ,$file); &subPN_daily("$field[8]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[10]){ $MPN{$Disty}{$PN} = "$field[10]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[16]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[16]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[15]){ &subStock("$field[15]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[17]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[17]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[5]){ $ImageLink{$Disty}{$PN} = "$field[5]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[9]){ $PNLink{$Disty}{$PN} = "$field[9]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[19]){ $Series{$Disty}{$PN} = "$field[19]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[21]){ $RelayType{$Disty}{$PN} = "$field[21]";}else{$RelayType{$Disty}{$PN} = '';}
                if(defined $field[22]){ $field[22] =~ s/-//;  $field[22] =~ s/Latching Dual Coil/Dual Coil Latching/;  $field[22] =~ s/Latching Single Coil/Latching/;  $field[22] =~ s/Non Latching/Non-Latching/; $CoilType{$Disty}{$PN} = "$field[22]";}else{$CoilType{$Disty}{$PN} = '';}
                if(defined $field[23]){ $CoilCurrent{$Disty}{$PN} = &subCur("$field[23]", $file);}else{$CoilCurrent{$Disty}{$PN} = '';}
                if(defined $field[24]){
                    if($field[24] =~/VAC\/DC/){
		        $field[24] =~ s/VAC\/DC//;
		        $CoilVoltageAC{$Disty}{$PN} = "$field[24]";
		        $CoilVoltageDC{$Disty}{$PN} = "$field[24]";
                    }elsif($field[24] =~/VAC/){
		        $field[24] =~ s/VAC//;
		        $CoilVoltageAC{$Disty}{$PN} = "$field[24]";
		        $CoilVoltageDC{$Disty}{$PN} = '';
                    }elsif($field[24] =~/VDC/){
		        $field[24] =~ s/VDC//;
		        $CoilVoltageAC{$Disty}{$PN} = '';
		        $CoilVoltageDC{$Disty}{$PN} = "$field[24]";
                    }else{
		        $CoilVoltageAC{$Disty}{$PN} = '';
		        $CoilVoltageDC{$Disty}{$PN} = '';
		    }
		}else{ $CoilVoltageAC{$Disty}{$PN} = ''; $CoilVoltageDC{$Disty}{$PN} = '';}
                if(defined $field[25]){ $ContactForm{$Disty}{$PN} = "$field[25]";}else{$ContactForm{$Disty}{$PN} = '';}
                if(defined $field[26]){ $ContactRating{$Disty}{$PN} = &subCur("$field[26]", $file);}else{$ContactRating{$Disty}{$PN} = '';}
                if(defined $field[27]){ $SwitchingVoltage{$Disty}{$PN} = "$field[27]";}else{$SwitchingVoltage{$Disty}{$PN} = '';}
                if(defined $field[28]){ $TurnOnVoltage{$Disty}{$PN} = "$field[28]";}else{$TurnOnVoltage{$Disty}{$PN} = '';}
                if(defined $field[29]){ $TurnOffVoltage{$Disty}{$PN} = "$field[29]";}else{$TurnOffVoltage{$Disty}{$PN} = '';}
                if(defined $field[30]){ $OperateTime{$Disty}{$PN} = "$field[30]";}else{$OperateTime{$Disty}{$PN} = '';}
                if(defined $field[31]){ $ReleaseTime{$Disty}{$PN} = "$field[31]";}else{$ReleaseTime{$Disty}{$PN} = '';}
                if(defined $field[32]){ $Features{$Disty}{$PN} = "$field[32]";}else{$Features{$Disty}{$PN} = '';}
                if(defined $field[33]){ $Mounting{$Disty}{$PN} = "$field[33]";}else{$Mounting{$Disty}{$PN} = '';}
                if(defined $field[34]){ $Termination{$Disty}{$PN} = "$field[34]";}else{$Termination{$Disty}{$PN} = '';}
                if(defined $field[35]){ 
		    $OpTemp{$Disty}{$PN} = &subOptemp("$field[35]", $file); my @subfield = split(/~/,$OpTemp{$Disty}{$PN}); $OpTempL{$Disty}{$PN} = $subfield[0]; $OpTempH{$Disty}{$PN} = $subfield[1];
		}else{
		    $OpTemp{$Disty}{$PN} = ''; $OpTempL{$Disty}{$PN} = ''; $OpTempH{$Disty}{$PN} = '';
                }
		$Length{$Disty}{$PN} = '';
		$Width{$Disty}{$PN} = '';
		$Height{$Disty}{$PN} = '';
            }elsif($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[7]){ $field[7] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[7]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[22]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[22]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[19]){ &subStock("$field[19]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[22]){ $field[22] =~ s/:.*//; $field[22] =~ s/Cut Tape  Cut Tape; //; $MOQ{$Disty}{$PN} = "$field[22]";}else{$MOQ{$Disty}{$PN} = '';}

                $ImageLink{$Disty}{$PN} = '';
		$PNLink{$Disty}{$PN} = '';
		$Description{$Disty}{$PN} = '';
		$Series{$Disty}{$PN} = '';
		$RelayType{$Disty}{$PN} = '';
		$CoilType{$Disty}{$PN} = '';
		$CoilCurrent{$Disty}{$PN} = '';
		$CoilVoltageAC{$Disty}{$PN} = '';
		$CoilVoltageDC{$Disty}{$PN} = '';
		$ContactForm{$Disty}{$PN} = '';
		$ContactRating{$Disty}{$PN} = '';
		$SwitchingVoltage{$Disty}{$PN} = '';
                $TurnOnVoltage{$Disty}{$PN} = '';
                $TurnOffVoltage{$Disty}{$PN} = '';
                $OperateTime{$Disty}{$PN} = '';
                $ReleaseTime{$Disty}{$PN} = '';
		$Features{$Disty}{$PN} = '';
		$Mounting{$Disty}{$PN} = '';
		$Termination{$Disty}{$PN} = '';
		$OpTemp{$Disty}{$PN} = ''; $OpTempL{$Disty}{$PN} = ''; $OpTempH{$Disty}{$PN} = '';
		$Length{$Disty}{$PN} = '';
		$Width{$Disty}{$PN} = '';
		$Height{$Disty}{$PN} = '';
	      }else{
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[4]){ $field[4] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[4]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[7]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[7]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[14]){ $field[14] =~ s/ Mult.*//; $field[14] =~ s/Min.: //; $field[14] =~ s/-//; $MOQ{$Disty}{$PN} = "$field[14]";}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[1]){ $ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[5]){ $PNLink{$Disty}{$PN} = "$field[5]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[9]){ $Description{$Disty}{$PN} = "$field[9]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Series{$Disty}{$PN} = "$field[30]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[17]){ $RelayType{$Disty}{$PN} = "$field[17]";}else{$RelayType{$Disty}{$PN} = '';}
                if(defined $field[26]){ $CoilType{$Disty}{$PN} = "$field[26]";}else{$CoilType{$Disty}{$PN} = '';}
                if(defined $field[28]){ $CoilCurrent{$Disty}{$PN} = &subCur("$field[28]", $file);}else{$CoilCurrent{$Disty}{$PN} = '';}
                if(defined $field[19]){
		    $field[19] =~ s/^.*to //;
                    if($field[19] =~/VAC/){
		        $field[19] =~ s/VAC//;
		        $CoilVoltageAC{$Disty}{$PN} = "$field[19]";
		        $CoilVoltageDC{$Disty}{$PN} = '';
                    }elsif($field[19] =~/VDC/ || $field[19] =~/V/){
		        $field[19] =~ s/VDC//; $field[19] =~ s/V//;
		        $CoilVoltageAC{$Disty}{$PN} = '';
		        $CoilVoltageDC{$Disty}{$PN} = "$field[19]";
                    }else{
		        $CoilVoltageAC{$Disty}{$PN} = '';
		        $CoilVoltageDC{$Disty}{$PN} = '';
		    }
		}else{ $CoilVoltageAC{$Disty}{$PN} = ''; $CoilVoltageDC{$Disty}{$PN} = '';}
                if(defined $field[20]){ $ContactForm{$Disty}{$PN} = "$field[20]";}else{$ContactForm{$Disty}{$PN} = '';}
                if(defined $field[21]){ $ContactRating{$Disty}{$PN} = &subCur("$field[21]", $file);}else{$ContactRating{$Disty}{$PN} = '';}
                if(defined $field[24]){ $SwitchingVoltage{$Disty}{$PN} = "$field[24]";}else{$SwitchingVoltage{$Disty}{$PN} = '';}
                $TurnOnVoltage{$Disty}{$PN} = '';
                $TurnOffVoltage{$Disty}{$PN} = '';
                $OperateTime{$Disty}{$PN} = '';
                $ReleaseTime{$Disty}{$PN} = '';
                if(defined $field[18]){ $Features{$Disty}{$PN} = "$field[18]";}else{$Features{$Disty}{$PN} = '';}
                if(defined $field[23]){ $Mounting{$Disty}{$PN} = "$field[23]";}else{$Mounting{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Termination{$Disty}{$PN} = "$field[22]";}else{$Termination{$Disty}{$PN} = '';}
		$OpTemp{$Disty}{$PN} = ''; $OpTempL{$Disty}{$PN} = ''; $OpTempH{$Disty}{$PN} = '';
                if(defined $field[31]){ $Length{$Disty}{$PN} = &subLen("$field[31]", $file);}else{$Length{$Disty}{$PN} = '';}
                if(defined $field[32]){ $Width{$Disty}{$PN} = &subLen("$field[32]", $file);}else{$Width{$Disty}{$PN} = '';}
                if(defined $field[33]){ $Height{$Disty}{$PN} = &subLen("$field[33]", $file);}else{$Height{$Disty}{$PN} = '';}
              }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }

        #32
        }when ('Signal_Relay'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[16]") eq "1"){next;}

                if(defined $field[8] && $field[8] ne ''){ $field[8] =~ s/; [a-z]*//; &subPN("$field[8]" ,$file); if ( &subPN_daily("$field[8]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[10]){ $MPN{$Disty}{$PN} = "$field[10]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[16]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[16]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[15]){ &subStock("$field[15]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[17]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[17]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[5]){ $ImageLink{$Disty}{$PN} = "$field[5]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[9]){ $PNLink{$Disty}{$PN} = "$field[9]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[21]){ $Series{$Disty}{$PN} = "$field[21]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[23]){ $RelayType{$Disty}{$PN} = "$field[23]";}else{$RelayType{$Disty}{$PN} = '';}
                if(defined $field[24]){ $field[24] =~ s/-//;  $field[24] =~ s/Latching Dual Coil/Dual Coil Latching/;  $field[24] =~ s/Latching Single Coil/Latching/;  $field[24] =~ s/Non Latching/Non-Latching/; $CoilType{$Disty}{$PN} = "$field[24]";}else{$CoilType{$Disty}{$PN} = '';}
                if(defined $field[25]){ $CoilCurrent{$Disty}{$PN} = &subCur("$field[25]", $file);}else{$CoilCurrent{$Disty}{$PN} = '';}
                if(defined $field[26]){
		    $field[26] =~ s/-//;
                    if($field[26] =~/VAC\/DC/){
		        $field[26] =~ s/VAC\/DC//;
		        $CoilVoltageAC{$Disty}{$PN} = "$field[26]";
		        $CoilVoltageDC{$Disty}{$PN} = "$field[26]";
                    }elsif($field[26] =~/VAC/){
		        $field[26] =~ s/VAC//;
		        $CoilVoltageAC{$Disty}{$PN} = "$field[26]";
		        $CoilVoltageDC{$Disty}{$PN} = '';
                    }elsif($field[26] =~/VDC/){
		        $field[26] =~ s/VDC//;
		        $CoilVoltageAC{$Disty}{$PN} = '';
		        $CoilVoltageDC{$Disty}{$PN} = "$field[26]";
                    }else{
		        $CoilVoltageAC{$Disty}{$PN} = '';
		        $CoilVoltageDC{$Disty}{$PN} = '';
		    }
		}else{ $CoilVoltageAC{$Disty}{$PN} = ''; $CoilVoltageDC{$Disty}{$PN} = '';}
                if(defined $field[27]){ $ContactForm{$Disty}{$PN} = "$field[27]";}else{$ContactForm{$Disty}{$PN} = '';}
                if(defined $field[28]){ $ContactRating{$Disty}{$PN} = &subCur("$field[28]", $file);}else{$ContactRating{$Disty}{$PN} = '';}
                if(defined $field[29]){ $SwitchingVoltage{$Disty}{$PN} = "$field[29]";}else{$SwitchingVoltage{$Disty}{$PN} = '';}
                if(defined $field[30]){ $TurnOnVoltage{$Disty}{$PN} = "$field[30]";}else{$TurnOnVoltage{$Disty}{$PN} = '';}
                if(defined $field[31]){ $TurnOffVoltage{$Disty}{$PN} = "$field[31]";}else{$TurnOffVoltage{$Disty}{$PN} = '';}
                if(defined $field[32]){ $OperateTime{$Disty}{$PN} = "$field[32]";}else{$OperateTime{$Disty}{$PN} = '';}
                if(defined $field[33]){ $ReleaseTime{$Disty}{$PN} = "$field[33]";}else{$ReleaseTime{$Disty}{$PN} = '';}
                if(defined $field[34]){ $Features{$Disty}{$PN} = "$field[34]";}else{$Features{$Disty}{$PN} = '';}
                if(defined $field[35]){ $Mounting{$Disty}{$PN} = "$field[35]";}else{$Mounting{$Disty}{$PN} = '';}
                if(defined $field[36]){ $Termination{$Disty}{$PN} = "$field[36]";}else{$Termination{$Disty}{$PN} = '';}
                if(defined $field[37]){ 
		    $OpTemp{$Disty}{$PN} = &subOptemp("$field[37]", $file); my @subfield = split(/~/,$OpTemp{$Disty}{$PN}); $OpTempL{$Disty}{$PN} = $subfield[0]; $OpTempH{$Disty}{$PN} = $subfield[1];
		}else{
		    $OpTemp{$Disty}{$PN} = ''; $OpTempL{$Disty}{$PN} = ''; $OpTempH{$Disty}{$PN} = '';
                }
		$Length{$Disty}{$PN} = '';
		$Width{$Disty}{$PN} = '';
		$Height{$Disty}{$PN} = '';
            }elsif($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[8]){ $field[8] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[8]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[18]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[18]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[15]){ &subStock("$field[15]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[10]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[10]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[18]){ $field[18] =~ s/:.*//; $field[18] =~ s/Cut Tape  Cut Tape; //; $field[18] =~ s/Reel  Reel; //; $MOQ{$Disty}{$PN} = "$field[18]";}else{$MOQ{$Disty}{$PN} = '';}

                $ImageLink{$Disty}{$PN} = '';
		$PNLink{$Disty}{$PN} = '';
		$Description{$Disty}{$PN} = '';
		$Series{$Disty}{$PN} = '';
		$RelayType{$Disty}{$PN} = '';
		$CoilType{$Disty}{$PN} = '';
		$CoilCurrent{$Disty}{$PN} = '';
		$CoilVoltageAC{$Disty}{$PN} = '';
		$CoilVoltageDC{$Disty}{$PN} = '';
		$ContactForm{$Disty}{$PN} = '';
		$ContactRating{$Disty}{$PN} = '';
		$SwitchingVoltage{$Disty}{$PN} = '';
                $TurnOnVoltage{$Disty}{$PN} = '';
                $TurnOffVoltage{$Disty}{$PN} = '';
                $OperateTime{$Disty}{$PN} = '';
                $ReleaseTime{$Disty}{$PN} = '';
		$Features{$Disty}{$PN} = '';
		$Mounting{$Disty}{$PN} = '';
		$Termination{$Disty}{$PN} = '';
		$OpTemp{$Disty}{$PN} = ''; $OpTempL{$Disty}{$PN} = ''; $OpTempH{$Disty}{$PN} = '';
		$Length{$Disty}{$PN} = '';
		$Width{$Disty}{$PN} = '';
		$Height{$Disty}{$PN} = '';
	      }else{
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[4]){ $field[4] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[4]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[7]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[7]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[14]){ $field[14] =~ s/ Mult.*//; $field[14] =~ s/Min.: //; $field[14] =~ s/-//; $MOQ{$Disty}{$PN} = "$field[14]";}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[1]){ $ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[5]){ $PNLink{$Disty}{$PN} = "$field[5]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[9]){ $Description{$Disty}{$PN} = "$field[9]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Series{$Disty}{$PN} = "$field[30]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[17]){ $RelayType{$Disty}{$PN} = "$field[17]";}else{$RelayType{$Disty}{$PN} = '';}
                if(defined $field[25]){ $CoilType{$Disty}{$PN} = "$field[25]";}else{$CoilType{$Disty}{$PN} = '';}
                if(defined $field[24]){ $CoilCurrent{$Disty}{$PN} = &subCur("$field[24]", $file);}else{$CoilCurrent{$Disty}{$PN} = '';}
                if(defined $field[19]){
		    $field[19] =~ s/^.*to //;
                    if($field[19] =~/VAC/){
		        $field[19] =~ s/VAC//;
		        $CoilVoltageAC{$Disty}{$PN} = "$field[19]";
		        $CoilVoltageDC{$Disty}{$PN} = '';
                    }elsif($field[19] =~/VDC/ || $field[19] =~/V/){
		        $field[19] =~ s/VDC//; $field[19] =~ s/V//;
		        $CoilVoltageAC{$Disty}{$PN} = '';
		        $CoilVoltageDC{$Disty}{$PN} = "$field[19]";
                    }else{
		        $CoilVoltageAC{$Disty}{$PN} = '';
		        $CoilVoltageDC{$Disty}{$PN} = '';
		    }
		}else{ $CoilVoltageAC{$Disty}{$PN} = ''; $CoilVoltageDC{$Disty}{$PN} = '';}
                if(defined $field[20]){ $ContactForm{$Disty}{$PN} = "$field[20]";}else{$ContactForm{$Disty}{$PN} = '';}
                if(defined $field[22]){ $ContactRating{$Disty}{$PN} = &subCur("$field[22]", $file);}else{$ContactRating{$Disty}{$PN} = '';}
                $SwitchingVoltage{$Disty}{$PN} = '';
                $TurnOnVoltage{$Disty}{$PN} = '';
                $TurnOffVoltage{$Disty}{$PN} = '';
                $OperateTime{$Disty}{$PN} = '';
                $ReleaseTime{$Disty}{$PN} = '';
                if(defined $field[18]){ $Features{$Disty}{$PN} = "$field[18]";}else{$Features{$Disty}{$PN} = '';}
		$Mounting{$Disty}{$PN} = '';
                if(defined $field[27]){ $Termination{$Disty}{$PN} = "$field[27]";}else{$Termination{$Disty}{$PN} = '';}
		$OpTemp{$Disty}{$PN} = ''; $OpTempL{$Disty}{$PN} = ''; $OpTempH{$Disty}{$PN} = '';
		$Length{$Disty}{$PN} = '';
		$Width{$Disty}{$PN} = '';
		$Height{$Disty}{$PN} = '';
              }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }

        #34
        }when('Silicon_Capacitor'){
            if($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[7]){ $field[7] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[7]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[16]){ &subStock("$field[16]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[9]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[9]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[11]){ $Description{$Disty}{$PN} = "$field[11]";}else{$Description{$Disty}{$PN} = '';}
              }else{
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[4]){ $field[4] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[4]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[7]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[7]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[9]){ $Description{$Disty}{$PN} = "$field[9]";}else{$Description{$Disty}{$PN} = '';}
              }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }
        #35
        }when('LED'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[17]") eq "1"){next;}

                if(defined $field[7] && $field[7] ne ''){ &subPN("$field[7]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[11]){ $MPN{$Disty}{$PN} = "$field[11]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[17]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[17]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[16]){ &subStock("$field[16]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[13]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[13]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[15]){ $Description{$Disty}{$PN} = "$field[15]";}else{$Description{$Disty}{$PN} = '';}
                $MOQ{$Disty}{$PN} = '';
                if(defined $field[19]){ $Series{$Disty}{$PN} = "$field[19]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Type{$Disty}{$PN} = "$field[22]"; }else{$Type{$Disty}{$PN} = ''; }
                if(defined $field[23]){ $Color{$Disty}{$PN} = "$field[23]"; }else{$Color{$Disty}{$PN} = ''; }
                if(defined $field[24]){ $CCT{$Disty}{$PN} = "$field[24]"; }else{$CCT{$Disty}{$PN} = ''; }
                if(defined $field[25]){ $Wavelength{$Disty}{$PN} = "$field[25]"; }else{$Wavelength{$Disty}{$PN} = ''; }
                if(defined $field[26]){ $Configuration{$Disty}{$PN} = "$field[26]"; }else{$Configuration{$Disty}{$PN} = ''; }
                if(defined $field[27]){ $field[27] =~ s/lm.*//; $Flux{$Disty}{$PN} = "$field[27]"; }else{$Flux{$Disty}{$PN} = ''; }
                if(defined $field[28]){ $field[28] =~ s/A .*/A/; $CurrentTest{$Disty}{$PN} = &subCur("$field[28]", $file); }else{$CurrentTest{$Disty}{$PN} = ''; }
                if(defined $field[29]){ $Temperature{$Disty}{$PN} = "$field[29]"; }else{$Temperature{$Disty}{$PN} = ''; }
                if(defined $field[30]){ $field[30] =~ s/V .*/V/; $Voltage{$Disty}{$PN} = &subVol("$field[30]", $file); }else{$Voltage{$Disty}{$PN} = ''; }
                if(defined $field[31]){ $field[31] =~ s/lm.*//; $Lumens{$Disty}{$PN} = "$field[31]"; }else{$Lumens{$Disty}{$PN} = ''; }
                if(defined $field[32]){ $field[32] =~ s/A .*/A/; $CurrentMax{$Disty}{$PN} = &subCur("$field[32]", $file); }else{$CurrentMax{$Disty}{$PN} = ''; }
                if(defined $field[33]){ $field[33] =~ s/\s\(Typ\)//; $CRI{$Disty}{$PN} = "$field[33]"; }else{$CRI{$Disty}{$PN} = ''; }
                if(defined $field[34]){ $ViewingAngle{$Disty}{$PN} = "$field[34]"; }else{$ViewingAngle{$Disty}{$PN} = ''; }
                if(defined $field[35]){ $Features{$Disty}{$PN} = "$field[35]"; }else{$Features{$Disty}{$PN} = ''; }
                if(defined $field[36]){ $Size{$Disty}{$PN} = "$field[36]"; }else{$Size{$Disty}{$PN} = ''; }
                if(defined $field[37]){ $Height{$Disty}{$PN} = "$field[37]"; }else{$Height{$Disty}{$PN} = ''; }
                if(defined $field[38]){ $LES{$Disty}{$PN} = "$field[38]"; }else{$LES{$Disty}{$PN} = ''; }
                if(defined $field[39]){ $LensType{$Disty}{$PN} = "$field[39]"; }else{$LensType{$Disty}{$PN} = ''; }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }

        #36
        }when('TTP'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[18]") eq "1"){next;}

                if(defined $field[8] && $field[8] ne ''){ &subPN("$field[8]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[10]){ $MPN{$Disty}{$PN} = "$field[10]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[18]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[18]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[15]){ &subStock("$field[15]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[19]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[19]", $file);}else{$MOQ{$Disty}{$PN} = '';}
                if(defined $field[14]){ $ScreenSize{$Disty}{$PN} = "$field[14]"; 
		    $ScreenSize{$Disty}{$PN} =~ s/".*//; $ScreenSize{$Disty}{$PN} =~ s/TOUCH//; $ScreenSize{$Disty}{$PN} =~ s/SCREEN//; $ScreenSize{$Disty}{$PN} =~ s/CAPACITIVE//; $ScreenSize{$Disty}{$PN} =~ s/RESISTIVE//; $ScreenSize{$Disty}{$PN} =~ s/INFRARED IR//;
		}else{$ScreenSize{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Interface{$Disty}{$PN} = "$field[27]";}else{$Interface{$Disty}{$PN} = '';}
                if(defined $field[28]){ $Type{$Disty}{$PN} = "$field[28]"; }else{$Type{$Disty}{$PN} = ''; }
            }elsif($Disty eq 'MS'){
              if($date2 <= '20190128'){
                if(defined $field[6] && $field[6] ne ''){ $field[6] =~ s/; [a-z]*//; &subPN("$field[6]" ,$file); if ( &subPN_daily("$field[6]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[8]){ $field[8] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[8]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[22]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[22]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[19]){ &subStock("$field[19]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                #if(defined $field[14]){ $field[14] =~ s/".*//; substr($field[14],rindex($field[14]," "),length($field[14])-rindex($field[14]," ")); $ScreenSize{$Disty}{$PN} = "$field[14]";}else{$ScreenSize{$Disty}{$PN} = '';}
                if(defined $field[14]){ $ScreenSize{$Disty}{$PN} = "$field[14]"; $ScreenSize{$Disty}{$PN} =~ s/".*//; $ScreenSize{$Disty}{$PN} =~ s/LCD Touch Panels//;}else{$ScreenSize{$Disty}{$PN} = '';}
                $Interface{$Disty}{$PN} = "";
                if(defined $field[29]){ $Type{$Disty}{$PN} = "$field[29]"; }else{$Type{$Disty}{$PN} = ''; }
	      }else{
                if(defined $field[5] && $field[5] ne ''){ $field[5] =~ s/; [a-z]*//; &subPN("$field[5]" ,$file); if ( &subPN_daily("$field[5]" ,$file) eq "1"){next;}
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[4]){ $field[4] =~ s/; [a-z]*//; $MPN{$Disty}{$PN} = "$field[4]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[6]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[6]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[8]){ $Description{$Disty}{$PN} = "$field[8]";}else{$Description{$Disty}{$PN} = '';}
                #if(defined $field[14]){ $field[14] =~ s/".*//; substr($field[14],rindex($field[14]," "),length($field[14])-rindex($field[14]," ")); $ScreenSize{$Disty}{$PN} = "$field[14]";}else{$ScreenSize{$Disty}{$PN} = '';}
                if(defined $field[8]){ $ScreenSize{$Disty}{$PN} = "$field[8]"; $ScreenSize{$Disty}{$PN} =~ s/".*//; $ScreenSize{$Disty}{$PN} =~ s/LCD Touch Panels//;}else{$ScreenSize{$Disty}{$PN} = '';}
                $Interface{$Disty}{$PN} = "";
                if(defined $field[15]){ $Type{$Disty}{$PN} = "$field[15]"; }else{$Type{$Disty}{$PN} = ''; }
	      }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }

        #37
        }when ('Film_Capacitor'){
            if($Disty eq 'DK'){
              if($date2 <= '20181204'){
                if (&subStatus("$field[12]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[12]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[12]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[13]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[13]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[17]){ $Series{$Disty}{$PN} = "$field[17]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[19]){ $Capacitance{$Disty}{$PN} = &subCap("$field[19]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[20]){ $Tolerance{$Disty}{$PN} = "$field[20]";}else{$Tolerance{$Disty}{$PN} = '';}
                if(defined $field[21]){ $VAC{$Disty}{$PN} = &subVol("$field[21]", $file); }else{$VAC{$Disty}{$PN} = ''; }
                if(defined $field[22]){ $field[22] =~ s/\(.*//; $VDC{$Disty}{$PN} = &subVol("$field[22]", $file); }else{$VDC{$Disty}{$PN} = ''; }
                if(defined $field[23]){ $Dielectric{$Disty}{$PN} = "$field[23]"; }else{$Dielectric{$Disty}{$PN} = ''; }
                if(defined $field[24]){ $Esr{$Disty}{$PN} = &subRes("$field[24]", $file); }else{$Esr{$Disty}{$PN} = ''; }
                if(defined $field[25]){ $OpTemp{$Disty}{$PN} = "$field[25]"; }else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[26]){ $Mounting{$Disty}{$PN} = "$field[26]"; }else{$Mounting{$Disty}{$PN} = ''; }
                if(defined $field[27]){ $PackageCase{$Disty}{$PN} = "$field[27]"; }else{$PackageCase{$Disty}{$PN} = ''; }
                if(defined $field[28]){ $Size{$Disty}{$PN} = "$field[28]"; }else{$Size{$Disty}{$PN} = ''; }
                if(defined $field[29]){ $Height{$Disty}{$PN} = "$field[29]"; }else{$Height{$Disty}{$PN} = ''; }
                if(defined $field[30]){ $Termination{$Disty}{$PN} = "$field[30]"; }else{$Termination{$Disty}{$PN} = ''; }
                if(defined $field[31]){ $LeadSpacing{$Disty}{$PN} = "$field[31]"; }else{$LeadSpacing{$Disty}{$PN} = ''; }
                if(defined $field[32]){ $Application{$Disty}{$PN} = "$field[32]"; }else{$Application{$Disty}{$PN} = ''; }
              }else{
                if (&subStatus("$field[13]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[14]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[14]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[19]){ $Series{$Disty}{$PN} = "$field[19]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[21]){ $Capacitance{$Disty}{$PN} = &subCap("$field[21]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[22]){ $Tolerance{$Disty}{$PN} = "$field[22]";}else{$Tolerance{$Disty}{$PN} = '';}
                if(defined $field[23]){ $VAC{$Disty}{$PN} = &subVol("$field[23]", $file); }else{$VAC{$Disty}{$PN} = ''; }
                if(defined $field[24]){ $field[24] =~ s/\(.*//; $VDC{$Disty}{$PN} = &subVol("$field[24]", $file); }else{$VDC{$Disty}{$PN} = ''; }
                if(defined $field[25]){ $Dielectric{$Disty}{$PN} = "$field[25]"; }else{$Dielectric{$Disty}{$PN} = ''; }
                if(defined $field[26]){ $Esr{$Disty}{$PN} = &subRes("$field[26]", $file); }else{$Esr{$Disty}{$PN} = ''; }
                if(defined $field[27]){ $OpTemp{$Disty}{$PN} = "$field[27]"; }else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[28]){ $Mounting{$Disty}{$PN} = "$field[28]"; }else{$Mounting{$Disty}{$PN} = ''; }
                if(defined $field[29]){ $PackageCase{$Disty}{$PN} = "$field[29]"; }else{$PackageCase{$Disty}{$PN} = ''; }
                if(defined $field[30]){ $Size{$Disty}{$PN} = "$field[30]"; }else{$Size{$Disty}{$PN} = ''; }
                if(defined $field[31]){ $Height{$Disty}{$PN} = "$field[31]"; }else{$Height{$Disty}{$PN} = ''; }
                if(defined $field[32]){ $Termination{$Disty}{$PN} = "$field[32]"; }else{$Termination{$Disty}{$PN} = ''; }
                if(defined $field[33]){ $LeadSpacing{$Disty}{$PN} = "$field[33]"; }else{$LeadSpacing{$Disty}{$PN} = ''; }
                if(defined $field[34]){ $Application{$Disty}{$PN} = "$field[34]"; }else{$Application{$Disty}{$PN} = ''; }
              }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }

        #39
        }when ('Encoder'){
            if($Disty eq 'DK'){
                if ($field[17] =~/Digi-Reel/){next;}
                if (&subStatus("$field[23]") eq "1"){next;}

                if(defined $field[8] && $field[8] ne ''){ &subPN("$field[8]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[10]){ $MPN{$Disty}{$PN} = "$field[10]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[17]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[17]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[15]){ &subStock("$field[15]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[12]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[12]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[18]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[18]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[5]){ $ImageLink{$Disty}{$PN} = "$field[5]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[9]){ $PNLink{$Disty}{$PN} = "$field[9]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[14]){ $Description{$Disty}{$PN} = "$field[14]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[20]){ $Series{$Disty}{$PN} = "$field[20]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[24]){ $EncodeType{$Disty}{$PN} = "$field[24]";}else{$EncodeType{$Disty}{$PN} = '';}
                if(defined $field[25]){ $OutputType{$Disty}{$PN} = "$field[25]";}else{$OutputType{$Disty}{$PN} = '';}
                if(defined $field[26]){ $Pulses{$Disty}{$PN} = "$field[26]";}else{$Pulses{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Voltage{$Disty}{$PN} = "$field[27]"; }else{$Voltage{$Disty}{$PN} = ''; }
                if(defined $field[28]){ $ActuatorType{$Disty}{$PN} = "$field[28]";}else{$ActuatorType{$Disty}{$PN} = '';}
                if(defined $field[29]){ $Detent{$Disty}{$PN} = "$field[29]";}else{$Detent{$Disty}{$PN} = '';}
                if(defined $field[30]){ $BuiltInSwitch{$Disty}{$PN} = "$field[30]";}else{$BuiltInSwitch{$Disty}{$PN} = '';}
                if(defined $field[31]){ $Mounting{$Disty}{$PN} = "$field[31]";}else{$Mounting{$Disty}{$PN} = '';}
                if(defined $field[32]){ $Orientation{$Disty}{$PN} = "$field[32]";}else{$Orientation{$Disty}{$PN} = '';}
                if(defined $field[33]){ $Termination{$Disty}{$PN} = "$field[33]";}else{$Termination{$Disty}{$PN} = '';}
                if(defined $field[34]){ $RotationalLife{$Disty}{$PN} = "$field[34]";}else{$RotationalLife{$Disty}{$PN} = '';}
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }

        #40
        }when ('Potentiometer'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[13]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                $MOQ{$Disty}{$PN} = '';

                if(defined $field[1]){ $ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[5]){ $PNLink{$Disty}{$PN} = "$field[5]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[14]){ $Package{$Disty}{$PN} = "$field[14]";}else{$Package{$Disty}{$PN} = '';}
                if(defined $field[15]){ $Series{$Disty}{$PN} = "$field[15]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[17]){ $Resistance{$Disty}{$PN} = &subRes("$field[17]", $file); }else{$Resistance{$Disty}{$PN} = ''; }
                if(defined $field[18]){ $Tolerance{$Disty}{$PN} = "$field[18]";}else{$Tolerance{$Disty}{$PN} = '';}
                if(defined $field[19]){ $Power{$Disty}{$PN} = "$field[19]";}else{$Power{$Disty}{$PN} = '';}
                if(defined $field[20]){ $Adjustment{$Disty}{$PN} = "$field[20]";}else{$Adjustment{$Disty}{$PN} = '';}
                if(defined $field[21]){ $Temperature_Coefficient{$Disty}{$PN} = "$field[21]";}else{$Temperature_Coefficient{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Rotation{$Disty}{$PN} = "$field[22]";}else{$Rotation{$Disty}{$PN} = '';}
                if(defined $field[23]){ $Material{$Disty}{$PN} = "$field[23]";}else{$Material{$Disty}{$PN} = '';}
                if(defined $field[24]){ $Termination{$Disty}{$PN} = "$field[24]";}else{$Termination{$Disty}{$PN} = '';}
                if(defined $field[25]){ $ActuatorType{$Disty}{$PN} = "$field[25]";}else{$ActuatorType{$Disty}{$PN} = '';}
                if(defined $field[26]){ $Length{$Disty}{$PN} = "$field[26]";}else{$Length{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Diameter{$Disty}{$PN} = "$field[27]";}else{$Diameter{$Disty}{$PN} = '';}
                if(defined $field[28]){ $Bushing{$Disty}{$PN} = "$field[28]";}else{$Bushing{$Disty}{$PN} = '';}
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }

        #41
        }when ('Diode'){
            if($Disty eq 'DK'){
                if ($field[14] =~/Digi-Reel/){next;}
                if (&subStatus("$field[21]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[7]){ $MPN{$Disty}{$PN} = "$field[7]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[14]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[14]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[9]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[9]", $file);}else{$Supplier{$Disty}{$PN} = '';}

                if(defined $field[1]){ $ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[5]){ $PNLink{$Disty}{$PN} = "$field[5]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[11]){ $Description{$Disty}{$PN} = "$field[11]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[15]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[15]", $file);}else{$MOQ{$Disty}{$PN} = '';}
                if(defined $field[20]){ $Series{$Disty}{$PN} = "$field[20]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[21]){ $Status{$Disty}{$PN} = "$field[21]";}else{$Status{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Type{$Disty}{$PN} = "$field[22]";}else{$Type{$Disty}{$PN} = '';}
                if(defined $field[23]){ $Vr{$Disty}{$PN} = &subVol("$field[23]", $file); }else{$Vr{$Disty}{$PN} = ''; }
                if(defined $field[24]){ $field[24] =~ s/A .*/A/; $Io{$Disty}{$PN} = &subCur("$field[24]", $file); }else{$Io{$Disty}{$PN} = ''; }
                if(defined $field[25]){ $field[25] =~ s/@.*//; $Vf{$Disty}{$PN} = &subVol("$field[25]", $file); }else{$Vf{$Disty}{$PN} = ''; }
                if(defined $field[26]){ $Speed{$Disty}{$PN} = "$field[26]";}else{$Speed{$Disty}{$PN} = '';}
                if(defined $field[27]){ $trr{$Disty}{$PN} = &subTime("$field[27]", $file); }else{$trr{$Disty}{$PN} = ''; }
                if(defined $field[28]){ $field[28] =~ s/@.*//; $ReverseLeakageCurrent{$Disty}{$PN} = &subCur("$field[28]", $file); }else{$ReverseLeakageCurrent{$Disty}{$PN} = ''; }
                if(defined $field[29]){ $field[29] =~ s/@.*//; $Capacitance{$Disty}{$PN} = &subCap("$field[29]", $file); }else{$Capacitance{$Disty}{$PN} = ''; }
                if(defined $field[30]){ $Mounting{$Disty}{$PN} = "$field[30]"; }else{$Mounting{$Disty}{$PN} = ''; }
                if(defined $field[31]){ $PackageCase{$Disty}{$PN} = "$field[31]"; }else{$PackageCase{$Disty}{$PN} = ''; }
                if(defined $field[32]){ $Package{$Disty}{$PN} = "$field[32]"; }else{$Package{$Disty}{$PN} = ''; }
                if(defined $field[33]){ $OpTemp{$Disty}{$PN} = "$field[33]"; }else{$OpTemp{$Disty}{$PN} = ''; }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }

        #42
        }when ('Isolator'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[20]") eq "1"){next;}

                if(defined $field[8] && $field[8] ne ''){ &subPN("$field[8]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[13]){ $MPN{$Disty}{$PN} = "$field[13]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[20]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[20]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[18]){ &subStock("$field[18]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[15]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[15]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[21]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[21]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[5]){ $ImageLink{$Disty}{$PN} = "$field[5]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[9]){ $PNLink{$Disty}{$PN} = "$field[9]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[17]){ $Description{$Disty}{$PN} = "$field[17]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[26]){ $Series{$Disty}{$PN} = "$field[26]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[29]){ $Technology{$Disty}{$PN} = "$field[29]";}else{$Technology{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Channels{$Disty}{$PN} = "$field[30]";}else{$Channels{$Disty}{$PN} = '';}
                if(defined $field[31]){ $VoltageIsolation{$Disty}{$PN} = "$field[31]";}else{$VoltageIsolation{$Disty}{$PN} = '';}
                if(defined $field[32]){ $CMTI{$Disty}{$PN} = "$field[32]";}else{$CMTI{$Disty}{$PN} = '';}
                if(defined $field[33]){ $PropagationDelay{$Disty}{$PN} = "$field[33]";}else{$PropagationDelay{$Disty}{$PN} = '';}
                if(defined $field[34]){ $Distortion{$Disty}{$PN} = "$field[34]";}else{$Distortion{$Disty}{$PN} = '';}
                if(defined $field[35]){ $RiseFallTime{$Disty}{$PN} = "$field[35]";}else{$RiseFallTime{$Disty}{$PN} = '';}
                if(defined $field[36]){ $Current{$Disty}{$PN} = "$field[36]";}else{$Current{$Disty}{$PN} = '';}
                if(defined $field[37]){ $CurrentPeak{$Disty}{$PN} = "$field[37]";}else{$CurrentPeak{$Disty}{$PN} = '';}
                if(defined $field[38]){ $Vf{$Disty}{$PN} = "$field[38]";}else{$Vf{$Disty}{$PN} = '';}
                if(defined $field[39]){ $If{$Disty}{$PN} = "$field[39]";}else{$If{$Disty}{$PN} = '';}
                if(defined $field[40]){ $Vout{$Disty}{$PN} = "$field[40]";}else{$Vout{$Disty}{$PN} = '';}
                if(defined $field[41]){ $OpTemp{$Disty}{$PN} = "$field[41]";}else{$OpTemp{$Disty}{$PN} = '';}
                if(defined $field[42]){ $Mounting{$Disty}{$PN} = "$field[42]";}else{$Mounting{$Disty}{$PN} = '';}
                if(defined $field[43]){ $Package{$Disty}{$PN} = "$field[43]";}else{$Package{$Disty}{$PN} = '';}
                if(defined $field[44]){ $SupplierPackage{$Disty}{$PN} = "$field[44]";}else{$SupplierPackage{$Disty}{$PN} = '';}
                if(defined $field[45]){ $Approvals{$Disty}{$PN} = "$field[45]";}else{$Approvals{$Disty}{$PN} = '';}
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }

        #43
        }when ('Coupler'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[14]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[7]){ $MPN{$Disty}{$PN} = "$field[7]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[14]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[14]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[9]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[9]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[15]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[15]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[1]){ $ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[5]){ $PNLink{$Disty}{$PN} = "$field[5]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[11]){ $Description{$Disty}{$PN} = "$field[11]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[20]){ $Series{$Disty}{$PN} = "$field[20]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[23]){ $Channels{$Disty}{$PN} = "$field[23]";}else{$Channels{$Disty}{$PN} = '';}
                if(defined $field[24]){ $Inputs{$Disty}{$PN} = "$field[24]";}else{$Inputs{$Disty}{$PN} = '';}
                if(defined $field[25]){ $VoltageIsolation{$Disty}{$PN} = "$field[25]";}else{$VoltageIsolation{$Disty}{$PN} = '';}
                if(defined $field[26]){ $CMTI{$Disty}{$PN} = "$field[26]";}else{$CMTI{$Disty}{$PN} = '';}
                if(defined $field[27]){ $InputType{$Disty}{$PN} = "$field[27]";}else{$InputType{$Disty}{$PN} = '';}
                if(defined $field[28]){ $OutputType{$Disty}{$PN} = "$field[28]";}else{$OutputType{$Disty}{$PN} = '';}
                if(defined $field[29]){ $Current{$Disty}{$PN} = "$field[29]";}else{$Current{$Disty}{$PN} = '';}
                if(defined $field[30]){ $DataRate{$Disty}{$PN} = "$field[30]";}else{$DataRate{$Disty}{$PN} = '';}
                if(defined $field[31]){ $PropagationDelay{$Disty}{$PN} = "$field[31]";}else{$PropagationDelay{$Disty}{$PN} = '';}
                if(defined $field[32]){ $RiseFallTime{$Disty}{$PN} = "$field[32]";}else{$RiseFallTime{$Disty}{$PN} = '';}
                if(defined $field[33]){ $Vf{$Disty}{$PN} = "$field[33]";}else{$Vf{$Disty}{$PN} = '';}
                if(defined $field[34]){ $If{$Disty}{$PN} = "$field[34]";}else{$If{$Disty}{$PN} = '';}
                if(defined $field[35]){ $Voltage{$Disty}{$PN} = "$field[35]";}else{$Voltage{$Disty}{$PN} = '';}
                if(defined $field[36]){ $OpTemp{$Disty}{$PN} = "$field[36]";}else{$OpTemp{$Disty}{$PN} = '';}
                if(defined $field[37]){ $Mounting{$Disty}{$PN} = "$field[37]";}else{$Mounting{$Disty}{$PN} = '';}
                if(defined $field[38]){ $PackageCase{$Disty}{$PN} = "$field[38]";}else{$PackageCase{$Disty}{$PN} = '';}
                if(defined $field[39]){ $Package{$Disty}{$PN} = "$field[39]";}else{$Package{$Disty}{$PN} = '';}
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }

        #44
        }when ('Varistor'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[18]") eq "1"){next;}

                if(defined $field[8] && $field[8] ne ''){ &subPN("$field[8]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[11]){ $MPN{$Disty}{$PN} = "$field[11]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[18]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[18]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[16]){ &subStock("$field[16]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[13]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[13]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[19]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[19]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[5]){ $ImageLink{$Disty}{$PN} = "$field[5]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[9]){ $PNLink{$Disty}{$PN} = "$field[9]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[15]){ $Description{$Disty}{$PN} = "$field[15]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[24]){ $Series{$Disty}{$PN} = "$field[24]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[27]){ $VAC{$Disty}{$PN} = &subVol("$field[27]", $file); }else{$VAC{$Disty}{$PN} = ''; }
                if(defined $field[28]){ $VDC{$Disty}{$PN} = &subVol("$field[28]", $file); }else{$VDC{$Disty}{$PN} = ''; }
                if(defined $field[29]){ $Vmin{$Disty}{$PN} = &subVol("$field[29]", $file); }else{$Vmin{$Disty}{$PN} = ''; }
                if(defined $field[31]){ $Vtyp{$Disty}{$PN} = &subVol("$field[31]", $file); }else{$Vtyp{$Disty}{$PN} = ''; }
                if(defined $field[32]){ $Vmax{$Disty}{$PN} = &subVol("$field[32]", $file); }else{$Vmax{$Disty}{$PN} = ''; }
                if(defined $field[33]){ $CurrentSurge{$Disty}{$PN} = &subCur("$field[33]", $file);}else{$CurrentSurge{$Disty}{$PN} = '';}
                if(defined $field[34]){ $field[34] =~ s/J//; $Energy{$Disty}{$PN} = "$field[34]";}else{$Energy{$Disty}{$PN} = '';}
                if(defined $field[35]){ $NumberOfCircuits{$Disty}{$PN} = "$field[35]";}else{$NumberOfCircuits{$Disty}{$PN} = '';}
                if(defined $field[36]){ $Capacitance{$Disty}{$PN} = "$field[36]";}else{$Capacitance{$Disty}{$PN} = '';}
                if(defined $field[37]){ $OpTemp{$Disty}{$PN} = "$field[37]"; }else{$OpTemp{$Disty}{$PN} = ''; }
                if(defined $field[38]){ $Mounting{$Disty}{$PN} = "$field[38]"; }else{$Mounting{$Disty}{$PN} = ''; }
                if(defined $field[39]){ $Package{$Disty}{$PN} = "$field[39]"; }else{$Package{$Disty}{$PN} = ''; }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }

        #45
        }when ('CMNF'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[14]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[7]){ $MPN{$Disty}{$PN} = "$field[7]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[14]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[14]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[9]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[9]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[15]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[15]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[1]){ $ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[5]){ $PNLink{$Disty}{$PN} = "$field[5]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[11]){ $Description{$Disty}{$PN} = "$field[11]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[20]){ $Series{$Disty}{$PN} = "$field[20]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[23]){ $FilterType{$Disty}{$PN} = "$field[23]";}else{$FilterType{$Disty}{$PN} = '';}
                if(defined $field[24]){ $Lines{$Disty}{$PN} = "$field[24]";}else{$Lines{$Disty}{$PN} = '';}
                if(defined $field[25]){ $CurrentRating{$Disty}{$PN} = "$field[25]";}else{$CurrentRating{$Disty}{$PN} = '';}
                if(defined $field[26]){ $Resistance{$Disty}{$PN} = "$field[26]";}else{$Resistance{$Disty}{$PN} = '';}
                if(defined $field[27]){ $VDC{$Disty}{$PN} = "$field[27]";}else{$VDC{$Disty}{$PN} = '';}
                if(defined $field[28]){ $VAC{$Disty}{$PN} = "$field[28]";}else{$VAC{$Disty}{$PN} = '';}
                if(defined $field[29]){ $OpTemp{$Disty}{$PN} = "$field[29]";}else{$OpTemp{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Ratings{$Disty}{$PN} = "$field[30]";}else{$Ratings{$Disty}{$PN} = '';}
                if(defined $field[31]){ $Approvals{$Disty}{$PN} = "$field[31]";}else{$Approvals{$Disty}{$PN} = '';}
                if(defined $field[32]){ $Features{$Disty}{$PN} = "$field[32]";}else{$Features{$Disty}{$PN} = '';}
                if(defined $field[33]){ $Mounting{$Disty}{$PN} = "$field[33]";}else{$Mounting{$Disty}{$PN} = '';}
                if(defined $field[34]){ $Size{$Disty}{$PN} = "$field[34]";}else{$Size{$Disty}{$PN} = '';}
                if(defined $field[35]){ $Height{$Disty}{$PN} = "$field[35]";}else{$Height{$Disty}{$PN} = '';}
                if(defined $field[36]){ $PackageCase{$Disty}{$PN} = "$field[36]";}else{$PackageCase{$Disty}{$PN} = '';}
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }

        #46
        }when ('Fuse'){
            if($Disty eq 'DK'){
              if($date2 <= '20190109'){
                if (&subStatus("$field[14]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[7]){ $MPN{$Disty}{$PN} = "$field[7]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[14]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[14]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[9]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[9]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[15]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[15]", $file);}else{$MOQ{$Disty}{$PN} = '';}

		$ImageLink{$Disty}{$PN} = '';
		$PNLink{$Disty}{$PN} = '';
		$Description{$Disty}{$PN} = '';
		$Series{$Disty}{$PN} = '';
                $CurrentRating{$Disty}{$PN} = '';
		$VAC{$Disty}{$PN} = '';
		$VDC{$Disty}{$PN} = '';
		$ResponseTime{$Disty}{$PN} = '';
		$PackageCase{$Disty}{$PN} = '';
		$BreakingCapacity{$Disty}{$PN} = '';
		$Melting{$Disty}{$PN} = '';
		$Approvals{$Disty}{$PN} = '';
		$OpTemp{$Disty}{$PN} = '';
		$Size{$Disty}{$PN} = '';
		$Color{$Disty}{$PN} = '';
              }else{
                if (&subStatus("$field[13]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[14]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[14]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[1]){ $ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[5]){ $PNLink{$Disty}{$PN} = "$field[5]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[19]){ $Series{$Disty}{$PN} = "$field[19]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[21]){ $CurrentRating{$Disty}{$PN} = &subCur("$field[21]", $file);}else{$CurrentRating{$Disty}{$PN} = '';}
                if(defined $field[22]){ $VAC{$Disty}{$PN} = &subVol("$field[22]", $file); }else{$VAC{$Disty}{$PN} = ''; }
                if(defined $field[23]){ $VDC{$Disty}{$PN} = &subVol("$field[23]", $file); }else{$VDC{$Disty}{$PN} = ''; }
                if(defined $field[24]){ $ResponseTime{$Disty}{$PN} = "$field[24]";}else{$ResponseTime{$Disty}{$PN} = '';}
                if(defined $field[25]){ $PackageCase{$Disty}{$PN} = "$field[25]";}else{$PackageCase{$Disty}{$PN} = '';}
                if(defined $field[26]){ $BreakingCapacity{$Disty}{$PN} = "$field[26]";}else{$BreakingCapacity{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Melting{$Disty}{$PN} = "$field[27]";}else{$Melting{$Disty}{$PN} = '';}
                if(defined $field[28]){ $Approvals{$Disty}{$PN} = "$field[28]";}else{$Approvals{$Disty}{$PN} = '';}
                if(defined $field[29]){ $OpTemp{$Disty}{$PN} = "$field[29]";}else{$OpTemp{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Size{$Disty}{$PN} = "$field[30]";}else{$Size{$Disty}{$PN} = '';}
                if(defined $field[31]){ $Color{$Disty}{$PN} = "$field[31]";}else{$Color{$Disty}{$PN} = '';}
              }
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }

        #47
        }when ('Temperature_Sensor'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[13]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[14]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[14]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[1]){ $ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[5]){ $PNLink{$Disty}{$PN} = "$field[5]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[19]){ $Series{$Disty}{$PN} = "$field[19]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[22]){ $SensorType{$Disty}{$PN} = "$field[22]";}else{$SensorType{$Disty}{$PN} = '';}
                if(defined $field[23]){ $TempLocal{$Disty}{$PN} = "$field[23]";}else{$TempLocal{$Disty}{$PN} = '';}
                if(defined $field[24]){ $TempRemote{$Disty}{$PN} = "$field[24]";}else{$TempRemote{$Disty}{$PN} = '';}
                if(defined $field[25]){ $OutputType{$Disty}{$PN} = "$field[25]";}else{$OutputType{$Disty}{$PN} = '';}
                if(defined $field[26]){ $Voltage{$Disty}{$PN} = "$field[26]";}else{$Voltage{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Resolution{$Disty}{$PN} = "$field[27]";}else{$Resolution{$Disty}{$PN} = '';}
                if(defined $field[28]){ $Features{$Disty}{$PN} = "$field[28]";}else{$Features{$Disty}{$PN} = '';}
                if(defined $field[29]){ $Accuracy{$Disty}{$PN} = "$field[29]";}else{$Accuracy{$Disty}{$PN} = '';}
                if(defined $field[30]){ $TestCondition{$Disty}{$PN} = "$field[30]";}else{$TestCondition{$Disty}{$PN} = '';}
                if(defined $field[31]){ $OpTemp{$Disty}{$PN} = "$field[31]";}else{$OpTemp{$Disty}{$PN} = '';}
                if(defined $field[32]){ $Mounting{$Disty}{$PN} = "$field[32]";}else{$Mounting{$Disty}{$PN} = '';}
                if(defined $field[33]){ $PackageCase{$Disty}{$PN} = "$field[33]";}else{$PackageCase{$Disty}{$PN} = '';}
                if(defined $field[34]){ $Package{$Disty}{$PN} = "$field[34]";}else{$Package{$Disty}{$PN} = '';}
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }

        #48
        }when ('Pressure_Sensor'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[13]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[6]){ $MPN{$Disty}{$PN} = "$field[6]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[13]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[13]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[11]){ &subStock("$field[11]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[8]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[8]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[14]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[14]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[1]){ $ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[5]){ $PNLink{$Disty}{$PN} = "$field[5]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[10]){ $Description{$Disty}{$PN} = "$field[10]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[16]){ $Series{$Disty}{$PN} = "$field[16]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[19]){ $PressureType{$Disty}{$PN} = "$field[19]";}else{$PressureType{$Disty}{$PN} = '';}
                if(defined $field[20]){ $OperatingPressure{$Disty}{$PN} = "$field[20]";}else{$OperatingPressure{$Disty}{$PN} = '';}
                if(defined $field[21]){ $OutputType{$Disty}{$PN} = "$field[21]";}else{$OutputType{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Output{$Disty}{$PN} = "$field[22]";}else{$Output{$Disty}{$PN} = '';}
                if(defined $field[23]){ $Accuracy{$Disty}{$PN} = "$field[23]";}else{$Accuracy{$Disty}{$PN} = '';}
                if(defined $field[24]){ $Voltage{$Disty}{$PN} = "$field[24]";}else{$Voltage{$Disty}{$PN} = '';}
                if(defined $field[25]){ $PortSize{$Disty}{$PN} = "$field[25]";}else{$PortSize{$Disty}{$PN} = '';}
                if(defined $field[26]){ $PortStyle{$Disty}{$PN} = "$field[26]";}else{$PortStyle{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Features{$Disty}{$PN} = "$field[27]";}else{$Features{$Disty}{$PN} = '';}
                if(defined $field[28]){ $Termination{$Disty}{$PN} = "$field[28]";}else{$Termination{$Disty}{$PN} = '';}
                if(defined $field[29]){ $MaximumPressure{$Disty}{$PN} = "$field[29]";}else{$MaximumPressure{$Disty}{$PN} = '';}
                if(defined $field[30]){ $OpTemp{$Disty}{$PN} = "$field[30]";}else{$OpTemp{$Disty}{$PN} = '';}
                if(defined $field[31]){ $PackageCase{$Disty}{$PN} = "$field[31]";}else{$PackageCase{$Disty}{$PN} = '';}
                if(defined $field[32]){ $Package{$Disty}{$PN} = "$field[32]";}else{$Package{$Disty}{$PN} = '';}
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }

        #49
        }when ('Resistor'){
            if($Disty eq 'DK'){
                if($field[25] !~/Anti-Sulfur/){next;}
                if (&subStatus("$field[14]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[7]){ $MPN{$Disty}{$PN} = "$field[7]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[14]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[14]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[9]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[9]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                if(defined $field[15]){ $MOQ{$Disty}{$PN} = &subMOQ("$field[15]", $file);}else{$MOQ{$Disty}{$PN} = '';}

                if(defined $field[1]){ $ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[5]){ $PNLink{$Disty}{$PN} = "$field[5]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[11]){ $Description{$Disty}{$PN} = "$field[11]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[20]){ $Series{$Disty}{$PN} = "$field[20]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Resistance{$Disty}{$PN} = &subRes("$field[22]", $file);}else{$Resistance{$Disty}{$PN} = '';}
                if(defined $field[23]){ $Tolerance{$Disty}{$PN} = "$field[23]";}else{$Tolerance{$Disty}{$PN} = '';}
                if(defined $field[24]){ $field[24] =~ s/W.*//; $Power{$Disty}{$PN} = "$field[24]";}else{$Power{$Disty}{$PN} = '';}
                if(defined $field[25]){ $Features{$Disty}{$PN} = "$field[25]";}else{$Features{$Disty}{$PN} = '';}
                if(defined $field[26]){ $Temperature_Coefficient{$Disty}{$PN} = "$field[26]";}else{$Temperature_Coefficient{$Disty}{$PN} = '';}
                if(defined $field[27]){ $OpTemp{$Disty}{$PN} = "$field[27]";}else{$OpTemp{$Disty}{$PN} = '';}
                if(defined $field[28]){ $PackageCase{$Disty}{$PN} = "$field[28]";}else{$PackageCase{$Disty}{$PN} = '';}
                if(defined $field[29]){ $Package{$Disty}{$PN} = "$field[29]";}else{$Package{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Size{$Disty}{$PN} = "$field[30]";}else{$Size{$Disty}{$PN} = '';}
                if(defined $field[31]){ $Height{$Disty}{$PN} = "$field[31]";}else{$Height{$Disty}{$PN} = '';}
                if(defined $field[32]){ $TerminationCount{$Disty}{$PN} = "$field[32]";}else{$TerminationCount{$Disty}{$PN} = '';}
                if(defined $field[33]){ $FailureRate{$Disty}{$PN} = "$field[33]";}else{$FailureRate{$Disty}{$PN} = '';}
                if(defined $field[34]){ $Composition{$Disty}{$PN} = "$field[34]";}else{$Composition{$Disty}{$PN} = '';}
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }


        #50
        }when ('LED_Drivers_Offboard'){
            if($Disty eq 'DK'){
                if (&subStatus("$field[14]") eq "1"){next;}

                if(defined $field[4] && $field[4] ne ''){ &subPN("$field[4]" ,$file);
                }else{ print "\[WARNING\]: Missing PN, line $lc of $file\n"; next; }
                if(defined $field[7]){ $MPN{$Disty}{$PN} = "$field[7]";}else{$MPN{$Disty}{$PN} = '';}
                $date{$Disty}{$PN} = "$date";
                if(defined $field[14]){ ($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN}) = &subUnitPrice("$field[14]");}else{($UnitPrice{$Disty}{$PN},$MOQ{$Disty}{$PN})=('','');}
                if(defined $field[12]){ &subStock("$field[12]", "$UnitPrice{$Disty}{$PN}", $file);}else{&subStock('',"$UnitPrice{$Disty}{$PN}", $file);}
                if(defined $field[9]){ $Supplier{$Disty}{$PN} = &subSupplier("$field[9]", $file);}else{$Supplier{$Disty}{$PN} = '';}
                $MOQ{$Disty}{$PN} = '';

                if(defined $field[1]){ $ImageLink{$Disty}{$PN} = "$field[1]";}else{$ImageLink{$Disty}{$PN} = '';}
                if(defined $field[5]){ $PNLink{$Disty}{$PN} = "$field[5]";}else{$PNLink{$Disty}{$PN} = '';}
                if(defined $field[11]){ $Description{$Disty}{$PN} = "$field[11]";}else{$Description{$Disty}{$PN} = '';}
                if(defined $field[15]){ $Series{$Disty}{$PN} = "$field[15]";}else{$Series{$Disty}{$PN} = '';}
                if(defined $field[17]){ $Topology{$Disty}{$PN} = "$field[17]";}else{$Topology{$Disty}{$PN} = '';}
                if(defined $field[18]){ $OutputCount{$Disty}{$PN} = "$field[18]";}else{$OutputCount{$Disty}{$PN} = '';}
                if(defined $field[19]){ $VinMin{$Disty}{$PN} = "$field[19]";}else{$VinMin{$Disty}{$PN} = '';}
                if(defined $field[20]){ $VinMax{$Disty}{$PN} = "$field[20]";}else{$VinMax{$Disty}{$PN} = '';}
                if(defined $field[21]){ $Vout{$Disty}{$PN} = "$field[21]";}else{$Vout{$Disty}{$PN} = '';}
                if(defined $field[22]){ $Iout{$Disty}{$PN} = "$field[22]";}else{$Iout{$Disty}{$PN} = '';}
                if(defined $field[23]){ $field[23] =~ s/W//; $Power{$Disty}{$PN} = "$field[23]";}else{$Power{$Disty}{$PN} = '';}
                if(defined $field[24]){ $VoltageIsolation{$Disty}{$PN} = "$field[24]";}else{$VoltageIsolation{$Disty}{$PN} = '';}
                if(defined $field[25]){ $Dimming{$Disty}{$PN} = "$field[25]";}else{$Dimming{$Disty}{$PN} = '';}
                if(defined $field[26]){ $Features{$Disty}{$PN} = "$field[26]";}else{$Features{$Disty}{$PN} = '';}
                if(defined $field[27]){ $Ratings{$Disty}{$PN} = "$field[27]";}else{$Ratings{$Disty}{$PN} = '';}
                if(defined $field[28]){ $OpTemp{$Disty}{$PN} = "$field[28]";}else{$OpTemp{$Disty}{$PN} = '';}
                if(defined $field[29]){ $Efficiency{$Disty}{$PN} = "$field[29]";}else{$Efficiency{$Disty}{$PN} = '';}
                if(defined $field[30]){ $Termination{$Disty}{$PN} = "$field[30]";}else{$Termination{$Disty}{$PN} = '';}
                if(defined $field[31]){ $Size{$Disty}{$PN} = "$field[31]";}else{$Size{$Disty}{$PN} = '';}
            }else{
                print "\[WARNING\]: Undefined Disty, line $lc of $file\n"; $skipfile = 'y'; last; 
            }




        }default{
            print "\[WARNING\]: Undefined Product, line $lc of $file\n"; $skipfile = 'y'; last; 
        }#end when
        }#end given
    
        #=====
        #[2-3]Output
        #=====
	#print OFILE1 "$date" . "," . "$line\n";
        #if($Prod eq 'BtoB' || $Prod eq 'FPC' || $Prod eq 'Tact_Switch'){
            if(defined $date && defined $Disty && defined $Prod && defined $PN && defined $Stock{$Disty}{$PN} && defined $DiffStock{$Disty}{$PN} && defined $Quantity{$Disty}{$PN} && defined $Transaction{$Disty}{$PN} && defined $UnitPrice{$Disty}{$PN} && defined $PrevPrice{$Disty}{$PN} && defined $DiffPrice{$Disty}{$PN} && defined $MOQ{$Disty}{$PN} && defined $MPN{$Disty}{$PN} && defined $Supplier{$Disty}{$PN}){
	        print OFILE2 "$date" . "," . "$Disty" . "," . "$Prod" . "," . "$PN" . "," . "$Stock{$Disty}{$PN}" . "," . "$DiffStock{$Disty}{$PN}" . "," . "$Quantity{$Disty}{$PN}" . "," . "$Transaction{$Disty}{$PN}" . "," . "$UnitPrice{$Disty}{$PN}" . "," . "$PrevPrice{$Disty}{$PN}" . "," . "$DiffPrice{$Disty}{$PN}" . "," .  "$MOQ{$Disty}{$PN}", "," . "$MPN{$Disty}{$PN}", "," . "$Supplier{$Disty}{$PN}\n";
            }else{
	        #print "[ERROR]: Cannot find any viriables of transaction output\n";
            }
	    #if(defined $date){print "date: $date\n";}else{print "[ERROR]: date isn't defined\n";}
	    #if(defined $Disty){print "Disty: $Disty\n";}else{print "[ERROR]: Disty isn't defined\n";}
	    #if(defined $Prod){print "Prod: $Prod\n";}else{print "[ERROR]: Prod isn't defined\n";}
	    #if(defined $PN){print "PN: $PN\n";}else{print "[ERROR]: PN isn't defined\n";}
	    #if(defined $Stock{$Disty}{$PN}){print "Stock: $Stock{$Disty}{$PN}\n";}else{print "[ERROR]: Stock isn't defined\n";}
	    #if(defined $DiffStock{$Disty}{$PN}){print "DiffStock: $DiffStock{$Disty}{$PN}\n";}else{print "[ERROR]: DiffStock isn't defined\n";}
	    #if(defined $Quantity{$Disty}{$PN}){print "Quantity: $Quantity{$Disty}{$PN}\n";}else{print "[ERROR]: Quantity isn't defined\n";}
	    #if(defined $Transaction{$Disty}{$PN}){print "Transaction: $Transaction{$Disty}{$PN}\n";}else{print "[ERROR]: Transaction isn't defined\n";}
	    #if(defined $UnitPrice{$Disty}{$PN}){print "UnitPrice: $UnitPrice{$Disty}{$PN}\n";}else{print "[ERROR]: UnitPrice isn't defined\n";}
	    #if(defined $PrevPrice{$Disty}{$PN}){print "PrevPrice: $PrevPrice{$Disty}{$PN}\n";}else{print "[ERROR]: PrevPrice isn't defined\n";}
	    #if(defined $DiffPrice{$Disty}{$PN}){print "DiffPrice: $DiffPrice{$Disty}{$PN}\n";}else{print "[ERROR]: DiffPrice isn't defined\n";}
	    #if(defined $MOQ{$Disty}{$PN}){print "MOQ: $MOQ{$Disty}{$PN}\n";}else{print "[ERROR]: MOQ doesn't be defined\n";}
	    #if(defined $MPN{$Disty}{$PN}){print "MPN: $MPN{$Disty}{$PN}\n";}else{print "[ERROR]: MPN doesn't be defined\n";}
	    #if(defined $Supplier{$Disty}{$PN}){print "Supplier: $Supplier{$Disty}{$PN}\n";}else{print "[ERROR]: Supplier isn't defined\n";}

        #}else{
        #    if(defined $date && defined $Disty && defined $Prod && defined $PN && defined $Stock{$Disty}{$PN} && defined $DiffStock{$Disty}{$PN} && defined $Quantity{$Disty}{$PN} && defined $Transaction{$Disty}{$PN} && defined $UnitPrice{$Disty}{$PN}){
        #        print OFILE2 "$date" . "," . "$Disty" . "," . "$Prod" . "," . "$PN" . "," . "$Stock{$Disty}{$PN}" . "," . "$DiffStock{$Disty}{$PN}" . "," . "$Quantity{$Disty}{$PN}" . "," . "$Transaction{$Disty}{$PN}" . "," . "$UnitPrice{$Disty}{$PN}\n";
        #    }
        #}

    }#end while line

 
    close(IFILE1);
    #close(OFILE1);
    close(OFILE2);

    #===========
    # Output LineCount
    #===========
    print OFILE4 "$f0" . "," . "$date" . "," ."$lc\n";

}#end foreach file

&subOutspecDisty("$Disty","$Prod");


close(OFILE3);
close(OFILE0);
close(OFILE4);


