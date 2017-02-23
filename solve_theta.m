function theta = solve_thete(y, a, M, theta, v, beta)
	e_abs = 1e-4;
	e_rel = 1e-4;
	s = exp(M .* theta.') * a .* y;
	p = sqrt(length(theta));
	n = sqrt(length(theta));

	[s, theta, v, rr, ss] = iter_theta(y, a, M, theta, s, v, beta);
	disp('rr = ' + string(norm(rr)) + ' , ss = ' + string(norm(ss)))
	P = exp(M .* theta.');
	e_pri = p * e_abs + e_rel * max(norm(s), norm(P * a .* y));
	e_dual = n * e_abs + e_rel * norm(v);

	while norm(rr) > e_pri || norm(ss) > e_dual
		beta = beta * 1.2;
		[s, theta, v, rr, ss] = iter_theta(y, a, M, theta, s, v, beta);
		disp('rr = ' + string(norm(rr)) + ' , ss = ' + string(norm(ss)))
		P = exp(M .* theta.');
		e_pri = p * e_abs + e_rel * max(norm(s), norm(P * a .* y));
		e_dual = n * e_abs + e_rel * norm(v);
	end