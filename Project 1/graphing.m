%Glen Tsui, 400201284, tsuig
%3SK3 Project 1

%Initialize decimal display formatting and number of terms
format long
%Iterate through the n terms
for n = 1:100000
    %parallel processor 1 computes quarterSum for first term to quarter way
    parallel_processor_1 = quarterSum(1,floor(n/4));
    %parallel processor 2 computes quarterSum for the first term at quarter
    %way to halfway.
    parallel_processor_2 = quarterSum(floor(n/4)+1,floor(n/2));
    %parallel processor 3 computes quarterSum for first term at halfway to
    %three-quarter way
    parallel_processor_3 = quarterSum(floor(n/2)+1,floor(3*n/4));
    %parallel processor 4 computes quarterSum for first term at
    %three-quarter way to the final n term.
    parallel_processor_4 = quarterSum(floor(3*n/4)+1,floor(n));
    
    %all values are converted to type single and totalled to give the
    %overall sum of the series
    total = single(parallel_processor_1) + single(parallel_processor_2) + single(parallel_processor_3) + single(parallel_processor_4);
    %the true error is calculated by calculating the difference between the
    %true value of the series sum and the computed total.
    error = abs(log(2)-single(total));
    %generate plot for first 1000 terms
    if(n<=1000)
        plot(n,error,'--.'); hold on
    %generate plot for every 1000th term after 1000 terms
    elseif (n<=100000)
        if(mod(n,1000)==0)
            plot(n,error,'--.'); hold on
        end
    end
end
%plotting parameters
figure(1);
title('Numerical Error vs. Number of Terms');
xlabel('Number of Terms N');
ylabel('Numerical Error');
xlim([0 100000])
ylim([0 0.4])

function sum = quarterSum(start,finish)
    %initialize
    sum = 0.0;
    %for the ranges of the quarter section submitted
    for i = start:finish
        %determine whether this term should be added or subtracted
        sign = (-1.0)^(i-1);
        %add the term with the sign to the running total
        sum = single(sum + (sign * (1/i)));
    end
end