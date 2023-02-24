format long
observation = cell2mat(struct2cell(load("observation_R5_L40_N100_K21.mat")));
pts = cell2mat(struct2cell(load("pts_R5_L40_N100_K21.mat")));
dist = cell2mat(struct2cell(load("dist_R5_L40_N100_K21.mat")));
gt = cell2mat(struct2cell(load("gt_R5_L40_N100_K21.mat")));

lambda = 0.1;
alpha = 0.1;
num_markers = 100;
num_iterations = 100;
rmse = 0;
K= 21;
initial_guess_matrix = mean(pts,1);
r = zeros(K,1);
J_k = zeros(K,3);
summation = zeros(3,1);
p = reshape(permute(initial_guess_matrix,[1 2 3]),100,3);
p_hat_k = permute(pts,[2,3,1]);
gradient = zeros(3,1);
H = zeros(3,3);
error = 0;
p_new = zeros(1,3);
for marker = 1:num_markers
    for iteration = 1:num_iterations
        p(marker,:) = [1 1 1];
        for obs_point = 1:K
            %initial guess of point p
            pqDiff = p(marker,:)-observation(obs_point,:);
            J_k(obs_point,:) = pqDiff'/(norm(pqDiff));
            r(obs_point,:) = norm(pqDiff)-dist(marker,obs_point);
            summation = summation + (2*(p(marker,:)-p_hat_k(marker,:,obs_point)))';
        %         r = sqrt((p-observation)'*(p-observation))-dist(marker,obs_point);
        end
        gradient = J_k'*r + lambda*(summation);
        H=J_k'*J_k + 2*lambda*K*eye(3);
        p_new = p(marker,:) - (alpha*(H\gradient))';
        error = abs((p_new-p(marker,:))/p_new)*100;
%         fprintf("Marker %d, Iteration %d, Error: %f\n",marker, iteration, error);
        if iteration > 1
            p(marker,:) = p_new;
        end
        if error < 7e-7
            break;
        end
    end
    rmse = norm(p(1,:)-gt(1,:))^2;
end
rmse = sqrt(rmse/100);

% 
% for marker = 1:num_markers
%     % Initial estimate of p for this marker using one of three methods
%     % available, stored in the variable p_hat
%     
%     
%     % Newton loop
%     for iteration = 1:num_iterations
%         % Initialize J, r, and summation term
%         J = zeros(3);
%         r = zeros(3, 1);
%         sum_term = 0;
%         
%         % Iterate over the 21 observation points
%         for obs_point = 1:21
%             % Calculate delta
%             delta = p_hat - observation(obs_point, :);
%             distance = dist(marker, obs_point);
%             
%             % Calculate J (eq 6)
%             J = J + (delta' * delta + distance^2) * eye(3) - 2 * delta' * delta;
%             
%             % Calculate r (eq 3)
%             r = r + (norm(delta)^2 - distance^2) * delta';
%             
%             % Calculate summation term in eq 7
%             sum_term = sum_term + delta / (norm(delta) * (norm(delta) - distance));
%         end
%         
%         % Calculate g (eq 9)
%         g = lambda * p_hat + sum_term';
%         
%         % Calculate H (eq 10)
%         H = lambda * eye(3) + J - 2 * lambda * eye(3) * norm(g)^2 / (g' * g);
%         
%         % Update estimate of p (eq 12)
%         p_hat = p_hat - H \ g;
%     end
%     
%     % Calculate RMSE (eq 13)
%     diff = p_hat - gt(marker, :);
%     rmse = rmse + norm(diff)^2;
% end
% 
% % Finalize RMSE calculation (eq 13)
% rmse = sqrt(rmse / (num_markers * 3));