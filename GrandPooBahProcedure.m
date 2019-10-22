%This procedure will create 3 models
%a perceptron
%a knn model
%a decision tree model

%during creation/training of each model we explore hyperparameters to optimize the
%model (k for knn, average weights for perceptron)
%we use cross validation of training set to select hyperparameters for 

%After having 3 fully fleshed models we can compare them to one another by
%testing them on the final test

%return final model that most accurately classifies the data

%make the data usable

FULL_DATASET = cleanData();
RESTORED = FULL_DATASET;
SINGLECOLSET = FULL_DATASET(:,6:7); %the column least correlated with the others

%During feature engineering I used lasso regression it was found that Length,
%left width, and right width were highly correlated with diagonality thus i removed them
%from the dataset


%creation of 4 datasets one that uses TOP MARGIN,BOT MARGIN, and DIAG
%length as it's features. One that uses a normalized version of that
%another that uses exclusively Diagonality as a feature, and finally the
%full dataset (RESTORED).

FULL_DATASET = FULL_DATASET(:,4:7);
NORMALSET = normalize(FULL_DATASET);


[TRAIN,TEST] = splitData(FULL_DATASET);
[RTRAIN,RTEST] = splitData(RESTORED);
[STRAIN,STEST] = splitData(SINGLECOLSET);
[NTRAIN,NTEST] = splitData(NORMALSET);

%We will create the perceptron and use cross validation to find the best
%weights. The actual perceptron is just a row vector of weights and the
%last column is the bias

%2 methods of training a perceptron
%Trained by cross validating a perceptron, then using it on development set
%do that for a set number of perceptrons, and select the one with the least
%error

%The other method is by creating a normal percetron through cross
%validating, but instead of selecting the least error among many
%perceptrons you only use 1 and feed it an amplified dataset, copied many
%times over before being mixed randomly.
[M,N] = size(TRAIN);
perceptron_model = LeastErrorPerceptron(TRAIN,10); %The function implements the cross validation
ampedperceptron = PerceptronAMP(TRAIN,10);
[pm,pn] = size(perceptron_model)

%Through experimenting i found a bias > 0 to nearly guarantee error above
%.5 so i wanted to eliminate a positive bias, without limiting the bias
%from being a positive number
while perceptron_model(1,pn) >= 1
        perceptron_model = LeastErrorPerceptron(TRAIN,10);
end

%We will explore finding the best k for this model by running in a loop
%over many ks on the TRAINING/DEVELOPMENT data and then plotting their
%average errors and selecting the best
%k value determined by lowest average error over set number of tests
%We then use that k for the final model
bestklist = [];
for i = 1:10
bestklist = [bestklist,findBestKNN(TRAIN)];
end
bestk = mode(bestklist);
knn_model = fitcknn(TRAIN(:,1:3),TRAIN(:,4),'NumNeighbors',bestk);


%we will create a decision tree on the full data set or the one after
%feature engineering, experimentation proved no matter how many features
%included with tree, it would only use DIAGONAL length, top margin
ctree = fitctree(TRAIN(:,1:3),TRAIN(:,4));
ctree.view;

%Compare optimized models to one another
%produce all of their respective output columns (class names for test set)
%Then find the error of each one
perceptron_out = PredictedOutput(perceptron_model,TEST); 
perceptron_out = PredictedOutput(ampedperceptron,TEST);
knn_out = knn_model.predict(TEST(:,1:N-1));
ctree_out = ctree.predict(TEST(:,1:N-1));
test_out = TEST(:,4)

p_error = findError(perceptron_out,test_out)%perceptron error
k_error = findError(knn_out,test_out) %knn error
t_error = findError(ctree_out,test_out)%tree error

%using error as a metric