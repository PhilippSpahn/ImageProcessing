function HiLo(basename,a_low,a_high,n,m,channel)

% APPLIES LOWPASS/HIGHPASS FILTERING TO IMAGE SERIES
%
% basename:                 Basename of data series
% a_low:                    Lowpass parameter (typically 1-4)
% a_high:                   Highpass parameter (typically 500-5000)
% n:                        Which frame to start
% m:                        Which frame to stop
% channel:                  Which channel? ('ch00'/'ch01')
%
% ============================================================


for i = n:m
    if i<=9
        name = strcat(basename,'_Series00',int2str(i),'_',channel,'.tif');
    elseif i <= 99
        name = strcat(basename,'_Series0',int2str(i),'_',channel,'.tif');
    else
        name = strcat(basename,'_Series',int2str(i),'_',channel,'.tif');
    end;
    A = imread(name);
    At = lowpass(A,a_low);
    Ah = highpass(At,a_high);
    name_output = strcat('hilo_',name);
    imwrite(Ah,name_output,'TIF');    
    figure; imshow(Ah);
    if m-n > 0
        close all;
    end;
end;

end