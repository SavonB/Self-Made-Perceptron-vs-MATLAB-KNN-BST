function bestk = findBestKNN(TRAIN)
%Input is the training set
%It is split in between development and training
%smallest Hyperparameter k with the lowest error is returned

bestk = 0;
error = 1;
[M,N] = size(TRAIN);
[TRAIN,DEV] = splitData(TRAIN);
x = TRAIN(:,1:N-1);
y = TRAIN(:,N);


%Going from k = 1 to 15 we create a model and check the error on the
%development set. We return the k with the lowest error
for k = 1:15
    model = fitcknn(x,y,'NumNeighbors',k);
    
    predicted_output = model.predict(DEV(:,1:N-1));
    curr_error = findError(predicted_output,DEV(:,N));
    if curr_error < error
        error = curr_error;
        bestk = k;
    end
    
end
end
