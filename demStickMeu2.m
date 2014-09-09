% DEMSTICKMEU2 Model the stick man with MEU using 6 neighbors and two dimensional base distribution.

% MEU

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'stick';
experimentNo = 2;

% load data
[Y, lbls] = lvmLoadData(dataSetName);
meanY = mean(Y);
Y = Y - repmat(meanY, size(Y, 1), 1);

% Set up model
latentDim = 2;
options = meuOptions(6, 0, true);
options.gammaOptimize = false;
d = size(Y, 2);
model = meuCreate(latentDim, d, Y, options);
%model.gamma = 1e4;
%model.X
% Optimise the model.
iters = 1000;
display = 3;

model = meuOptimise(model, display, iters);

if exist('printDiagram') & printDiagram
  lvmPrintPlot(model, lbls, dataSetName, experimentNo);
else
  clf;
  lvmScatterPlot(model, lbls);
end
fprintf('Scoring model.\n');
model.lambda = eig(model.K)/trace(model.K);
model.score = lvmScoreModel(model);
fprintf('Model score %2.4f\n', model.score);

% Save the results.
modelWriteResult(model, dataSetName, experimentNo);

