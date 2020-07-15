function inverted_image = cc_invert(image, rows, cols)
%CC_INVERT Summary of this function goes here
%   Inverts the image of white values to be awd0 and black values to be 255 
%   to support finding the sum of product through cross correlation 

matrix_255 = double(ones(rows, cols))*255; 
inverted_image = uint8(-(image) + matrix_255);
end

