original_image = double(imread('LebronJames.jpg'));
[RGGB,GBRG,GRBG,BGGR] = mosaic(original_image);
[x,y,~] = size(original_image);

original_image2 = double(imread('bing.png'));
[RGGB2,GBRG2,GRBG2,BGGR2] = mosaic(original_image2);
[x2,y2,~] = size(original_image2);

original_image3 = double(imread('tomato.png'));
[RGGB3,GBRG3,GRBG3,BGGR3] = mosaic(original_image3);
[x3,y3,~] = size(original_image3);
% 
test_image1 = double(imread('test1.png'));
[t1_x,t1_y,~] = size(test_image1);
test_image2 = double(imread('test2.png'));
[t2_x,t2_y,~] = size(test_image2);
% figure(1);
% mRGGB = uint8(RGGB);
% subplot(2,2,1),imshow(mRGGB);
% title('RGGB Mosaic')
% mGRBG = uint8(GRBG);
% subplot(2,2,2),imshow(mGRBG);
% title('GRBG Mosaic')
% mGBRG = uint8(GBRG);
% subplot(2,2,3),imshow(mGBRG);
% title('GRBG Mosaic')
% mBGGR = uint8(BGGR);
% subplot(2,2,4),imshow(mBGGR);
% title('BGGR Mosaic')
% 
% figure(2);
% dRGGB = demosaic(mRGGB,'rggb');
% %disp(num2str(calcRMSE(original_image,dRGGB)));
% subplot(2,2,1),imshow(dRGGB);
% title("RGGB MATLAB Demosaic, RMSE: "+calcRMSE(original_image,dRGGB));
% dGRBG = demosaic(mGRBG,'grbg');
% subplot(2,2,2),imshow(dGRBG);
% title("GRBG MATLAB Demosaic, RMSE: "+calcRMSE(original_image,dGRBG));
% dGBRG = demosaic(mGBRG,'gbrg');
% subplot(2,2,3),imshow(dGBRG);
% title("GBRG MATLAB Demosaic, RMSE: "+calcRMSE(original_image,dGBRG));
% dBGGR = demosaic(mBGGR,'bggr');
% subplot(2,2,4),imshow(dBGGR);
% title("BGGR MATLAB Demosaic, RMSE: "+calcRMSE(original_image,dBGGR));
% 
% [A_RGGB_G,A_RGGB_B,A_GBRG_R,A_GBRG_B,A_GRBG_R,A_GRBG_B,A_BGGR_R,A_BGGR_G] = LLSP(original_image,x,y,RGGB);

%%%%%%COMMENT%%%%%%%
mRGGB = uint8(RGGB);
dRGGB = demosaic(mRGGB,'rggb');
output_image = computeOutput(A_RGGB_G,A_RGGB_B,A_GBRG_R,A_GBRG_B,A_GRBG_R,A_GRBG_B,A_BGGR_R,A_BGGR_G, RGGB, x, y);
output_image2 = computeOutput(A_RGGB_G,A_RGGB_B,A_GBRG_R,A_GBRG_B,A_GRBG_R,A_GRBG_B,A_BGGR_R,A_BGGR_G, RGGB2, x2, y2);
output_image3 = computeOutput(A_RGGB_G,A_RGGB_B,A_GBRG_R,A_GBRG_B,A_GRBG_R,A_GRBG_B,A_BGGR_R,A_BGGR_G, RGGB3, x3, y3);
test_output_image_1 = computeOutput(A_RGGB_G,A_RGGB_B,A_GBRG_R,A_GBRG_B,A_GRBG_R,A_GRBG_B,A_BGGR_R,A_BGGR_G, test_image1, t1_x, t1_y);
test_output_image_2 = computeOutput(A_RGGB_G,A_RGGB_B,A_GBRG_R,A_GBRG_B,A_GRBG_R,A_GRBG_B,A_BGGR_R,A_BGGR_G, test_image2, t2_x, t2_y);
figure(3);
subplot(1,2,1),imshow(uint8(output_image));
imwrite(uint8(output_image), "output.png");
title("RGGB Custom Demosaic, RMSE: "+calcRMSE(original_image,output_image));
subplot(1,2,2),imshow(dRGGB);
title("RGGB MATLAB Demosaic, RMSE: "+calcRMSE(original_image,dRGGB));

figure(4);
subplot(1,2,1),imshow(uint8(test_output_image_1));
imwrite(uint8(test_output_image_1), "test_output1.png");
title("RGGB Custom Demosaic");
subplot(1,2,2),imshow(demosaic(uint8(test_image1),'rggb'));
title("RGGB MATLAB Demosaic");
% 
figure(5);
subplot(1,2,1),imshow(uint8(test_output_image_2));
imwrite(uint8(test_output_image_2), "test_output2.png");
title("RGGB Custom Demosaic");
subplot(1,2,2),imshow(demosaic(uint8(test_image2),'rggb'));
title("RGGB MATLAB Demosaic");

