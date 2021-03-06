classdef QueryTest < matlab.unittest.TestCase
    % Tests for queries against certain examples
    
    methods (Test)
        function testExampleDs007(this)
            ex_dir = fullfile(bids_unittest.Common.examplesDir, 'ds007');
            b = bids.layout(ex_dir);
            
            subjs = arrayfun(@(x) sprintf('%02d',x), 1:20, 'UniformOutput',false);
            this.verifyEqual(bids.query(b,'subjects'),subjs);

            this.verifyEmpty(bids.query(b,'sessions'));

            this.verifyEqual(bids.query(b,'runs'),{'01','02'});

            tasks = {'stopsignalwithletternaming','stopsignalwithmanualresponse', ...
                'stopsignalwithpseudowordnaming'};
            this.verifyEqual(bids.query(b,'tasks'),tasks);

            types = {'T1w','bold','events','inplaneT2'};
            this.verifyEqual(bids.query(b,'types'),types);

            mods = {'anat','func'};
            this.verifyEqual(bids.query(b,'modalities'),mods);
            
            this.verifyEmpty(bids.query(b,'runs','type','T1w'));

            runs = {'01','02'};
            this.verifyEqual(bids.query(b,'runs','type','bold'),runs);

            bold = bids.query(b,'data','sub','05','run','02','task', ...
                'stopsignalwithmanualresponse','type','bold');
            this.verifyTrue(iscellstr(bold)); %#ok<ISCLSTR>
            this.verifySize(bold, [1 1]);
            
            % Alternate struct format for query input
            % This is an undocumented backdoor I found in the local
            % parse_query function; I'm not sure we should actually be
            % testing it -apjanke
            query_struct = struct('sub','05','run','02','task', ...
                'stopsignalwithmanualresponse','type','bold');
            bold = bids.query(b,'data',query_struct);
            this.verifyTrue(iscellstr(bold), 'bold query still works with struct input'); %#ok<ISCLSTR>

            md = bids.query(b,'metadata','sub','05','run','02','task','stopsignalwithmanualresponse','type','bold');
            this.verifyTrue(isstruct(md) & isfield(md,'RepetitionTime') & isfield(md,'TaskName'));
            this.verifyTrue(md.RepetitionTime == 2);
            this.verifyEqual(md.TaskName,'stop signal with manual response');

            md = bids.query(b,'metadata','sub','05','run','02','task',...
                'stopsignalwithmanualresponse','type','bold', 'target','RepetitionTime');
            this.verifyEqual(md, 2, 'querying ''target'',''RepetitionTime'' worked');
            lastwarn('');
            md = bids.query(b,'metadata','sub','05','run','02','task',...
                'stopsignalwithmanualresponse','type','bold', 'target','NonexistentField');
            this.verifyEmpty(md, 'querying ''target'',''NonexistentField'' returned empty');
            [warnMsg,warnId] = lastwarn;
            this.verifyEmpty(warnId, 'warning on nonexistent metadata target had empty ID');
            this.verifyMatches(warnMsg, 'Non-existent field for metadata');            

            t1 = bids.query(b,'data','type','T1w');
            this.verifyTrue(iscellstr(t1)); %#ok<ISCLSTR>
            this.verifyEqual(numel(t1), numel(bids.query(b,'subjects')));

            % Check sessions
            %   parse a folder with sessions
            synth_dir = fullfile(fileparts(ex_dir),'synthetic');
            b2 = bids.layout(synth_dir);
            %   test
            sessions = {'01','02'};
            this.verifyEqual(bids.query(b2,'sessions'),sessions)
            this.verifyEqual(bids.query(b2,'sessions','sub','02'),sessions)
            
            % Check that bogus queries raise error
            try
                bids.query(b);
                this.verifyFail('bids.query(b) should have errored');
            catch
                this.verifyTrue(true, 'bids.query(b) should have errored');
            end
            try
                bids.query(b,'bogusquery');
                this.verifyFail('bids.query(b,''bogusquery'') should have errored');
            catch
                this.verifyTrue(true, 'bids.query(b,''bogusquery'') should have errored');
            end
            try
                bids.query(b,'metadata', 'key_with_no_val');
                this.verifyFail('bids.query(b,''metadata'',''key_with_no_val'') should have errored');
            catch
                this.verifyTrue(true, 'bids.query(b,''metadata'',''key_with_no_val'') should have errored');
            end
        end
    end
    
end