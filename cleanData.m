function data = cleanData()
%CLEANDATA just takes the file and cleans it up for use in the program
    %it converts the column 'real' and fake to 1 and -1 as well as
    %randomizing them
    %FILE MUST GO THROUGH THIS FUNCTION BEFORE USE


data = importdata('currencytrain.csv');
data.textdata(1,:) = [];
data.data(1,7) = 0; %adds additional col


[m,n] = size(data.data);
        for row = 1:m 
            %if real then put 1 in the rows last column else -1
                if data.textdata{row,1} == 'real'
                    data.data(row,7) = 1;
                else
                    data.data(row,7) = -1;
                end
                      
        end
        randomsort = data.data(randperm(size(data.data, 1)), :)
        data = randomsort;
end
