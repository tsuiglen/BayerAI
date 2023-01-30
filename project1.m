format long
n = 4;

quarter = n/4;
half = n/2;
three_quarters = 3*n/4;
parallel_processor_1 = quarterSum(1,n/4);
parallel_processor_2 = quarterSum((n/4)+1,n/2);
parallel_processor_3 = quarterSum((n/2)+1,3*n/4);
parallel_processor_4 = quarterSum((3*n/4)+1,n);

total = parallel_processor_1 + parallel_processor_2 + parallel_processor_3 + parallel_processor_4;
log(2)
single(total)

function sum = quarterSum(start,finish)
    sum = 0.0;
    for i = start:finish
        sign = (-1.0)^(i-1);
        sum = sum + (sign * (1/i));
    end
end