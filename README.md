# ImageProcessing
MATLAB scripts for analysis of confocal microscopy images
++++++++++++++++++++++++++++++++++++++++++++++++
HiLo.m
Performs lowpass and highpass filtering for noise reduction
++++++++++++++++++++++++++++++++++++++++++++++++

++++++++++++++++++++++++++++++++++++++++++++++++
ExtractNuclei.m
Identifies and enumerates nuclei in a DAPI image
++++++++++++++++++++++++++++++++++++++++++++++++

++++++++++++++++++++++++++++++++++++++++++++++++
IntegrateFociIntensity.m
Loops through all nuclei in an image and accumulates pixel intensity in the non-DAPI (e.g. FITC) channel
++++++++++++++++++++++++++++++++++++++++++++++++

++++++++++++++++++++++++++++++++++++++++++++++++
IntegrateFociIntensity_Wrapper.m
Processes a series of images with IntegrateFociIntensity
++++++++++++++++++++++++++++++++++++++++++++++++
