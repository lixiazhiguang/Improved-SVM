eps = 1e-6;
train_num = 100;

M = rand(train_num, train_num) * 1;
y = rand(train_num, 1);
a = rand(train_num, 1);

yes = 0;
no = 0;
for i = linspace(-10, 10, 21)
	i
	m = power(10, i);
	for j = linspace(1, 1000, 1000)
		n = rand() * 10;
		p = m * n;
		alpha = rand();
		theta1 = rand(train_num, 1) * p;
		theta2 = rand(train_num, 1) * p;
		theta = alpha * theta1 + (1 - alpha) * theta2;
		L1 = compute(y, M, theta1, a);
		L2 = compute(y, M, theta2, a);
		L = compute(y, M, theta, a);
		if (alpha * L1 + (1 - alpha) * L2 + eps >= L)
			yes = yes + 1;
		else
			no = no + 1;
		end
	end
end
yes
no

function LL = compute(y, M, tt, a)
	LL = y.' * exp(M .* tt.') * a;
end