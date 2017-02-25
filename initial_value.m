function [a, u, rho, M, theta, v, beta] = initial_value(train_num, X_train, y_train)
	a = y_train / sum(y_train);
%     a = a / norm(a, 1);
	u = ones(train_num, 1) * 1e-3;
	rho = 1e0;

	X_2 = sum(power(X_train, 2), 2);
	X_X = X_train * X_train.';
	M = 2 * X_X - X_2 - X_2.';

	temp = sort(-M, 2);
	temp = temp(:, 1:11);
	theta_f = mean(temp, 2);
	theta = 1.0 ./ theta_f;

	v = ones(train_num, 1) * 1e-3;
	beta = 1e-4;