function varargout = dstrc(obj, varargin)
% DESTRUCT Extracts properties of a MATLAB struct into variables
%   varargout = destruct(obj, varargin) extracts all properties of the
%   struct obj and returns them as output arguments.

    % Check that the first input is a struct
    if ~isstruct(obj)
        error('The first input must be a struct.');
    end
    
    % Extract all properties of the struct into output variables
    props = fieldnames(obj);
    if nargin == 1
        % Return all properties if none are specified
        varargin = props;
    end
    
    % Check that the number of output variables is not greater than the
    % number of input properties
    if nargin-1 > nargout
        error('Too many output variables.');
    end
    
    % Extract the specified properties of the struct into output variables
    for i = 1:length(varargin)
        prop = varargin{i};
        if ~isfield(obj, prop)
            error('The struct does not contain the field %s.', prop);
        end
        varargout{i} = obj.(prop);
    end
end
