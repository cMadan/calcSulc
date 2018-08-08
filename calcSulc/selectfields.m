function out = selectfields(in,fieldnames)
% Preserve only specified fields from a struct.
%
% 20180806 CRM

out = [];
if iscell(fieldnames)
    for i = 1:length(fieldnames)
        out = setfield(out,fieldnames{i},getfield(in,fieldnames{i}));
    end
else
    out = setfield(out,fieldnames,getfield(in,fieldnames));
end