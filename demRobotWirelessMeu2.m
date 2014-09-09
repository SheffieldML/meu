% DEMROBOTWIRELESSMEU2 Model the stick man with MEU using 7 neighbors.

% MEU

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'robotWireless';
experimentNo = 2;

% load data
[Y, lbls] = lvmLoadData(dataSetName);
meanY = mean(Y);
Y = Y - repmat(meanY, size(Y, 1), 1);

% Set up model
latentDim = 2;
options = meuOptions(7, 0, true);

d = size(Y, 2);
model = meuCreate(latentDim, d, Y, options);

% Optimise the model.
iters = 2000;
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
