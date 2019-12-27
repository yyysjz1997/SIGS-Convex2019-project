function [ imgs,imgx ] = load_img( dir )
%   加载所有图片，imgs为17张已知图片，imgx为需要预测的图片
imgx = imread([dir,'\X.png']);

[M,N,~] = size(imgx);
imgs = zeros(M,N,3,17);
for i = 1:17
    imgs(:,:,:,i) = imread([dir,'\R',num2str(i),'.png']);
end
end

