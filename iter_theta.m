function [s, theta, v, rr, ss] = iter_theta(y, a, M, theta, s, v, beta)
	P = exp(M .* theta.');
    Q = P .* M;
    Hessian = beta * (a * a.') .* (Q.' * Q);
    tau = norm(Hessian);
    
	grad_theta = beta * Q.' * (P * a + (v - s - 1 / beta) .* y) .* a;
	theta = theta - 1 / tau * grad_theta;
	theta(theta<0) = 0;
    size(theta(theta>0))

	P = exp(M .* theta.');
    Q = P .* M;
    
	new_s = P * a .* y + v;
	new_s(new_s < 0) = 0;
    size(new_s(new_s>0))
    
    ss = beta * (a * y.' .* Q.') * (new_s - s);
    s = new_s;
    
    rr = P * a .* y - s;
    v = v + beta * rr;
end