#!/usr/bin/perl

$pxsize= 120;
$pysize= 90;
$column= 10;

if ($#ARGV<0) {
    print "usage: html.pl {image directory}\n";
    exit 1;
}

@img=<$ARGV[0]/*.{jpeg,jpg,JPG,JPEG}>;

&header();

print "<TABLE BORDER=\"5\" CELLSPACING=\"1\" CELLPADDING=\"2\">\n";
foreach $fn (@img){
    $a++; $fn="file:".$fn;
    if ($a==1) { print "<TR>\n"; }
    print "<TD ALIGN=\"CENTER\">";
    print "<A HREF=\"$fn\" target=\"_blank\">";
    print "<IMG SRC=\"$fn\" WIDTH=\"$pxsize\" HEIGHT=\"$pysize\"></A><BR>";
    print "</TD>\n";
    if ($a==$column) { print "</TR>\n\n"; $a=0;}
}
  if ($a!=0) { print "</TR>\n\n"; $a=0;}
  print "</TABLE>\n\n";
  print "<BR>&nbsp;&nbsp;\n";

&tail();
exit(0);

sub header{
print << "EOF";
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">

<HTML><BODY BGCOLOR=#ffffff>
<HEAD>
<META name="robots" content="noindex,nofellow">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=EUC-JP">
<TITLE>Result</TITLE>
</HEAD>
EOF
}

sub tail{
print "</BODY></HTML>\n\n";
}


