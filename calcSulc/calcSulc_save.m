if isfield(output,'fname')
    % replace unallowed characters
    sulcnames = output.list_sulc;
    sulcnames = strrep(sulcnames,'&','');
    sulcnames = strrep(sulcnames,'-','');
    sulcnames = [strcat('lh_',sulcnames) strcat('rh_',sulcnames)];
    
    % write sulci width csv
    tbl = array2table(output.sulci_width,'VariableNames',sulcnames);
    tbl = [table(output.list_subject','VariableNames',{'subID_calcSulc'}) tbl];
    writetable(tbl,[output.fname '_sulciwidth.csv']);
    
    % write sulci depth csv
    tbl = array2table(output.sulci_depth,'VariableNames',sulcnames);
    tbl = [table(output.list_subject','VariableNames',{'subID_calcSulc'}) tbl];
    writetable(tbl,[output.fname '_sulcidepth.csv']);
end