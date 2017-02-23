function [X_train, y_train, X_test, y_test] = load_data(file_name, train_num, test_num, is_rand)
	X = csvread(file_name);
	if is_rand
		num = size(X, 1)
		indexes = randsample([1:num], train_num + test_num);
		train_index = indexes(1:train_num);
		test_index = indexes(train_num + 1:end);
		X_train = X(train_index, 2:end);
		y_train = X(train_index, 1);
		X_test = X(test_index, 2:end);
		y_test = X(test_index, 1);
	else
		X_train = X(1:train_num, 2:end);
		y_train = X(1:train_num, 1);

		X_test = X(train_num + 1:train_num + test_num, 2:end);
		y_test = X(train_num + 1:train_num + test_num, 1);
	end