%{
    Naive cross correlation implementation by Gheylam
    
    Current implementation: 
    - Center iteration 
    - inverted matrices for sum of product comparisons 
%}

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

%preprocessed images 
pp_test_image = cc_invert(double(test_image), test_rows, test_cols);
pp_probe_image = cc_invert(double(probe_image), probe_rows, probe_cols);

%perform the cross correlation 
%{
    1. sample a 10x10 sub matrix from the test_image starting from (0,0) 
    2. verify it is in bounds of 50x50 
    3. caluclate the sum of products between the sub matrix and the probe
    image
    4. save result in a 50x50 matrix 
%}

cc_result = zeros(test_rows, test_cols);
row_offset = probe_rows / 2; 
col_offset = probe_cols / 2; %for our scenario this will be 5 

%iterate through every point in the test_image 
for row = 1 : test_rows
    for col = 1 : test_cols 
        %obtain the sample area which is centered around point (row, col)
        start_row = row - row_offset; 
        start_col = col - col_offset; 
        end_row = start_row + probe_rows -1; 
        end_col = start_col + probe_cols -1; 
        
        %correction for the actual sample dimension 
        sample_start_row = start_row;
        sample_start_col = start_col; 
        sample_end_row = end_row; 
        sample_end_col = end_col; 
        if (sample_start_row < 1)
            sample_start_row = 1; 
        end 
        if (sample_start_col < 1)
            sample_start_col = 1; 
        end 
        if (sample_end_row > test_rows)
            sample_end_row = test_rows; 
        end 
        if (sample_end_col > test_cols)
            sample_end_col = test_cols; 
        end 
        
        sample_test_image = pp_test_image(sample_start_row : sample_end_row, sample_start_col: sample_end_col);
        
        corrected_probe_row_start = sample_start_row - row + 5 +1; 
        corrected_probe_row_end = sample_end_row - row + 5 + 1; 
        corrected_probe_col_start = sample_start_col - col + 5 + 1; 
        corrected_probe_col_end = sample_end_col - col + 5 + 1; 
        
        if (corrected_probe_row_start < 1) 
            corrected_probe_row_start = 1
        end 
        if ( corrected_probe_col_start < 1) 
            corrected_probe_col_start = 1 
        end 
        if ( corrected_probe_row_end > 10) 
            corrected_probe_row_end = 10
        end 
        if ( corrected_probe_col_end > 10) 
            corrected_probe_col_end = 10 
        end 
        
        corrected_probe_image = pp_probe_image(corrected_probe_row_start:corrected_probe_row_end, corrected_probe_col_start:corrected_probe_col_end);
        
        sum_of_product = 0; 
        
        [sample_image_row, sample_image_col] = size(sample_test_image); 
        
        for sum_row = 1 : sample_image_row
            for sum_col = 1 : sample_image_col
                sum_of_product = sum_of_product + (double(sample_test_image(sum_row, sum_col)) * double(corrected_probe_image(sum_row, sum_col))); 
            end 
        end 
        cc_result(row, col) = sum_of_product;
    end
end

surf(cc_result);
   
       