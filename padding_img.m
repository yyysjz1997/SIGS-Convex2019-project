function [ R_pad,X_pad ] = padding_img( R,X,blk_size)
%padding_img  将图像补全的函数
%   pad_size取值为4,8,16,32,64
[m,n,~]=size(X);
pad_size_m=0;
if mod(m,blk_size)~=0
    pad_size_m=blk_size-mod(m,blk_size);
end
pad_size_n=0;
if mod(n,blk_size)~=0
    pad_size_n=blk_size-mod(n,blk_size);
end
R_pad=padarray(R,[pad_size_m,pad_size_n],0,'post');
X_pad=padarray(X,[pad_size_m,pad_size_n],0,'post');
end

