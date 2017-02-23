function [a, b, u, r, s] = iter_a(y, a, b, u, P, rho)
	% fuck1 = -y.' * P * a + rho / 2 * (a - b + u).' * (a - b + u)

	a = P.' * y / rho + b - u;
	% a = a / (a.' * y);
	% fuck2 = -y.' * P * a + rho / 2 * (a - b + u).' * (a - b + u)

	old_b = b;
	b = a + u;
	b(b .* y <= 0) = 0;
	b = b / (b.' * y);
	% b = b - ((b.' * y) - 1) / sum(b ~= 0) .* (b ~= 0) .* y;
	% fuck3 = -y.' * P * a + rho / 2 * (a - b + u).' * (a - b + u)

	r = a - b;
	u = u + r;
	s = rho * (b - old_b);

	% 回溯搜索
	% diff = 10;
	% step = 1e-6;
	% old_a = a;

	% while diff.' * diff > 1e-6
	% 	step = 1e-6;
	% 	temp = P * old_a .* y - b + u;
	% 	old_obj = - y.' * P * old_a + rho / 2 * temp.' * temp

	% 	grad_a = - P.' * y + rho * P.' * (P * old_a - (b - u) .* y);

	% 	new_a = old_a - step * grad_a;
	% 	temp = P * new_a .* y - b + u;
	% 	new_obj = - y.' * P * new_a + rho / 2 * temp.' * temp;

	% 	while new_obj > old_obj + 0.2 * step * grad_a.' * (-grad_a)
	% 		step = step * 0.5;
	% 		new_a = old_a - step * grad_a;
	% 		temp = P * new_a .* y - b + u;
	% 		new_obj = - y.' * P * new_a + rho / 2 * temp.' * temp;
	% 	end
	% 	diff = new_a - old_a;
	% 	old_a = new_a;
	% 	diff.' * diff
	% end

	% a = old_a;


	% 取L
	% PP = rho * P.' * P;
	% L = max(eig(PP));
	% diff = 10;
	% old_a = a;
	% % temp = P * old_a .* y - b + u;
	% % old_obj = - y.' * P * old_a + rho / 2 * temp.' * temp

	% while norm(diff) / norm(old_a) > 1e-2
	% 	grad_a = - P.' * y + rho * P.' * (P * old_a - (b - u) .* y);

	% 	new_a = old_a - 1 / L * grad_a;
	% 	% temp = P * new_a .* y - b + u;
	% 	% new_obj = - y.' * P * new_a + rho / 2 * temp.' * temp

	% 	new_a = new_a / norm(new_a);
	% 	% new_a(new_a .* y < 0) = 0;
	% 	diff = new_a - old_a;
	% 	old_a = new_a;
	% 	% old_obj = new_obj;
	% end
	% a = old_a;

	% new_b = P * a .* y + u;
	% new_b(new_b < 0) = 0;

	% s = rho * P.' * (new_b - b) .* y;
	% b = new_b;

	% r = P * a .* y - b;
	% u = u + rho * r;
end
