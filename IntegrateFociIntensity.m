function [NucArea,TotalIntensity,Intensity_0,MaxIntensity] = ...
    IntegrateFociIntensity(imagename,T0,WriteResults)

% imagename: 	image filename (not including "_ch0x.tif")
% T0:         intensity threshold for nucleus identification 
%                   (default: 32)
% WriteResults:	write results to disk (true/false)

AreaMin = 1000;       % Nuclear area lower threshold
fsz = 40;           % font-size in nucleus annotation image
ShowImages = false; % Do not display images

% Read images
fprintf('\n');
fprintf(['Processing sample' ' ' imagename '...\n']);
fprintf('---------------------------------------\n');
A_dapi = imread(['hilo_' imagename '_ch00.tif']);
A_488 = imread([imagename '_ch01.tif']);
% Segment DAPI channel
Nuclei = (A_dapi >= T0);
% Detect individual Nuclei
Nuclei = bwmorph(Nuclei,'clean');
Nuclei = imclearborder(Nuclei);
[component,Nx] = bwlabel(Nuclei);
Nuclei_annot = uint8(255*Nuclei);
% Loop through individual nuclei
N = 0;              % Number of nuclei (Nx may include artefacts)
for k=1:Nx
    fprintf(['Analyzing nucleus #' int2str(k) ' ' '...\n']);
    C = (component == k);
    Stats = regionprops(C);    
    if Stats.Area>=AreaMin 
        N = N+1;
        Nucleus_k = (component == k);
        Stats = regionprops(Nucleus_k);
        x = round(Stats.Centroid(1)); y = round(Stats.Centroid(2));
        Index = int2str(N);
        Nuclei_annot = insertText(Nuclei_annot,[x-20,y-20],Index,'TextColor','red',...
            'FontSize',fsz,'BoxOpacity',0);
        NucArea(N) = Stats.Area;
        % Extract 488 channel
        A_488_k = A_488(any(Nucleus_k,2),any(Nucleus_k,1));        
        TotalIntensity(N) = sum(sum(A_488_k));
        Intensity_0(N) = TotalIntensity(N)/NucArea(N);
        MaxIntensity(N) = max(max(A_488_k));
    else
        fprintf(['Area out of bounds: Discarding nucleus #' int2str(k) ' ' '...\n']);
    end;
end;
% Write nuclei enumeration image
ImTitle = strcat(imagename,'_ch00_seg');
if ShowImages
    figure('Position',[100 100 700 500]); 
    imshow(A_dapi,'InitialMagnification','Fit');
    title(imagename);
    figure('Position',[900 100 700 500]); 
    imshow(Nuclei_annot,'InitialMagnification','Fit');
    title(ImTitle);
end;
imwrite(Nuclei_annot,strcat(ImTitle,'.jpg'),'jpg');
% Write reults table (optional)
if WriteResults
    Results = [double((1:N)') double(NucArea') double(TotalIntensity')...
        double(Intensity_0') double(MaxIntensity')];
    ResultsTable = array2table(Results);
    ResultsTable.Properties.VariableNames = ...
        {'Nucleus','Area','Intensity','Intensity_norm','Max'};    
    writetable(ResultsTable,[imagename '.csv']);
end;

end