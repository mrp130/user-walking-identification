data = [];
for i = 1:22
    filepath = strcat('data/', num2str(i), '.csv');
    file_data = csvread(filepath);
%     file_data = [ file_data zeros(size(file_data,1),1) ];
%     for j = fliplr( 2:size(file_data,1) )
%         file_data(j, end) = file_data(j, 1) - file_data(j-1, 1);
%         for k = 2:size(file_data,2)-1
%             file_data(j, k) = (file_data(j, k) - file_data(j-1, k)) / file_data(j, end);
%         end
%     end
    file_data(1,:) = [];
    file_data = [ file_data (ones(size(file_data,1),1) *  i) ];
    data = [data; file_data];
end

close
figure
class = 1;
d = data(data(:,end) == class,:);
input = euc2d( d(:,2:4) );
input = data(data(:,end) == class,4);
output = data(:,end);
output(output ~= class) = 0;
plot(d(1:end,1),input(1:end))
% figure
% 
% class = 1;
% input = euc2d( data(data(:,end) == class,2:4) );
% %input = data(data(:,end) == class,4);
% output = data(:,end);
% output(output ~= class) = 0;
% 
% subplot(3,1,class)
% plot(input(2200:2400))
% 
% class = 2;
% input = euc2d( data(data(:,end) == class,2:4) );
% %input = data(data(:,end) == class,4);
% output = data(:,end);
% output(output ~= class) = 0;
% 
% subplot(3,1,class)
% plot(input(2200:2400))
% 
% class = 3;
% input = euc2d( data(data(:,end) == class,2:4) );
% %input = data(data(:,end) == class,4);
% output = data(:,end);
% output(output ~= class) =  0;
% 
% subplot(3,1,class)
% plot(input(600:800))

%options = optimset('MaxIter',1000000);
%svmStruct = svmtrain(input, output, 'ShowPlot', true, 'options', options);