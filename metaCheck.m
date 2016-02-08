function [metaOut] = metaCheck(filename, varargin)
%% Function Description:
%{
MATLAB script by Efron Licht, last modified 2/8/2016. Requires
efron_StructFind. Based off StructFind by Alexander Mering in 2012.
Loads metadata as a MATLAB structure, then recursively checks the
property names and associated properties for matches with the strings in
 editStrings, which is a list of the most common photo editing software.

INPUT:
    filename is a STRING: i.e, 'pathname/suspiciousFile.jpg'
    varargin is the list of suspicious strings as a cell. if varargin is
    left blank, editStrings defualts to 
metaOut returns 0 if no hits, else returns [1, %hits in names, %hits in
properties]
%}


%% cell array of the most common image editing software:
defaultEditStrings = sort({'adobe photoshop' 'adobe' ...
    'aperture borderfx' 'ashampoo photo commander' 'bibble'  ...
    'capture nx' 'capture one' 'coachware' 'copiks photomapper' ...
    'digikam' 'digital photo prop' 'gimp' 'www.idimager.com'  ...
    'imagenomic noiseware' 'imageready' 'kipi' ... 
    'microsoft' 'paint.net' 'paint shop pro' 'paint shop pro photo' ...
    'irfanview' 'photoscape' 'photowatermark' 'photo plus' ...
    'photo impact' 'photoimpact' 'photo shop' 'photo editor' 'acdsee' ...
    'acdsee photo editor' 'photodirector ultra'  'photo direcor' ...
    'photo director ultra' 'photo lightning' 'photo lightning' ...
    'photopad' 'photo pad' 'picasa' 'picnik' 'quicktime' ...
    'watermark' 'photoshop express' 'snapseed' 'pixlr' ...
    'picsart photo studio'});
%% handle optional input parameters
assert(nargin <= 2, 'metaCheck has at most two input parameters')
if nargin == 1
    editStrings = defaultEditStrings;
else
    editStrings = varargin;
    disp(editStrings)
end



info = imfinfo(filename);
name =  fieldnames(info);
%[pathstr, shortName, ext] = fileparts(filename);
nameHits = []; propHits = [];
%% Check Metadata names:
    for i=1:length(name)
        for j=1:length(editStrings)
            if isequal(lower(name), lower(editStrings{j}))
               nameHits = strcat(editStrings{j});
            end
        end
    end
 %% Check Metadata properties:
 propHits = efron_StructFind(info, editStrings);
 
 %% test output
 testOut = [nameHits, propHits];
 if isempty(testOut)
     metaOut = 0;
 else
     metaOut = [1, testOut];
 end