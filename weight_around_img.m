function [ r ] = weight_around_img( w,r_around )
%����Ȩ�غ���Χ��ͼƬ�õ�Ԥ���ͼƬ
[m,n,c,~]=size(r_around);
r=zeros(m,n,c);
for k=1:3
    r(:,:,k)=r_around(:,:,k,1).*w(:,:,1)+r_around(:,:,k,2).*w(:,:,2)+r_around(:,:,k,3).*w(:,:,3)+r_around(:,:,k,4).*w(:,:,4);
end

