train_file = 'csv/train_1_7_10000.csv';
train_num = 1000;
test_num = 5000;
[X_train, y_train, X_test, y_test] = load_data(train_file, train_num, test_num, false);
[a, u, rho, M, theta, v, beta] = initial_value(train_num, X_train, y_train);
P = exp(M .* theta.');

prediction_train = make_predict(X_train, X_train, theta, a);
train_score = score_predict(train_num, prediction_train, y_train, '');

prediction_test = make_predict(X_test, X_train, theta, a);
test_score = score_predict(test_num, prediction_test, y_test, '');

disp('train err: ' + string(train_score) + ', test err: ' + string(test_score));

aim_func = -y_train.' * P * a

e_a = 1e-6;
e_theta = 1e-2;
lambda = 5 * 1e-2;
min_lambda = 1 * 1e-3;

iter_time = 3;
for i = 1:iter_time
	P = exp(M .* theta.');
	a = solve_a(y_train, a, u, P, rho, e_a, e_a);
    aim_func = -y_train.' * P * a;

%     rho = rho / 2;
%     u = u * 2;
%     e_a = e_a * 0.8;

	theta = solve_theta(y_train, a,  M, theta, v, beta, e_theta, e_theta, lambda);
	P = exp(M .* theta.');
	aim_func = -y_train.' * P * a

%     beta = beta / 2;
%     lambda = lambda / 2;
%     v = v * 2;
%     e_theta = e_theta * 0.8;

end

prediction_train = make_predict(X_train, X_train, theta, a);
train_score = score_predict(train_num, prediction_train, y_train, '');

prediction_test = make_predict(X_test, X_train, theta, a);
test_score = score_predict(test_num, prediction_test, y_test, '');

disp('train err: ' + string(train_score) + ', test err: ' + string(test_score));
