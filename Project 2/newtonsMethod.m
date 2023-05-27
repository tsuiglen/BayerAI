format long
%import datasets
observation = cell2mat(struct2cell(load("observation_R5_L40_N100_K21.mat")));
pts = cell2mat(struct2cell(load("pts_R5_L40_N100_K21.mat")));
dist = cell2mat(struct2cell(load("dist_R5_L40_N100_K21.mat")));
gt = cell2mat(struct2cell(load("gt_R5_L40_N100_K21.mat")));

%initialize maximums for loops
num_markers = 100;
K= 21;

%initialize optimized lambda and minimum RMSE
minCoord = [0 1];
i = 1;

%define lambda ranges
% lambdaRange = 0.001:0.001:0.1;
lambdaRange = 0.00016:0.001:1.6;

%define rmse vector
rmseVec = [0];

%define iteration range
iterationRange = 1:200;
% for lambdaIter = lambdaRange

%define which iteration it converges and a flag for convergence
convIt = 0;
convergedYet = 0;

%define random vector
randomVector = randn(100,3);

%loop through each iteration
for itTest = iterationRange
    %define initial values
    lambda = 0.016;
    alpha = 0.1;
    num_iterations = 50;
    J_k = zeros(K,3);
    r = zeros(K,1); 
    summation = zeros(3,1);
    %average value
    initial_guess_matrix = mean(pts,1);
%     p = reshape(permute(initial_guess_matrix,[1 2 3]),100,3);
    %Observation Point 10, Marker 10
    p = repmat([4.745082966818472   4.392986439435905   1.403062456466428],100,1);
    %random value
%     p = randomVector;
    %measured values
    p_hat_k = permute(pts,[2,3,1]);
    %reset rmse
    rmse = 0;
    %for each of every 100 marker
    for marker = 1:num_markers
        %for every iteration up to limit
        for iteration = 1:itTest
            %for every 21 observations
            for obs_point = 1:K
                %initial guess of point p
                pqDiff = p(marker,:)-observation(obs_point,:);
                %calculate Jacobian
                J_k(obs_point,:) = pqDiff'/(norm(pqDiff));
                %calculate residual
                r(obs_point,:) = norm(pqDiff)-dist(marker,obs_point);
                %calculate latter summation part of gradient
                summation = summation + (2*(p(marker,:)-p_hat_k(marker,:,obs_point)))';
            %         r = sqrt((p-observation)'*(p-observation))-dist(marker,obs_point);
            end
            %calculate gradient
            gradient = J_k'*r + lambda*(summation);
            %calculate Hessian
            H=J_k'*J_k + 2*lambda*K*eye(3);
            %determine new p value
            p_new = p(marker,:) - (alpha*(H\gradient))';
%             error = abs((p_new-p(marker,:))/p_new)*100;
%             if error > 0.00001
%                 flag = 1;
%             end
            %set the matrix value to the new p value
            p(marker,:) = p_new;
            %reset summation for next run through
            summation = zeros(3,1);
%             if flag == 0
%                 break;
%             end
            
    %         fprintf("Marker %d, Iteration %d, Error: %f\n",marker, iteration, error);
            
        end
        %calculate summation part of rmse
        rmse = rmse + norm(p(marker,:)-gt(marker,:))^2;
    end
    %compute rmse for the iteration
    rmse = sqrt(rmse/100);
    %add rmse to the vector
    rmseVec(i)=rmse;
    %increment loop
    i=i+1;
    %if the rmse value is below minimum, set as new min
%     if(rmse<minCoord(2))
%         minCoord(2) = rmse;
%         minCoord(1) = lambdaIter;
%     end
    %if rmse is below minimum rmse it has converged
    if(rmse<=0.0246 && convergedYet == 0)
        %log the coordinates
        convIt = itTest;
        convergedYet = 1;
    end
% end
end

% plot(lambdaRange,rmseVec);
% title('Converged RMSE vs. Lambda [Op_Lambda/100, 100*Op_Lambda]');
% xlabel('Lambda');
% ylabel('Converged RMSE');
% figure(1);

plot(iterationRange,rmseVec);
title('RMSE vs. Iterations [Random Method, Lambda = 0.016]');
xlabel('Number of Iterations');
ylabel('RMSE');
figure(1);

convIt