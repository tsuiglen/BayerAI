%Glen Tsui, 400201284, tsuig
%3SK3 Project 1

%Initialize decimal display formatting and number of terms
format long
n = 1000000000;
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

fprintf('Total computed sum after 1000000000 terms: %f\n', single(total));
fprintf('Matlab reference (ground truth): %f\n', single(log(2)));
fprintf('Calculated True Error: %f\n', single(abs(log(2)-total)));
function sum = quarterSum(start,finish)
    %initialize
    sum = 0.0;
    %for the ranges of the quarter section submitted
    for i = start:finish
        %determine whether this term should be added or subtracted
        sign = single((-1.0)^(i-1));
        %add the term with the sign to the running total
        sum = single((sum) + sign * (1/i));
    end
end