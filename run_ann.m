clear;
clc;

train_acc = zeros(30,30);
test_acc = zeros(30,30);
val_acc = zeros(30,30);
all_acc = zeros(30,30);

for i = 1:30
    for second = 2:30
        load(strcat('data', num2str(second), 's.mat'));

        class = 25;
        input = data(:,1:end-1);
        output = data(:,end);

        output(output ~= class,1) = 0;
        output(output == class,1) = 1;

        output = output(:,1);

        class_idx = find(output == 1);
        copy_n = floor(length(data) / length(class_idx));
        input = [input; resample(input(class_idx,:), copy_n, 1) ];
        output = [output; repmat(output(class_idx,:), copy_n, 1) ];

        neural;

        trainTargets = t .* tr.trainMask{1};
        valTargets = t .* tr.valMask{1};
        testTargets = t .* tr.testMask{1};

        [~,cm,~,~] = confusion(trainTargets,y);
        train_acc(second,i) = count_accuracy(cm);

        [~,cm,~,~] = confusion(valTargets,y);
        val_acc(second,i) = count_accuracy(cm);

        [~,cm,~,~] = confusion(testTargets,y);
        test_acc(second,i) = count_accuracy(cm);

        [~,cm,~,~] = confusion(t,y);
        all_acc(second,i) = count_accuracy(cm);
    end
end