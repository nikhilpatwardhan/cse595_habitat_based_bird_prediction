
addpath('./utils/libsvm-mat-3.0-1/');
addpath('./utils/spatial_pyramid/');
addpath('./utils/');

% Read an image, GPS co-ordinates and a date
prompt = {'Input image path:','Latitude:','Longitude:','Date:'};
defAns = {'','','',''};
numlines = 1;
name = 'Habitat-based Bird Identification';

answer = inputdlg(prompt, name, numlines, defAns, 'on');
% 
% % % I = imread(answer{1});
lat = str2double(answer{2});            % GPS Latitude
lon = str2double(answer{3});            % GPS Longitude
daten = datenum(answer{4});
datev = datevec(daten);
month = datev(:,2);                     % as number
radius = 3;                             % miles

% Error handling?
% month = 5;
% lat = 40.92;
% lon = -73.12;
% answer{1} = ;

% Identify the habitat in the image
label = findHabitat(answer{1})
% label = findHabitat('./data/demo/roof-view-2.jpg')   % UGLY
% label = findHabitat('./data/demo/out/9.jpg')

% Build an SQL query using GPS data and the date
sqlquery = sprintf(['select * from (select common_name as ''Bird'', ' ...
                    'sum(obs_number) as ''Frequency'' from complete_ny_ebird_data ' ...
                    'where obs_number is not null and ' ...
                    'month(obs_data) >= %d - 1 and month(obs_data) <= %d + 1 ' ...
                    'and dist_gps(lat,lon,%.6f,%.6f) < %d group by common_name) as NA ' ...
                    'where Bird in (select birdname from birds_by_habitat_ny where habitat = ''%s'') ' ...
                    'order by 2 desc;'],month,month,lat,lon,radius,label);

% Execute the SQL query
conn = database('mysql', 'dummy', 'dummy', 'com.mysql.jdbc.Driver',...
                'jdbc:mysql://localhost:3306/mysql');
curs = fetch(conn, sqlquery);

% Get a histogram
x = [];
y = {};
for i=1:length(curs)
    y{i} = sprintf(cell2mat(curs(i,1)));
    x(i) = cell2mat(curs(i,2));
end;

if (isempty(x))
    disp('Sorry, no bird sightings were found for that habitat at the given location.');
    return;
end;
% Show the histogram
bar(x);
xticklabel_rotate([1:length(x)],90,y,'interpreter','none');
ylabel('Bird Counts');
xlabel('Birds');
titleString = sprintf('Bird counts for the habitat ''%s'' around Latitude %.6f, Longitude %.6f',label,lat,lon);
title(titleString);