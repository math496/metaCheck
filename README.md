# metaCheck
metadata checker for image files
Efron: 2/8/2016: Currently, this only works with a hardcoded list of arguments. It SHOULD work with a variable list of arguments and default to the current case, i.e:

function [metaOut] = metaCheck(filename, varargin)
assert(nargin <= 2, 'metaCheck has at most two input parameters')
if nargin == 1
    editStrings = defaultEditStrings;
else
    editStrings = varargin;
end

But this is not working because MATLAB handles variable arguments as cells and there are weird C-based typechecking things buried deep in there that I don’t understand and are messing things up. (Yes, real detailed, I know.) I’ve been working on this, but it’s taken me longer than writing the original program and I’m no closer than when I started. Not sure where to go from here.
