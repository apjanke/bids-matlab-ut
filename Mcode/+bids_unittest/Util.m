classdef Util
    % Util Miscellaneous utility functions
    
    methods (Static)
        function [out,details] = readdir(dir_path)
            % readdir Read directory contents, excluding '.' and '..'
            %
            % [out,details] = bids_unittest.Util.readdir(dir_path)
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
        
        function mkdir(newDir)
            % mkdir Create a directory, raising an error on failure
            %
            % bids_unittest.Util.mkdir(newDir)
            [ok,msg] = mkdir(newDir);
            if ~ok
                error('Failed creating dir ''%s'': %s', newDir, msg);
            end
        end
        
        function fid = fopen(file, mode)
            % fopen fopen a file, raising an error on failure
            if nargin < 2 || isempty(mode); mode = 'r'; end
            [fid,msg] = fopen(file, mode);
            if fid < 1
                error('Failed opening file ''%s'' in mode ''%s'': %s', ...
                    file, mode, msg);
            end
        end
        
        function spew(file, text)
            % spew Write text to a file, replacing contents
            fid = bids_unittest.Util.fopen(file, 'w');
            fprintf(fid, '%s', text);
            fclose(fid);
        end
        
        function out = hostname
            % hostname Host name of this system
            if isunix
                [~,txt] = system('hostname');
                out = chomp(txt);
            else
                out = lower(getenv('COMPUTERNAME'));
            end
        end

    end
end

function out = chomp(str)
out = regexprep(str, '\r?\n', '');
end
