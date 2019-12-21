classdef Util
    % Util Miscellaneous utility functions
    
    methods (Static)
        function [out,details] = readdir(dir_path)
            % readdir Read directory contents, excluding '.' and '..'
            %
            % [out,details] = bids_ut.Util.readdir(dir_path)
            %
            % Returns a cellstr vector containing the names of files inside
            % the dir_path. Also returns details, a struct array in the form
            % returned by the dir() function.
            %
            % Errors if the directory could not be read.
            %
            % See also:
            % dir
            details = dir(dir_path);
            names = {details.name};
            tf_exclude = ismember(names, {'.','..'});
            names(tf_exclude) = [];
            details(tf_exclude) = [];
            out = names;
        end
    end
end