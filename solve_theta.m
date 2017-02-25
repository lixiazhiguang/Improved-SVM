function theta = solve_theta(y, a, M, theta, v, beta)
	e_abs = 1e-2;
	e_rel = 1e-2;
	s = exp(M .* theta.') * a .* y;
	p = sqrt(length(theta));
	n = sqrt(length(theta));

	[s, theta, v, rr, ss] = iter_theta(y, a, M, theta, s, v, beta);
    
	disp('rr = ' + string(norm(rr)) + ' , ss = ' + string(norm(ss)))
	P = exp(M .* theta.');
    Q = P .* M;
	e_pri = p * e_abs + e_rel * max(norm(P * a .* y), norm(s));
	e_dual = n * e_abs + e_rel * norm((a * y.' .* Q.') * v);
    
    tau = 1.2;

	while norm(rr) > e_pri || norm(ss) > e_dual
        b1 = norm(rr) / e_pri;
        b2 = norm(ss) / e_dual;
		if b1 > 1e1 * b2
			beta = beta * tau;
            v = v / tau;
        elseif b1 < 1e-1 * b2
            beta = beta / tau;
            v = v * tau;
        else
            beta = beta;
            v = v;
        end
        beta
		[s, theta, v, rr, ss] = iter_theta(y, a, M, theta, s, v, beta);
        
		disp('rr = ' + string(norm(rr)) + ' , ss = ' + string(norm(ss)))
		P = exp(M .* theta.');
		e_pri = p * e_abs + e_rel * max(norm(s), norm(P * a .* y));
		e_dual = n * e_abs + e_rel * norm(v);
	end