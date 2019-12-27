function [ r,x ,psnr_mean,trans_params,r_around1,r_around2] = cut_trans_around_img( R,X,blk_size,blk_id_m,blk_id_n,max_trans)
% 对图片进行切割
r=R((blk_id_m-1)*blk_size+1:blk_id_m*blk_size,(blk_id_n-1)*blk_size+1:blk_id_n*blk_size,:,:);
x=X((blk_id_m-1)*blk_size+1:blk_id_m*blk_size,(blk_id_n-1)*blk_size+1:blk_id_n*blk_size,:);
[M,N,~,~]=size(R);
% 获取合理的偏移量
%  对于左边和右边的图
psnr_L=0;
trans_L=0;
psnr_R=0;
trans_R=0;
for i=-max_trans:max_trans
    m_s=(blk_id_m-1)*blk_size;
    n_s=(blk_id_n-1)*blk_size;
    if n_s+1+i>=1 && n_s+blk_size+i<=N
        r4_i=R(m_s+1:m_s+blk_size,n_s+1+i:n_s+blk_size+i,:,4);
        r13_i=R(m_s+1:m_s+blk_size,n_s+1+i:n_s+blk_size+i,:,13);
        r6_i=R(m_s+1:m_s+blk_size,n_s+1+i:n_s+blk_size+i,:,6);
        r14_i=R(m_s+1:m_s+blk_size,n_s+1+i:n_s+blk_size+i,:,14);
        r5_i=r(:,:,:,5);  %上面中间的图
        trans=0; %只要在合理范围内就是没有偏移
    elseif n_s+1+i<1
        r4_i=R(m_s+1:m_s+blk_size,1:n_s+blk_size+i,:,4);
        r6_i=R(m_s+1:m_s+blk_size,1:n_s+blk_size+i,:,6);
        r13_i=R(m_s+1:m_s+blk_size,1:n_s+blk_size+i,:,13);
        r14_i=R(m_s+1:m_s+blk_size,1:n_s+blk_size+i,:,14);
        trans=(n_s+1+i)-1;       %负数
        r5_i=r(:,1-trans:blk_size,:,5);
    else
        r4_i=R(m_s+1:m_s+blk_size,n_s+1+i:N,:,4);
        r6_i=R(m_s+1:m_s+blk_size,n_s+1+i:N,:,6);
        r13_i=R(m_s+1:m_s+blk_size,n_s+1+i:N,:,13);
        r14_i=R(m_s+1:m_s+blk_size,n_s+1+i:N,:,14);
        trans=(n_s+blk_size+i)-N;    %正数
        r5_i=r(:,1:blk_size-trans,:,5);
    end
    psnr_l=psnr_avg(r5_i,r4_i);
    if psnr_l>psnr_L
        psnr_L=psnr_l;
        trans_L=trans;
        r(:,:,:,4)=zeros(blk_size,blk_size,3);
        r(:,max(1,1-trans_L):min(blk_size,blk_size-trans_L),:,4)=r4_i;
        r(:,:,:,13)=zeros(blk_size,blk_size,3);
        r(:,max(1,1-trans_L):min(blk_size,blk_size-trans_L),:,13)=r13_i;
    end
    psnr_r=psnr_avg(r5_i,r6_i);
    if psnr_r>psnr_R
        psnr_R=psnr_r;
        trans_R=trans;
        r(:,:,:,6)=zeros(blk_size,blk_size,3);
        r(:,max(1,1-trans_R):min(blk_size,blk_size-trans_R),:,6)=r6_i;
        r(:,:,:,14)=zeros(blk_size,blk_size,3);
        r(:,max(1,1-trans_R):min(blk_size,blk_size-trans_R),:,14)=r14_i;
    end
end

