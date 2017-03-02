train_file = 'csv/mnist_train.csv'
test_file = 'csv/mnist_test.csv'

train_num = 100;
test_num = 10000;
class_num = 10;

Mat_train = csvread(train_file);
Mat_test = csvread(test_file);
X_train_all = Mat_train(:, 1:end);
y_train_all = Mat_train(:, 1);
X_test = Mat_test(:, 1:end);
y_test = Mat_test(:, 1);

Vote = zeros(test_num, class_num);

for i = 1:class_num
    i = i % 10;
    X1 = X_train_all(y_train_all == i);
    X1 = X1(1:train_num, :);
    y1 = ones(train_num, 1);
    for j = i:class_num
        j = j % 10;
        disp(string(i) + ' ' + string(j) + ' start');
        ''
        X2 = X_train_all(y_train_all == j);
        X2 = X2(1:train_num, :);
        y2 = -ones(train_num, 1);

        X_train = [X1, X2];
        y_train = [y1, y2];

        prediction = svm(train_num, X_train, y_train, X_test)

        Vote(:, i) = Vote(:, i) + prediction;
        Vote(:, j) = Vote(:, j) - prediction);
        disp(string(i) + ' ' + string(j) + ' end');
    end
end

[times, prediction] = max(Vote, [], 2);
error = sum(prediction ~= y_test)
