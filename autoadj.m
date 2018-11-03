function [na] = autoadj(n)

    na = (n-min(n(:)))/(max(n(:)) - min(n(:)));
    
end