figure(6);
subplot(1,2,1),imshow(uint8(output_image2));
imwrite(uint8(output_image2), "output2.png");
title("RGGB Custom Demosaic, RMSE: "+calcRMSE(original_image2,output_image2));
subplot(1,2,2),imshow(demosaic(uint8(RGGB2),'rggb'));
title("RGGB MATLAB Demosaic, RMSE: "+calcRMSE(original_image2,demosaic(uint8(RGGB2), 'rggb')));

figure(7);
subplot(1,2,1),imshow(uint8(output_image3));
imwrite(uint8(output_image3), "output3.png");
title("RGGB Custom Demosaic, RMSE: "+calcRMSE(original_image3,output_image3));
subplot(1,2,2),imshow(demosaic(uint8(RGGB3),'rggb'));
title("RGGB MATLAB Demosaic, RMSE: "+calcRMSE(original_image3,demosaic(uint8(RGGB3),'rggb')));

% [A_RGGB_G,A_RGGB_B,A_GBRG_R,A_GBRG_B,A_GRBG_R,A_GRBG_B,A_BGGR_R,A_BGGR_G] = LLSPDIV2K();
% [A_RGGB_G,A_RGGB_B,A_GBRG_R,A_GBRG_B,A_GRBG_R,A_GRBG_B,A_BGGR_R,A_BGGR_G] = calculateA(X_RGGB,GT_G1,GT_B1,X_GBRG,GT_R1,GT_B2,X_GRBG,GT_R2,GT_B3,X_BGGR,GT_R3,GT_G2);
% output_image = computeOutput(A_RGGB_G,A_RGGB_B,A_GBRG_R,A_GBRG_B,A_GRBG_R,A_GRBG_B,A_BGGR_R,A_BGGR_G, test_image1, t1_x, t1_y);
% imshow(uint8(output_image));

function [RGGB,GBRG,GRBG,BGGR] = mosaic(original_image)
    [x,y,~] = size(original_image);
    %disp([x,y,z]);
    %imshow(original_image(:,:,3));
    RGGB = zeros(x,y);
    GBRG = zeros(x,y);
    GRBG = zeros(x,y);
    BGGR = zeros(x,y);
    
    for i = 1:x
        for j = 1:y
            if mod(i,2)==0
                if mod(j,2)==0
                    RGGB(i,j) = original_image(i,j,3);
                    GBRG(i,j) = original_image(i,j,2);
                    GRBG(i,j) = original_image(i,j,2);
                    BGGR(i,j) = original_image(i,j,1);
                else
                    RGGB(i,j) = original_image(i,j,2);
                    GBRG(i,j) = original_image(i,j,1);
                    GRBG(i,j) = original_image(i,j,3);
                    BGGR(i,j) = original_image(i,j,2);
                end
            else
                if mod(j,2)==0
                    RGGB(i,j) = original_image(i,j,2);
                    GBRG(i,j) = original_image(i,j,3);
                    GRBG(i,j) = original_image(i,j,1);
                    BGGR(i,j) = original_image(i,j,2);
                else
                    RGGB(i,j) = original_image(i,j,1);
                    GBRG(i,j) = original_image(i,j,2);
                    GRBG(i,j) = original_image(i,j,2);
                    BGGR(i,j) = original_image(i,j,3);
                end
            end
        end
    end
end

