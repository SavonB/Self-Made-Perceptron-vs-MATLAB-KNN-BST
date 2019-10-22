function weights = PerceptronAMP(TRAIN,timesAMP)

%Takes the training set and copies it timesAMP times
%and creates a perceptron from that

finaltrain = [];
for x = 1:timesAMP
    finaltrain = [finaltrain;TRAIN];
end
weights = PerceptronTrain(finaltrain);
end