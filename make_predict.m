function prediction = make_predict(X1, X2, theta, a)
	X1_2 = sum(power(X1, 2), 2);
	X2_2 = sum(power(X2, 2), 2);
	X_X = X1 * X2.';
	M = 2 * X_X - X1_2 - X2_2.';
	P = exp(M .* theta.');

	prediction = P * a;
