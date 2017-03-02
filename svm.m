function prediction = svm(train_num, X_train, y_train, X_test)
    [a, u, rho, M, theta, v, beta] = initial_value(train_num, X_train, y_train);

    e_a = 1e-6;
    e_theta = 1e-2;
    lambda = 5 * 1e-2;
    min_lambda = 1 * 1e-3;
    iter_time = 3;

    for iter = 1:iter_time
        disp('iter ' + string(iter) + ' start');
        ''
        P = exp(M .* theta.');
        a = solve_a(y_train, a, u, P, rho, e_a, e_a);
        theta = solve_theta(y_train, a, M, theta, v, beta, e_theta, e_theta);
        disp('iter ' + string(iter) + ' end');
        ''
    end

    prediction = make_predict(X_test, X_train, theta, a);
end
