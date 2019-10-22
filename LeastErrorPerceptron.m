function bestperceptron = LeastErrorPerceptron(TRAIN,numSplits)
%Input is the training set and the number of splits for
%cross validation on perceptron 

[M,N] = size(TRAIN);
bestperceptron = zeros(1,N);
besterror = .5;


    for x = 1:numSplits
    %take the data and randomize it
    %and divide it into two pieces
    %one that is the first row to the (Numsplits-1)/Numsplits*M
    %the other is (Numsplits-1)/Numsplits*M + 1 to M
        TRAIN = TRAIN(randperm(size(TRAIN, 1)), :);
        randTRAIN = TRAIN(1:(numSplits-1)/numSplits*M,:);
        randDEV = TRAIN(((numSplits-1)/numSplits*M) + 1:M,:);
        perceptron = PerceptronTrain(randTRAIN);
        predicted_output = PredictedOutput(perceptron,randDEV);
        currerror = findError(predicted_output,randDEV(:,N));

        %I allow <= instead of < so that i may get a different perceptron
        %with the same error
        if currerror <= besterror
                besterror = currerror;
                bestperceptron = perceptron;
        else
            continue
        end
    end


        

end