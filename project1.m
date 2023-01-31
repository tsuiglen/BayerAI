format long
for n = 1:100000000
    parallel_processor_1 = quarterSum(1,floor(n/4));
    parallel_processor_2 = quarterSum(floor(n/4)+1,floor(n/2));
    parallel_processor_3 = quarterSum(floor(n/2)+1,floor(3*n/4));
    parallel_processor_4 = quarterSum(floor(3*n/4)+1,floor(n));

    total = parallel_processor_1 + parallel_processor_2 + parallel_processor_3 + parallel_processor_4;
    error = abs(log(2)-total);
    if(n<=300)
        plot(n,error,'--.'); hold on
    elseif (n<=10000)
        if(mod(n,1000)==0)
            plot(n,error,'--.'); hold on
        end
    elseif (n<=1000000)
        if(mod(n,100000)==0)
            plot(n,error,'--.'); hold on
        end
    elseif (n<=1000000000)
        if(mod(n,100000000)==0)
            plot(n,error,'--.'); hold on
        end
    end
end
figure(1);
title('Numerical Error vs. Number of Terms');
xlabel('Number of Terms N');
ylabel('Numerical Error');
single(log(2))
single(total)
log(2)
total

function sum = quarterSum(start,finish)
    sum = 0.0;
    for i = start:finish
        sign = (-1.0)^(i-1);
        sum = sum + (sign * (1/i));
    end
end