class = 1;
d = raw_data(raw_data(1:end,end) == class,:);
close
figure
%plot(d(:,1), d(:,2))

findpeaks(d(:,2), d(:,1))
hold on
[Maxima,MaxIdx] = findpeaks(input);
DataInv = 1.01*max(input) - input;
%[Minima,MinIdx] = findpeaks(DataInv);
%findpeaks(DataInv)