%  对于上边和下边的图
psnr_U=0;
trans_U=0;
psnr_D=0;
trans_D=0;
for i=-max_trans:max_trans
    m_s=(blk_id_m-1)*blk_size;
    n_s=(blk_id_n-1)*blk_size;
    if m_s+1+i>=1 && m_s+blk_size+i<=M
        r2_i=R(m_s+1+i:m_s+blk_size+i,n_s+1:n_s+blk_size,:,2);
        r8_i=R(m_s+1+i:m_s+blk_size+i,n_s+1:n_s+blk_size,:,8);
        r11_i=R(m_s+1+i:m_s+blk_size+i,n_s+1:n_s+blk_size,:,11);
        r16_i=R(m_s+1+i:m_s+blk_size+i,n_s+1:n_s+blk_size,:,16);
        r5_i=r(:,:,:,5);  %上面中间的图
        trans=0; %只要在合理范围内就是没有偏移
    elseif m_s+1+i<1
        r2_i=R(1:m_s+blk_size+i,n_s+1:n_s+blk_size,:,2);
        r8_i=R(1:m_s+blk_size+i,n_s+1:n_s+blk_size,:,8);
        r11_i=R(1:m_s+blk_size+i,n_s+1:n_s+blk_size,:,11);
        r16_i=R(1:m_s+blk_size+i,n_s+1:n_s+blk_size,:,16);
        trans=(m_s+1+i)-1;       %负数
        r5_i=r(1-trans:blk_size,:,:,5);
    else
        r2_i=R(m_s+1+i:M,n_s+1:n_s+blk_size,:,2);
        r8_i=R(m_s+1+i:M,n_s+1:n_s+blk_size,:,8);
        r11_i=R(m_s+1+i:M,n_s+1:n_s+blk_size,:,11);
        r16_i=R(m_s+1+i:M,n_s+1:n_s+blk_size,:,16);
        trans=(m_s+blk_size+i)-M;    %正数
        r5_i=r(1:blk_size-trans,:,:,5);
    end
    psnr_u=psnr_avg(r5_i,r2_i);
    if psnr_u>psnr_U
        psnr_U=psnr_u;
        trans_U=trans;
        r(:,:,:,2)=zeros(blk_size,blk_size,3);
        r(max(1,1-trans_U):min(blk_size,blk_size-trans_U),:,:,2)=r2_i;
        r(:,:,:,11)=zeros(blk_size,blk_size,3);
        r(max(1,1-trans_U):min(blk_size,blk_size-trans_U),:,:,11)=r11_i;
    end
    psnr_d=psnr_avg(r5_i,r8_i);
    if psnr_d>psnr_D
        psnr_D=psnr_d;
        trans_D=trans;
        r(:,:,:,8)=zeros(blk_size,blk_size,3);
        r(max(1,1-trans_D):min(blk_size,blk_size-trans_D),:,:,8)=r8_i;
        r(:,:,:,16)=zeros(blk_size,blk_size,3);
        r(max(1,1-trans_D):min(blk_size,blk_size-trans_D),:,:,16)=r16_i;
    end
end
r_around1=zeros(blk_size,blk_size,3,4);
r_around1(:,:,:,1)=r(:,:,:,4);
r_around1(:,:,:,2)=r(:,:,:,6);
r_around1(:,:,:,3)=r(:,:,:,2);
r_around1(:,:,:,4)=r(:,:,:,8);

r_around2=zeros(blk_size,blk_size,3,4);
r_around2(:,:,:,1)=r(:,:,:,13);
r_around2(:,:,:,2)=r(:,:,:,14);
r_around2(:,:,:,3)=r(:,:,:,11);
r_around2(:,:,:,4)=r(:,:,:,16);

trans_params=[trans_L,trans_R,trans_U,trans_D];
%判断上一时刻和下一时刻之间图片的差异是不是很大
psnr_mean=(psnr_avg(r(:,:,:,2),r(:,:,:,11))+psnr_avg(r(:,:,:,4),r(:,:,:,13))+psnr_avg(r(:,:,:,6),r(:,:,:,14))+psnr_avg(r(:,:,:,8),r(:,:,:,16)))/4;
% disp(psnr_mean);
end