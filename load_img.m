function [ imgs,imgx ] = load_img( dir )
%   ��������ͼƬ��imgsΪ17����֪ͼƬ��imgxΪ��ҪԤ���ͼƬ
imgx = imread([dir,'\X.png']);

[M,N,~] = size(imgx);
imgs = zeros(M,N,3,17);
for i = 1:17
    imgs(:,:,:,i) = imread([dir,'\R',num2str(i),'.png']);
end
end

