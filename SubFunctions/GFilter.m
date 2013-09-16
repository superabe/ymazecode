function [ FilterdArray ] = GFilter( Array,w )
%GFILTER Filter an single line Array using Gaussian filter
%   Detailed explanation goes here
if(size(Array,1) > size(Array,2))
    dim = 1;
else
    dim = 2;
end
    sizeArray = size(Array,dim);

%% Caculate filter factors
sigma = w*w*0.3607; %-0.3607 = 0.25/log(0.5);
d = ceil(w)/2;

if (sizeArray<4*d+1)
    errordlg('Size of filter windows must bigger than size of Array!');
    return
end

if (dim == 1)
i(:,1) = -2*d:1:2*d;    
else
i(1,:) = -2*d:1:2*d;
end
expi = exp((-i .* i)./sigma);
norm = sum(expi,dim);
Factor = expi./norm;

%% Apply factors
FilterdArray = Array;

for n=1:sizeArray
    if((n-2*d-1) >= 0 && (sizeArray >= (n+2*d)))
    ArrayF = Array(n-2*d:n+2*d);

    elseif ((n-2*d-1) < 0)
        if (dim == 1)
            ArrayF = [fliplr(Array(2*n:n+2*d));Array(1:n+2*d)];
        else
            ArrayF = [fliplr(Array(2*n:n+2*d)),Array(1:n+2*d)]; 
        end
    
    elseif (sizeArray < (n+2*d))
        if (dim==1)
            ArrayF = [Array(n-2*d:end);fliplr(Array(n-2*d:2*n-sizeArray-1))];
        else
            ArrayF = [Array(n-2*d:end),fliplr(Array(n-2*d:2*n-sizeArray-1))];
        end
    end
    
    product = ArrayF .* Factor;
    FilterdArray(n)=sum(product,dim);
end

