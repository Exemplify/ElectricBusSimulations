% import the data based on the options provided

switch options.dataType
    case dataType.route1
        load("route1_data.mat");
    case dataType.route2
        load("route2_data.mat");
    case dataType.route3
        load("route3_data.mat");
    case dataType.route4
        load("route4_data.mat");
    otherwise
        error('No Data Type Selected')
end 

ef_map_image = load("efficiency_map_pmsm.mat");
ef_map_image = ef_map_image.ef_map_image;

% ef_map_image = imread("Induction-motor.png");
