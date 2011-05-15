#!/usr/bin/gawk -f
# Assumes that habitat-bird mappings are available in dedicated text files having the name of the habitat.
# This is required when dumping the initial data from whatbird.com into the DB, since this contains data for all of North America.
# Sample usage: ./insertWB.gawk urban >> import.csv
# 		mysql --user=dummy --password=dummy mysql < import.csv

BEGIN {FS="\t";dbname="birds_by_habitat_na";habitat=ARGV[1];}
{
	common_name=$1;
	if (match(common_name,/'/))
		sub(/'/,"\\'",common_name);
	print "insert into "dbname" values('"common_name"','"habitat"');";
}
