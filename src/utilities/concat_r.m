function r_out = concat_r(r_in)
% CONCAT_R Concatenates arrays in the object hierarchy of r struct

    % Check input argument
    if ~iscell(r_in) || isempty(r_in)
        error('Input argument must be a non-empty cell array of struct');
    end

    % Concatenate arrays in route and dynamics object hierarchies
    route_out = r_in{1}.route;
    dynamics_out = r_in{1}.dynamics;
    for i = 2:length(r_in)
        % Concatenate route properties
        route_fields = fieldnames(r_in{i}.route);
        for j = 1:length(route_fields)
            if isa(r_in{i}.route.(route_fields{j}), 'double')
                route_out.(route_fields{j}) = cat(2, route_out.(route_fields{j}), r_in{i}.route.(route_fields{j}));
            else
                route_out.(route_fields{j}) = r_in{i}.route.(route_fields{j});
            end
        end

        % Concatenate dynamics properties
        dynamics_fields = fieldnames(r_in{i}.dynamics);
        for j = 1:length(dynamics_fields)
            if isfield(r_in{i}.dynamics, dynamics_fields{j})
                if isa(r_in{i}.dynamics.(dynamics_fields{j}), 'struct')
                    % Concatenate sub-structs
                    [dual_out, positive_out, negative_out] = dstrc(dynamics_out.(dynamics_fields{j}), 'dual', 'positive', 'negative');
                    [dual_in, positive_in, negative_in] = dstrc(r_in{i}.dynamics.(dynamics_fields{j}), 'dual', 'positive', 'negative');

                    dynamics_out.(dynamics_fields{j}).dual = cat(2, dual_out, dual_in);
                    dynamics_out.(dynamics_fields{j}).positive = cat(2, positive_out, positive_in);
                    dynamics_out.(dynamics_fields{j}).negative = cat(2, negative_out, negative_in);

                if(strcmp(dynamics_fields{j}, 'energy'))
                    [expended_out, regenerated_out, total_out, adjusted_out, unadjusted_out] = dstrc(dynamics_out.(dynamics_fields{j}), ...
                        'expended', 'regenerated', 'total', 'adjusted', 'unadjusted');
                    [expended_in, regenerated_in, total_in, adjusted_in, unadjusted_in] = dstrc(r_in{i}.dynamics.(dynamics_fields{j}), ...
                        'expended', 'regenerated', 'total', 'adjusted', 'unadjusted');
                
                    dynamics_out.(dynamics_fields{j}).expended = expended_out + expended_in; 
                    dynamics_out.(dynamics_fields{j}).regenerated = regenerated_out + regenerated_in;
                    dynamics_out.(dynamics_fields{j}).total = total_out + total_in;
                    dynamics_out.(dynamics_fields{j}).adjusted = adjusted_out + adjusted_in; 
                    dynamics_out.(dynamics_fields{j}).unadjusted = unadjusted_out + unadjusted_in; 
                end
                elseif isa(r_in{i}.dynamics.(dynamics_fields{j}), 'double')
                    % Concatenate double arrays
                    dynamics_out.(dynamics_fields{j}) = cat(2, dynamics_out.(dynamics_fields{j}), r_in{i}.dynamics.(dynamics_fields{j}));
                else
                    % Assign non-double arrays as-is
                    dynamics_out.(dynamics_fields{j}) = r_in{i}.dynamics.(dynamics_fields{j});
                end
            end
        end
    end
    
    % Construct new r struct
    r_out = struct('route', route_out, 'dynamics', dynamics_out);
end
