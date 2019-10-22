function isReal = perceptronTest(perceptron,TESTexample)
%PERCEPTRONTEST takes a single just 1 only 1 row as a test example and
%computes it activation. It returns the classification for the row.
%must be run in loop for entire test set.
%Rationale behind loop was i wanted error to be handled elsewhere so it
%would aggregate anything necessary.
[M,N] = size(perceptron)
a= 0
            
                a = a+ (perceptron(1:N-1).*TESTexample(1:N-1))+perceptron(1,N);
            
            if a <= 0
                isReal = -1;
            else
                isReal = 1;
            end
            
end