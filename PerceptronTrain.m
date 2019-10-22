function weights = PerceptronTrain(TRAIN)

%PERCEPTRONTRAIN arg1 = the test set arg2 = max iter
%   The perceptron train takes in the test set and the number of times
%   we want to iterate through the test before returning the vector of
%   weights (output argument1) and the bias (output arg 2)
%   for love of god say remember 1/-1 not 1/0

[M,N] = size(TRAIN);
weights = zeros(1,N-1);
Y = TRAIN(:,N);
bias = 0;
a = 0;
        
                for row = 1:M %check each row to see if adjustment in
                               %weights and bias is needed
                        
                        for col = 1:N-1 %compute the activation
                            a = a+ (weights(1,col)*TRAIN(row,col));
                        end
                        a = a+bias;
                        
                        if Y(row,1)*a <= 0 %updates all weights and biases
                                for weight = 1:N-1
                                    weights(1,weight) = weights(1,weight) + Y(row,1)*TRAIN(row,weight);
                                    bias = bias + Y(row,1);
                                    
                                end
                        else
                            continue;
                        end
                end%Reached last row
       

weights = weights;
weights = [weights,bias];

end

