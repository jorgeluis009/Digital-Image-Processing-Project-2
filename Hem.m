function [I] = a(img,m)
    r = img(:,:,1);
    g = img(:,:,2);
    b = img(:,:,3);
    
    mask = ones(m);
    mask = mask/sum(sum(mask));
    
    [M N] = size(r);
    
    r1 = r(:,1:N/2);
    r2 = r(:,N/2+1:N);
    r1 = imfilter(r1,mask,'replicate');
    
    g1 = g(:,1:N/2);
    g2 = g(:,N/2+1:N);
    g1 = imfilter(g1,mask,'replicate');
    
    b1 = b(:,1:N/2);
    b2 = b(:,N/2+1:N);
    b1 = imfilter(b1,mask,'replicate');
    
    img(:,:,1) = [r1 r2];
    img(:,:,2) = [g1 g2];
    img(:,:,3) = [b1 b2];
    
    I = img;