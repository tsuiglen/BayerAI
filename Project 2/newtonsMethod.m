format long
observation = cell2mat(struct2cell(load("observation_R5_L40_N100_K21.mat")));
pts = cell2mat(struct2cell(load("pts_R5_L40_N100_K21.mat")));
dist = cell2mat(struct2cell(load("dist_R5_L40_N100_K21.mat")));
gt = cell2mat(struct2cell(load("gt_R5_L40_N100_K21.mat")));
lambda = 0.1;
alpha = 0.1;
num_markers = 100;

K= 21;

minCoord = [0 1];
lambdaRange = 0.01:0.001:0.1;
rmseVec = zeros(1,numel(lambdaRange));
for lambdaIter = lambdaRange
    lambda = lambdaIter;
    num_iterations = 100;
    rmse = 0;
    initial_guess_matrix = mean(pts,1);
    r = zeros(K,1);
    J_k = zeros(K,3);
    summation = zeros(3,1);
    p = reshape(permute(initial_guess_matrix,[1 2 3]),100,3);
    % p = repmat([4.99452688890729	8.27791765851492	0.233882782568621],100,1);
    % p = randn(100,3);
    p_hat_k = permute(pts,[2,3,1]);
%     gradient = zeros(3,1);
%     H = zeros(3,3);
%     error = 0;
%     p_new = zeros(1,3);
    for marker = 1:num_markers
        for iteration = 1:num_iterations
            for obs_point = 1:K
                %initial guess of point p
                pqDiff = p(marker,:)-observation(obs_point,:);
                J_k(obs_point,:) = pqDiff'/(norm(pqDiff));
                r(obs_point,:) = norm(pqDiff)-dist(marker,obs_point);
                summation = summation + (2*(p(marker,:)-p_hat_k(marker,:,obs_point)))';
            %         r = sqrt((p-observation)'*(p-observation))-dist(marker,obs_point);
            end
%             gradient = J_k'*r + lambda*(summation);
%             H=J_k'*J_k + 2*lambda*K*eye(3);
            gradient = J_k'*r + lambdaIter*(summation);
            H=J_k'*J_k + 2*lambdaIter*K*eye(3);
            p_new = p(marker,:) - (alpha*(H\gradient))';
%             error = abs((p_new-p(marker,:))/p_new)*100;
    %         fprintf("Marker %d, Iteration %d, Error: %f\n",marker, iteration, error);
%             if iteration > 1
            p(marker,:) = p_new;
%             end
%             if error < 1e-9
%                 break;
%             end
        end
        rmse = rmse + (norm(p(marker,:)-gt(marker,:)))^2;
    end
    rmse = sqrt(rmse/100);
    rmseVec(end+1) = rmse;
    if(rmse<minCoord(2))
        minCoord(2) = rmse;
        minCoord(1) = lambdaIter;
    end


end

figure(1);
title('Converged RMSE vs. Lambda');
xlabel('Lambda');
ylabel('Converged RMSE');
plot(lambdaRange,rmseVec);
