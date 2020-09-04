function IntegrateFociIntensity_Wrapper(basename,range,T0)

% basename:	base image filename
% range:		range in image series (e.g. 1:10)
% T0:         intensity threshold for nucleus identification 
%                   (default: 32)


n = 0; % number of nuclei (accumulated over all images)

for j = range
    if j<10
        imagename = [basename '_Series00' int2str(j)];
    else
        imagename = [basename '_Series0' int2str(j)];
    end;
    [Area_j,Total_j,Intensity0_j,MaxIntensity] = ...
        IntegrateFociIntensity(imagename,T0,false);
    n_j = length(Intensity0_j);    
    for i = 1:n_j
        ResultsArray{n+i,1} = imagename;
        ResultsArray{n+i,2} = i;
        ResultsArray{n+i,3} = Area_j(i);
        ResultsArray{n+i,4} = Total_j(i);
        ResultsArray{n+i,5} = Intensity0_j(i);
        ResultsArray{n+i,6} = MaxIntensity(i);
    end;
    n = n + n_j;
end;

ResultsTable = cell2table(ResultsArray,'VariableNames',...
    {'Image','Nucleus','Area','Intensity','Intensity_norm','Max'});
writetable(ResultsTable,[basename '_Intensities.csv']);

end