create table temp_1 as
select distinct common_name
from complete_ny_ebird_data;

create table temp_2 as
select distinct birdname
from birds_by_habitat_na;

/* Total distinct birds in eBird NY (527) */
select distinct * from temp_1;

/* Birds in eBird not found in North America := erroneous names (132) */
select common_name from temp_1
where common_name not in
(select birdname from temp_2);

/* Birds in eBird found in North America := valid names (395) */
select common_name from temp_1
where common_name in
(select birdname from temp_2);

/* Filter out the birds not seen in NY State (eBird) */
select * from birds_by_habitat_na
where birdname in
(select common_name from temp_1);

/* Function to calculate distance in miles between 2 GPS locations */
create function dist_gps (lat1 float, lon1 float, lat2 float, lon2 float)
returns float
begin
	declare rv float;
	declare dlat float;
	declare dlon float;
	declare a float;
	declare c float;
	declare earth_radius_miles float;

	set earth_radius_miles = 3956;
	set dlat = radians(lat2-lat1);
	set dlon = radians(lon2-lon1);

	set a = pow(sin(dlat/2.0),2) + cos(radians(lat1))*cos(radians(lat2))*pow(sin(dlon/2.0),2);
	set c = 2*atan2(sqrt(a),sqrt(1-a));
	set rv = earth_radius_miles * c;
	return rv;
end;

/* Get a histogram of birds around a given GPS location within a given radius */
set @RADIUS = 3;
set @X = 40.92;
set @Y= -73.12;
set @MONTHNUM = 4;
set @DELTA = 1;

select common_name as 'Bird', sum(obs_number) as 'Frequency'
from complete_ny_ebird_data
where obs_number is not null
and dist_gps(lat,lon,@X,@Y) < @RADIUS
and month(obs_data) >= @MONTHNUM - @DELTA and month(obs_data) <= @MONTHNUM + @DELTA
group by common_name
order by 2 desc;

/* Filtered query */
select * from
(select common_name as 'Bird', sum(obs_number) as 'Frequency'
from complete_ny_ebird_data
where obs_number is not null
and month(obs_data) >= @MONTHNUM - @DELTA and month(obs_data) <= @MONTHNUM + @DELTA
and dist_gps(lat,lon,@X,@Y) < @RADIUS
group by common_name) as NA
where Bird in (select birdname from birds_by_habitat_ny where habitat = 'coasts');

/* Create separate table for NY birds */
create table birds_by_habitat_ny like birds_by_habitat_na;


