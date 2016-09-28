function dist = euc2d( input )
    dist = zeros(size(input,1),1);
    for i = 1:size(input,1)
       dist(i) = sum(input(i,:) .^ 2) .^ 0.5;
    end

end

