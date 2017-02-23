function a = solve_a(y, a, u, P, rho)
	e_abs = 1e-3;
	e_rel = 1e-3;
	b = a;
	p = sqrt(length(b));
	n = sqrt(length(b));

	% fuck = -y.' * P * a
	[a, b, u, r, s] = iter_a(y, a, b, u, P, rho);
	% rr = norm(r)
	% ss = norm(s)
	disp('r = ' + string(norm(r)) + ', s =' + string(norm(s)))
	e_pri = p * e_abs + e_rel * max(norm(a), norm(b));
	e_dual = n * e_abs + e_rel * norm(u * rho);

	% return

	while norm(r) > e_pri || norm(s) > e_dual
		if rho < 1e3
			rho = rho * 1.2;
		end
		% fuck = -y.' * P * a
		[a, b, u, r, s] = iter_a(y, a, b, u, P, rho);
		% rr = norm(r)
		% ss = norm(s)
		disp('r = ' + string(norm(r)) + ', s =' + string(norm(s)))
		e_pri = p * e_abs + e_rel * max(norm(a), norm(b));
		e_dual = n * e_abs + e_rel * norm(u * rho);
		% size(b(b>0))
	end
