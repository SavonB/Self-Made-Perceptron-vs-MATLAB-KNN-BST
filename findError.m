function err = findError(predicted_output, actual_output)

%FINDERROR given the models predicted output and the actual classification
%of the test set, we return the error.
%MUST RUN PREDICTED OUTPUT FIRST

correct = 0;
[M,N] = size(predicted_output);
    for element = 1:size(predicted_output)
        if predicted_output(element,1) == actual_output(element,1);
            correct = correct+1;
        end
    end
    err = 1- (correct/M);
end