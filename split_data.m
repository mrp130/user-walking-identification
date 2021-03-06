n_file = 25;
for split_second = 2:30
    raw_data = [];
    data = [];
    for i = 1:n_file
        filepath = strcat('data/', num2str(i), '.csv');
        file_data = csvread(filepath);
        file_data = [ file_data zeros(size(file_data,1),4) ];
        for j = fliplr( 2:size(file_data,1) )
            time_diff = file_data(j, 1) - file_data(j-1, 1);
            for k = 2:4
                file_data(j, k+3) = (file_data(j, k) - file_data(j-1, k)) / time_diff;
            end
            file_data(j, end) = time_diff;
        end
        file_data(1,:) = [];
        file_data = [ file_data (ones(size(file_data,1),1) *  i) ];
        raw_data = [raw_data; file_data];


    %     slice_size = floor(raw_data(end,1) / slice_second);
    %     slice_cycle = floor(size(raw_data,1)/slice_size);
    %     

        second = 0;
        slice_second = split_second;
        max_sec = raw_data(end,1);
        while second < max_sec
            disp(sprintf('computing data:%d/%d second:%d/%d split:%d', i, n_file, second, floor(max_sec), slice_second));
            input = [];
            for j = 2:7
                s = find(raw_data(:,1) >= second);
                s = s(1);
                e = find(raw_data(:,1) >= second + slice_second);

                if isempty(e)
                   second = max_sec;
                   break
                end

                e = e(1);

                d = raw_data( s : e , :);
                if length(d(:,j)) < 3
                   break 
                end
                [~,MaxIdx] = findpeaks( d(:,j) );
                DataInv = 1.01*max( d(:,j) ) - d(:,j);
                [~,MinIdx] = findpeaks(DataInv);

                if MaxIdx(1) > MinIdx(1)
                   MinIdx(1) = [];
                end

                if MaxIdx(end) > MinIdx(end)
                   MaxIdx(end) = [];
                end
                diffs = zeros(length(MaxIdx)-1,3);

                for k = 2:min([length(MaxIdx) length(MinIdx)])
                   diffs(k-1,1) = d(MaxIdx(k),1) - d(MaxIdx(k-1),1);
                   diffs(k-1,2) = d(MaxIdx(k),j) - d(MaxIdx(k-1),j);
                   diffs(k-1,3) = d(MinIdx(k),j) - d(MinIdx(k-1),j);
                end
                diffs = abs(diffs);
                if k > 2
                    diffs = mean(diffs);
                end
                input = [input, diffs];
            end

            if second ~= max_sec
                input = [input i];
                data = [data; input];
            end
            second = second + slice_second;
        end
    end 
    save(strcat('data',num2str(slice_second),'s.mat'), 'data');
    csvwrite(strcat('data',num2str(slice_second),'s.csv'), data);
end

