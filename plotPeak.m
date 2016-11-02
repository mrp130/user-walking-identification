class = 2;
d = data(data(1:end,end) == class,:);
close
figure
plot(d(:,3))

% findpeaks(d(:,2), d(:,1))
hold on
[Maxima,MaxIdx] = findpeaks(input);
DataInv = 1.01*max(input) - input;
%[Minima,MinIdx] = findpeaks(DataInv);
%findpeaks(DataInv)