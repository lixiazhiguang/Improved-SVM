function a = solve_a(y, a, u, P, rho)
	e_abs = 1e-3;
	e_rel = 1e-3;
	b = a;
	p = sqrt(length(b));
	n = sqrt(length(b));

	[a, b, u, r, s] = iter_a(y, a, b, u, P, rho);

	disp('r = ' + string(norm(r)) + ', s =' + string(norm(s)))
	e_pri = p * e_abs + e_rel * max(norm(P * a .* y), norm(b));
	e_dual = n * e_abs + e_rel * norm(P * u .* y);

	while norm(r) > e_pri || norm(s) > e_dual
        b1 = norm(r) / e_pri;
        b2 = norm(s) / e_dual;
		if b1 > 1e1 * b2
			rho = rho * 2;
            u = u / 2;
        elseif b1 < 1e-1 * b2
            rho = rho / 2;
            u = u * 2;
        else
            rho = rho;
            u = u;
        end
		[a, b, u, r, s] = iter_a(y, a, b, u, P, rho);

		disp('r = ' + string(norm(r)) + ', s =' + string(norm(s)))
		e_pri = p * e_abs + e_rel * max(norm(P * a .* y), norm(b));
		e_dual = n * e_abs + e_rel * norm(P * u .* y);
	end
