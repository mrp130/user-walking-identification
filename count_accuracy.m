function acc = count_accuracy( matrix )
    acc = (matrix(1,1) + matrix(2,2)) / sum(sum(matrix));
end