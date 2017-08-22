use strict;
use warnings;

#Be sure to set FEDORA_HOME before you run this script
#system("export FEDORA_HOME=/opt/rails-apps/curate_app/jetty/fedora/");
#Can be ignored as we are asking users to enter the same during execution.


#File containing PIDs can be provided as an argument at Command Line and save the file in the directory where this script is being executed
my $inputFile;
my $PIDFile = $ARGV[0];
unless ($PIDFile) {
    print "Enter filename: ";
    $PIDFile = <STDIN>;
    chomp $PIDFile;
}

#Fedora datastream path where Fedora stores all the metadata files and the actual files uploaded to scholar
#In Larry datastream is located at /opt/rails-apps/curate_app/jetty/fedora/default/data/datastreamStore
my $datastreamPath;
print "Enter absolute path of datastream: ";
$datastreamPath = <STDIN>;
chomp $datastreamPath;

#Fedora bin contains client command-line utilities and is located in Larry at /opt/rails-apps/curate_app/jetty/fedora/client/bin
my $fedoraBin;
print "Enter absolute path of Fedora bin: ";
$fedoraBin = <STDIN>;
chomp $fedoraBin;

#Files will be exported to the following destination
my $exportPath;
print "Enter absolute path of directory where you want files to be exported to: ";
$exportPath = <STDIN>;
chomp $exportPath;

#Stores PIDs of the files and their latest version numbers in an array
my @PIDandFileVersion;
my $fileVersion;
open($inputFile, $PIDFile) or die $!;
while(my $PID = <$inputFile>) {
    chomp $PID;
    my $getVersionCmd = 'sh '.$fedoraBin.'/fedora-dsinfo.sh localhost 4001 fedoraAdmin fedoraAdmin '.$PID.' http | grep VERSION | grep content';
    $PIDandFileVersion[$.-1][0] = $PID;
    $fileVersion = `$getVersionCmd`;
    chomp $fileVersion;
    $fileVersion = (split(/:/, $fileVersion))[1];
    $fileVersion = (split(/\./, $fileVersion))[1];
    $PIDandFileVersion[$.-1][1] = $fileVersion;
}


#Creates directories with PID as their name and then copies respective file into that directory
foreach my $row (@PIDandFileVersion) {
    `mkdir $exportPath/@$row[0]`;
    my $partialPID = (split(/:/,@$row[0]))[1];
    my $findFileCmd = 'find '.$datastreamPath.' -name "*'.$partialPID.'*content*'.@$row[1].'" -print';
    my $exportFile = `$findFileCmd`;
    chomp $exportFile;
    $exportFile = 'cp -p '.$exportFile.' '.$exportPath.'/'.@$row[0].'/';
    chomp $exportFile;
    `$exportFile`;

    my $checksum = 'find '.$datastreamPath.' -name "*'.$partialPID.'*characterization*'.'" -exec grep \'md5checksum\' \{\} \;';
    $checksum = `$checksum`;
    $checksum = (split(/</,(split(/>/,$checksum))[1]))[0];
    my $md5file = $exportPath.'/'.@$row[0].'/'.'oldChecksum.md5';
    open (my $md5, '>', $md5file) or die $!;
    print $md5 $checksum;
    close $md5;
}
close $inputFile;
print "\n";
