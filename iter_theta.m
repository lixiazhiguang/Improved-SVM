function [s, theta, v, rr, ss] = iter_theta(y, a, M, theta, s, v, beta)
	old_s = s;

	lambda = 1e-12;
	temp_P = exp(M .* theta.');
	temp = temp_P * a .* y - s + v;
	f = -y.' * temp_P * a + beta / 2 * temp.' * temp;
	last_f = 1000000;

	renew = true;
	direc = 1;
	while lambda > 1e-18 && (last_f - f > 1e-6 || f > last_f)
		temp_P = exp(M .* theta.');
		g = beta * (temp_P .* M).' * (temp_P * a - (v - s - 1 / beta) .* y) .* a;
		% g = beta * M * (exp(M .* theta.') * a + (v - s) .* y) .* a;
		theta = theta - lambda * g * direc;
		% theta(theta<0) = 0;
		if renew == true
			last_f = f;
		end
		temp_P = exp(M .* theta.');
		temp = temp_P * a .* y - s + v;
		f = -y.' * temp_P * a + beta / 2 * temp.' * temp;
		if f > last_f
			theta = theta + lambda * g * direc;
			lambda = lambda / 2;
			renew = false;
		else
			% f
			% theta(theta<0) = 0;
			renew = true;
		end
	end

	new_ = exp(M .* theta.') * a .* y;
	s = new_ + v;% - 1 / beta;
	s(s < 0) = 0;

	rr = new_ - s;
	ss = (s - old_s);

	v = v + new_ - s;
end