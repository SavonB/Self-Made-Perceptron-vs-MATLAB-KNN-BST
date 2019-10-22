function model_output = PredictedOutput(model, TEST)

%predicted output takes in a model (knn, perceptron, decision tree) and runs it on the
%test set to compute the error

[M,N] = size(TEST);
model_output = [];

        for row = 1:M
            model_output = [model_output;perceptronTest(model,TEST(row,:))];
        end
    

    
end