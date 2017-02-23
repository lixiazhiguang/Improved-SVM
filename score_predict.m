function score = score_predict(test_num, prediction, truth, method)
	prediction(prediction >= 0) = 1;
	prediction(prediction < 0) = -1;
	if strcmp(method, 'error')
		score = 1 - sum(prediction == truth, 1) / test_num;
	elseif strcmp(method, 'recall')
		num_1 = sum(truth > 0);
		num_0 = sum(truth < 0);
		recall_1 = sum(prediction == 1) / num_1;
		recall_0 = sum(prediction == -1) / num_0;
		score = (num_1 * recall_1 + num_0 * recall_0) / test_num;
	elseif strcmp(method, 'precision')
		num_1 = sum(prediction == 1);
		num_0 = sum(prediction == -1);
		precision_1 = sum(truth == 1) / num_1;
		precision_0 = sum(truth == -1) / num_0;
		score = (num_1 * precision_1 + num_0 * precision_0) / test_num;
	else
		score = test_num - sum(prediction == truth);
	end
end