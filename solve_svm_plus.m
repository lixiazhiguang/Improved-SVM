train_file = 'csv/train_1_7_10000.csv';
train_num = 1000;
test_num = 1000;
[X_train, y_train, X_test, y_test] = load_data(train_file, train_num, test_num, false);
[a, u, rho, M, theta, v, beta] = initial_value(train_num, X_train, y_train);
P = exp(M .* theta.');

prediction_train = make_predict(X_train, X_train, theta, a);
train_score = score_predict(train_num, prediction_train, y_train, '');
disp('train err: ' + string(train_score))

iter_time = 1;
for i = 1:iter_time
	% aim_func = -y_train.' * P * a
	% theta = solve_theta(y_train, a, M, theta, v, beta);
	P = exp(M .* theta.');
	aim_func = -y_train.' * P * a
	a = solve_a(y_train, a, u, P, rho);

	theta = solve_theta(y_train, a, M, theta, v, beta);
	P = exp(M .* theta.');
	aim_func = -y_train.' * P * a
end

prediction_train = make_predict(X_train, X_train, theta, a);
train_score = score_predict(train_num, prediction_train, y_train, '');

prediction_test = make_predict(X_test, X_train, theta, a);
test_score = score_predict(test_num, prediction_test, y_test, '');

disp('train err: ' + string(train_score) + ', test err: ' + string(test_score));