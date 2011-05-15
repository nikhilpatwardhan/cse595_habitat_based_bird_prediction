#!/usr/bin/gawk -f
# This file assumes that the habitat-bird mapping for all habitats is available in a single file.
# This is useful when the entire North America bird list has been manually filtered to get only birds of New York.
# Sample usage: ./insertNY.gawk < ny_only.csv > importALL.csv
# 		mysql --user=dummy --password=dummy mysql < importALL.csv

BEGIN {FS=",";dbname="birds_by_habitat_ny";}
{
	common_name=$1;
	if (match(common_name,/'/))
		sub(/'/,"\\'",common_name);
	habitat=$2;
	print "insert into "dbname" values('"common_name"','"habitat"');";
}
