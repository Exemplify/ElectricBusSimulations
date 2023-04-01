% import the data based on the options provided

switch options.dataType
    case dataType.route1
        gps = importGps('sample_route1/Location');
        barometer = importBarometer('sample_route1/Barometer');
    case dataType.route2
        gps = importGps('sample_route3/Location');
        barometer = importBarometer('sample_route3/Barometer');
    case dataType.route3
        gps = importGps('sample_route2/Location');
        barometer = importBarometer('sample_route2/Barometer');
    case dataType.route4
        gps = importGps('sample_route4/Location');
        barometer = importBarometer('sample_route4/Barometer');
    otherwise
        error('No Data Type Selected')
end 

ef_map_image = load("efficiency_map_pmsm.mat");
ef_map_image = ef_map_image.ef_map_image;

% ef_map_image = imread("Induction-motor.png");