function [A_RGGB_G,A_RGGB_B,A_GBRG_R,A_GBRG_B,A_GRBG_R,A_GRBG_B,A_BGGR_R,A_BGGR_G] = LLSP(original_image,x,y,mosaic)
    pad = 2;
    ximg_min = 1+pad;
    ximg_max = x-pad;
    yimg_min = 1+pad;
    yimg_max = y-pad;
    X_RGGB = zeros(25,0);
    X_GBRG = zeros(25,0);
    X_GRBG = zeros(25,0);
    X_BGGR = zeros(25,0);
    GT_G1 = zeros(1,0);
    GT_G2 = zeros(1,0);
    GT_R1 = zeros(1,0);
    GT_R2 = zeros(1,0);
    GT_R3 = zeros(1,0);
    GT_B1 = zeros(1,0);
    GT_B2 = zeros(1,0);
    GT_B3 = zeros(1,0);

    for i=ximg_min:ximg_max
        for j=yimg_min:yimg_max
            kernel=mosaic(i-2:i+2,j-2:j+2);
            row_vector = im2col(kernel,[5 5]).';
            if mod(i,2)==0
                if mod(j,2)==0
                    %BGGR
                    X_BGGR = [X_BGGR;row_vector];  
                    GT_R3 = [GT_R3;original_image(i,j,1)];
                    GT_G2 = [GT_G2;original_image(i,j,2)];
                else
                    %GBRG
                    X_GBRG = [X_GBRG;row_vector];
                    GT_R1 = [GT_R1;original_image(i,j,1)];
                    GT_B2 = [GT_B2;original_image(i,j,3)];
                end
            else
                if mod(j,2)==0
                    %GRBG
                    X_GRBG = [X_GRBG;row_vector];
                    GT_R2 = [GT_R2;original_image(i,j,1)];
                    GT_B3 = [GT_B3;original_image(i,j,3)];
                else
                    %RGGB
                    X_RGGB = [X_RGGB; row_vector];
                    GT_G1 = [GT_G1; original_image(i,j,2)];
                    GT_B1 = [GT_B1; original_image(i,j,3)];  
                end
            end
        end
