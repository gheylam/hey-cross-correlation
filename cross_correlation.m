%load the images to be cross correlated 
test_image = imread("./images/cc_test_image.jpg"); 
probe_image = imread("./images/cc_probe_image.jpg"); 

%convert image to monospace 
test_image = rgb2gray(test_image);
probe_image = rgb2gray(probe_image); 

%getting the dimensions of the image 
[test_rows, test_cols] = size(test_image); 
[probe_rows, probe_cols] = size(probe_image); 

%invert the images to make sum of products possible 

preprocessed_test_image = cc_invert(double(test_image), test_rows, test_cols);
preprocessed_probe_image = cc_invert(double(probe_image), probe_rows, probe_cols);

%perform the cross correlation 
%{
    1. sample a 10x10 sub matrix from the test_image starting from (0,0) 
    2. verify it is in bounds of 50x50 
    3. caluclate the sum of products between the sub matrix and the probe
    image
    4. save result in a 50x50 matrix 
%}

cc_result = zeros(50,50);

for row = 1 : test_rows
    for col = 1 : test_cols 
        if row + probe_rows >= test_rows + 1
            break;
        end
        if col + probe_cols >= test_cols + 1 
            break;
        end
        
        sample = preprocessed_test_image(row:row+9, col:col+9);
        sum_of_products = 0;
        for p_row = 1 : probe_rows
            for p_col = 1: probe_cols
                sum_of_products = sum_of_products + (double(sample(p_row, p_col)) * double(preprocessed_probe_image(p_row, p_col)));
            end
        end
        cc_result(row, col) = sum_of_products; 
    end
end

surf(cc_result);


                
        