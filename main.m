clear
close all

% Use full paths when possible to be robust
filename = mfilename('fullpath');
filepath = fileparts( filename );

addpath([filepath '/mesh2d']); initmsh();

% Medium-scale high-geometric-complexity aeropropulsive problem %%%%%%%%%%%%%%
surfaceFiles = {'onr-dep/mainVec20.dat','onr-dep/nacelleVec20.dat'};

for i = numel(surfaceFiles):-1:1
    fid = fopen([filepath '/airfoils/' surfaceFiles{i}],'r');
    surfaces{i} = cell2mat(textscan(fid,'%f%f','Delimiter',{'\t',','}));
    fclose(fid);
end


% Solve
opts.NumPanels = 200; % optionally pass options to the wake solver
opts.ConvergenceCriterion = 2;
[Cp,xc] = panel2d(surfaces,5,1,0.8,opts,'Plot','on');


% Plot Cp distributions
figure;
hold on;
for i = 1:numel(Cp)
    plot(xc{i},Cp{i})
end
set(gca,'YDir','reverse')