%         if i > 30
%             break
%         end
    end
    A_RGGB_G = ((X_RGGB.')*X_RGGB)\(X_RGGB.')*GT_G1;
    A_RGGB_B = ((X_RGGB.')*X_RGGB)\(X_RGGB.')*GT_B1;
    A_GBRG_R = ((X_GBRG.')*X_GBRG)\(X_GBRG.')*GT_R1;
    A_GBRG_B = ((X_GBRG.')*X_GBRG)\(X_GBRG.')*GT_B2;
    A_GRBG_R = ((X_GRBG.')*X_GRBG)\(X_GRBG.')*GT_R2;
    A_GRBG_B = ((X_GRBG.')*X_GRBG)\(X_GRBG.')*GT_B3;
    A_BGGR_R = ((X_BGGR.')*X_BGGR)\(X_BGGR.')*GT_R3;
    A_BGGR_G = ((X_BGGR.')*X_BGGR)\(X_BGGR.')*GT_G2;
end

function [A_RGGB_G,A_RGGB_B,A_GBRG_R,A_GBRG_B,A_GRBG_R,A_GRBG_B,A_BGGR_R,A_BGGR_G] = LLSPDIV2K()
    img_dir = 'C:\Users\User\Downloads\DIV2K_train_HR\DIV2K_train_HR\';
    img_files = dir(fullfile(img_dir, '*.png'));
    pad = 2;
    X_RGGB = zeros(25,0);
    X_GBRG = zeros(25,0);
    X_GRBG = zeros(25,0);
    X_BGGR = zeros(25,0);
    GT_G1 = zeros(1,0);
    GT_G2 = zeros(1,0);
    GT_R1 = zeros(1,0);
    GT_R2 = zeros(1,0);
    GT_R3 = zeros(1,0);
    GT_B1 = zeros(1,0);
    GT_B2 = zeros(1,0);
    GT_B3 = zeros(1,0);
    
    window_x = 300;
    window_y = 300;
    for file = 1:length(img_files)
        img_path = fullfile(img_dir, img_files(file).name);
        img = double(imread(img_path));
        [x,y,~] = size(img);
        [RGGB,GBRG,GRBG,BGGR] = mosaic(img);
        ximg_min = 1+pad;
        ximg_max = x-pad;
        yimg_min = 1+pad;
        yimg_max = y-pad;

        startx = randi([ximg_min (ximg_max - window_x)]);
        starty = randi([yimg_min (yimg_max - window_x)]);
        for i=startx:ximg_max
            for j=starty:yimg_max
                kernel=RGGB(i-2:i+2,j-2:j+2);
                row_vector = im2col(kernel,[5 5]).';
                if mod(i,2)==0
                    if mod(j,2)==0
                        %BGGR
                        X_BGGR = [X_BGGR;row_vector];  
                        GT_R3 = [GT_R3;img(i,j,1)];
                        GT_G2 = [GT_G2;img(i,j,2)];
                    else
                        %GBRG
                        X_GBRG = [X_GBRG;row_vector];
                        GT_R1 = [GT_R1;img(i,j,1)];
                        GT_B2 = [GT_B2;img(i,j,3)];
                    end
                else
                    if mod(j,2)==0
                        %GRBG
                        X_GRBG = [X_GRBG;row_vector];
                        GT_R2 = [GT_R2;img(i,j,1)];
                        GT_B3 = [GT_B3;img(i,j,3)];
                    else
                        %RGGB
                        X_RGGB = [X_RGGB; row_vector];
                        GT_G1 = [GT_G1; img(i,j,2)];
                        GT_B1 = [GT_B1; img(i,j,3)];  
                    end
                end
                if j > window_x
                    break
                end
            end
            if i > window_y
                break
            end
        end
    end
    A_RGGB_G = inv((X_RGGB.')*X_RGGB)*(X_RGGB.')*double(GT_G1);
    A_RGGB_B = inv((X_RGGB.')*X_RGGB)*(X_RGGB.')*double(GT_B1);
    A_GBRG_R = inv((X_GBRG.')*X_GBRG)*(X_GBRG.')*double(GT_R1);
    A_GBRG_B = inv((X_GBRG.')*X_GBRG)*(X_GBRG.')*double(GT_B2);
    A_GRBG_R = inv((X_GRBG.')*X_GRBG)*(X_GRBG.')*double(GT_R2);
    A_GRBG_B = inv((X_GRBG.')*X_GRBG)*(X_GRBG.')*double(GT_B3);
    A_BGGR_R = inv((X_BGGR.')*X_BGGR)*(X_BGGR.')*double(GT_R3);
    A_BGGR_G = inv((X_BGGR.')*X_BGGR)*(X_BGGR.')*double(GT_G2);
end

function output_image = computeOutput(A_RGGB_G,A_RGGB_B,A_GBRG_R,A_GBRG_B,A_GRBG_R,A_GRBG_B,A_BGGR_R,A_BGGR_G, mosaic, x, y)
    pad = 2;
    ximg_min = 1+pad;
    ximg_max = x-pad;
    yimg_min = 1+pad;
    yimg_max = y-pad;
    output_image = zeros(x,y,3);
    for i=ximg_min:ximg_max
        for j=yimg_min:yimg_max
            kernel=mosaic(i-2:i+2,j-2:j+2);

            if mod(i,2)==0
                if mod(j,2)==0
                    %BGGR
                    output_image(i,j,3) = mosaic(i,j);
                    output_image(i,j,1) = A_BGGR_R.'*im2col(kernel,[5 5]);
                    output_image(i,j,2) = A_BGGR_G.'*im2col(kernel,[5 5]);
                else
                    %GBRG
                    output_image(i,j,2) = mosaic(i,j);
                    output_image(i,j,1) = A_GBRG_R.'*im2col(kernel,[5 5]);
                    output_image(i,j,3) = A_GBRG_B.'*im2col(kernel,[5 5]);
                end
            else
                if mod(j,2)==0
                    %GRBG
                    output_image(i,j,2) = mosaic(i,j);
                    output_image(i,j,1) = A_GRBG_R.'*im2col(kernel,[5 5]);
                    output_image(i,j,3) = A_GRBG_B.'*im2col(kernel,[5 5]);
                else
                    %RGGB
                    output_image(i,j,1) = mosaic(i,j);
                    output_image(i,j,2) = A_RGGB_G.'*im2col(kernel,[5 5]);
                    output_image(i,j,3) = A_RGGB_B.'*im2col(kernel,[5 5]);
                end
            end
        end
    end
end
function rmse = calcRMSE(im1,im2)
    im1 = double(im1);
    im2 = double(im2);
    squared_diff = (im1-im2).^2;
    rmse = sqrt(mean(squared_diff(:)));
end

function [A_RGGB_G,A_RGGB_B,A_GBRG_R,A_GBRG_B,A_GRBG_R,A_GRBG_B,A_BGGR_R,A_BGGR_G] = calculateA(X_RGGB,GT_G1,GT_B1,X_GBRG,GT_R1,GT_B2,X_GRBG,GT_R2,GT_B3,X_BGGR,GT_R3,GT_G2)
    A_RGGB_G = inv((X_RGGB.')*X_RGGB)*(X_RGGB.')*double(GT_G1);
    A_RGGB_B = inv((X_RGGB.')*X_RGGB)*(X_RGGB.')*double(GT_B1);
    A_GBRG_R = inv((X_GBRG.')*X_GBRG)*(X_GBRG.')*double(GT_R1);
    A_GBRG_B = inv((X_GBRG.')*X_GBRG)*(X_GBRG.')*double(GT_B2);
    A_GRBG_R = inv((X_GRBG.')*X_GRBG)*(X_GRBG.')*double(GT_R2);
    A_GRBG_B = inv((X_GRBG.')*X_GRBG)*(X_GRBG.')*double(GT_B3);
    A_BGGR_R = inv((X_BGGR.')*X_BGGR)*(X_BGGR.')*double(GT_R3);
    A_BGGR_G = inv((X_BGGR.')*X_BGGR)*(X_BGGR.')*double(GT_G2);
end
