function [TRAIN,TEST] = splitData(ALLDATA)

%Takes the data and seperates it into a 20/80 split. Decided on a 20/80
%split instead of a variable one because there was no increase in
%performance for any model with a different split.
%RETURNS training set and test set
[M,N] = size(ALLDATA)
    ALLDATA = ALLDATA(randperm(size(ALLDATA, 1)), :);
    TRAIN = ALLDATA(1:.8*M,:);
    TEST = ALLDATA(.8*M+1:M,:)
end