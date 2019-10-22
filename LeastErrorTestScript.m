%Least error perceptron distribution
%This script creates a perceptron on each of the different types of
%datasets. It then graphs the distribution of different errors for analysis
%of the error over different versions of the same model.


FULL_DATASET = cleanData();
RESTORED = FULL_DATASET;
SINGLECOLSET = FULL_DATASET(:,6:7); %the column least correlated with the others

FULL_DATASET = FULL_DATASET(:,4:7);
NORMALSET = normalize(FULL_DATASET);

[TRAIN,TEST] = splitData(FULL_DATASET);
[RTRAIN,RTEST] = splitData(RESTORED);
[STRAIN,STEST] = splitData(SINGLECOLSET);
[NTRAIN,NTEST] = splitData(NORMALSET);

[M,N] = size(TRAIN);
errorlist1 = [];
errorlist2 = [];
errorlist3 = [];

%Creates perceptrons based on the feature engineered training set
for x = 1:100
    perceptron_model = LeastErrorPerceptron(TRAIN,10);
    pred = PredictedOutput(perceptron_model,TEST)
    error = findError(pred, TEST(:,4));
    errorlist1 = [errorlist1, error];
end

%creates perceptrons based on the normalized training set
for x = 1:100
    perceptron_model = LeastErrorPerceptron(NTRAIN,10);
    pred = PredictedOutput(perceptron_model,NTEST)
    error = findError(pred, NTEST(:,4));
    errorlist2 = [errorlist2, error];
end

%creates perceptrons based on initial training set
for x = 1:100
    perceptron_model = LeastErrorPerceptron(RTRAIN,10);
    pred = PredictedOutput(perceptron_model,RTEST)
    error = findError(pred, RTEST(:,4));
    errorlist3 = [errorlist3, error];
end
h = histfit(errorlist1,100);
i = histfit(errorlist2,100);
j = histfit(errorlist3,100);
disp(h)
disp(i)
disp(j)
