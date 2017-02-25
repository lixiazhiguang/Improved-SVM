function [a, b, u, r, s] = iter_a(y, a, b, u, P, rho)
% 	fuck1 = -y.' * P * a + rho / 2 * (a - b + u).' * (a - b + u)
% 
% 	a = P.' * y / rho + b - u;
% 	a = a / (a.' * y);
% 	fuck2 = -y.' * P * a + rho / 2 * (a - b + u).' * (a - b + u)
% 
% 	old_b = b;
% 	b = a + u;
% 	b(b .* y <= 0) = 0;
% 	b = b / (b.' * y);
% 	b = b - ((b.' * y) - 1) / sum(b ~= 0) .* (b ~= 0) .* y;
% 	fuck3 = -y.' * P * a + rho / 2 * (a - b + u).' * (a - b + u)
% 
% 	r = a - b;
% 	u = u + r;
% 	s = rho * (b - old_b);


	Hessian = rho * (P.' * P);
	tau = norm(Hessian);

    grad_a = rho * P.' * (P * a + (u - b - 1 / rho) .* y);
    a = a - 1 / tau * grad_a;
    a(a .* y < 0) = 0;
    a = a / (a.' * y);
%     a = a / norm(a, 1);

	new_b = P * a .* y + u;
	new_b(new_b < 0) = 0;

	s = rho * (P.' .* y) * (new_b - b);
	b = new_b;

	r = P * a .* y - b;
	u = u + rho * r;
end


