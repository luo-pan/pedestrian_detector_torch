function script_process_rois_acf_TudBrussels(varargin)
%% process ACF ROI boxes for the Tud-Brussels dataset
% input arguments:
%     [1] - threshold for suppression of weak(er) boxes
%
fprintf('\n*****************************************************************')
fprintf('\n**** Start Tud-Brussels ACF roi detection/extraction script. ****')
fprintf('\n*****************************************************************')

%% setup toolboxes paths
[root_path] = add_paths_toolboxes();

%% initializations/parse input arguments
% acf threshold
if nargin > 0
    if ~isempty(varargin{1}),
        cascThr = varargin{1};
    else
        cascThr = -1;
    end
else
    cascThr = -1;
end

% acf calibration 
if nargin > 1
    if ~isempty(varargin{2}),
        cascCal = varargin{2};
    else
        cascCal = .025;
    end
else
    cascCal = .025;
end

%% load options
[model] = acf_options_process('tudbrussels');

%% configs
skip_step = 1;
savename_ext = strcat('_skip=',num2str(skip_step), '_thresh=', num2str(abs(cascThr)), '_cal=', num2str(abs(cascCal)), '.mat');
dataset_name = 'Tud-Brussels';
save_path = strcat(root_path, '/data/',dataset_name,'/proposals/');
dataset_path = strcat(root_path, '/data/',dataset_name,'/extracted_data/');

%% create directory
if(~exist(save_path,'dir')), mkdir(save_path); end

%% Train set
path_train = {strcat(dataset_path, 'set00/')};

%% process ACF roi boxes
fprintf('\nProcess ACF roi boxes for the training/testing set:')
boxes = acf_process_detections(path_train, skip_step, model, strcat(dataset_name, ' Train'), cascThr, cascCal);

%% store to file
save_boxes(boxes, strcat(save_path, 'ACF_',dataset_name,'TrainTest', savename_ext))
% Note: both are the same because the same data can be used for
% tes/benchmarking or for augmenting an already existing dataset with this
% extra data.

%% script complete
fprintf('\n---------------------------------------------------')
fprintf('\nTud-Brussels ACF boxes processing script completed.')
fprintf('\n---------------------------------------------------\n')
end