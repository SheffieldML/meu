function w = bllePosteriorSamp(A, C, numSamps)

numSamps = 1;
sorth = randn(size(C, 1), numSamps);
spar = rayleighSamp(1, 1)
onesVec = ones(size(C, 1), 1);
[Sigma, U] = pdinv(pdinv(A) + C);
invU = U\eye(size(A, 1));
d = invU'*onesVec/(sqrt(sum(sum(Sigma))));
s = sorth - sorth'*d*d +spar*d;
w = invU*s;