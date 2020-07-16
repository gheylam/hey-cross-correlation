# hey-cross-correlation
Trying to implement cross correlation  

This is a series of files and implmentation of cross correlation with the context of image processing. 
I will be attempting implement the algorithm using matlab, python and then finally use C++ as a coding 
exercise. 

I will be doing the naive sum of product approach for my implementation of cross correlation. 

Along this process, I will also be highlighting the design decisions i've come across such as: 
1. How should I iterate sample image through the main image. 
2. How should I deal with situations where the sample image exceeds the dimensions of the main image? 
3. What are various ways to preprocess the images such that we accentuate the sum of products? 


## Log 1 - 15.07.2020 First implementation on Matlab (GreyScale)
I have the first implementation on matlab. To give context on the first implementation, I used the following images

50x50 main image: used for iterating through

![50x50 main image](https://github.com/gheylam/hey-cross-correlation/blob/master/images/cc_test_image.jpg)

10x10 probe image: used as the target we want to identify in the main image

![10x10 probe image](https://github.com/gheylam/hey-cross-correlation/blob/master/images/cc_probe_image.jpg)

I then made the following decisions: 

### Iteration method 
I start from the (0,0) of each image 
  
### Dealing with out-of-bounds
I break; the iteration loop when the sample image is out-of-bounds therefore we actually lose 100 
points in the results matrix because after point (40,40), we will always be exceeding the bounds of the main 
image. 

### Image preprocessing 
I realised that we want the black+black to produce a high value signal and dampen the signl on white+black or white+white pixels.
Therefore I decided to invert the values such that white was 0 and black was 255. 

I also converted the rgb 3 channel images into a single greyscale image to simplify the processing. 

### Result 
Here is the result of my current implmentation using matlab's surf() function.

![Implementation#1 results graph](https://github.com/gheylam/hey-cross-correlation/blob/master/results/Screenshot%20from%202020-07-15%2011-32-38.png)

We can clearly see the four dots are producing the strongest signal. 

### Next steps for improvements 
1. Iterate the images from the center of the probe image instead of (0,0)
2. Deal with out-of-bound cases more elegantly by summing the pixel overlap 
3. Produce sharper peaks by making heavier penalities when the pixels are not the same, i.e. black+white. 
