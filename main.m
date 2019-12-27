function [ psnr_blks ] = main( file_name )
% ���ò���
blk_size=32;
max_trans=10; 

% ��ȡԭʼͼƬRΪM*N*3*17����XΪM*N*3����
[R,X] = load_img(file_name);
% ��ȡͼƬ��ʵ�Ĵ�С
[m_true,n_true,~]=size(X);
% ��ͼƬ����padding
[R,X] = padding_img( R,X,blk_size);
disp('padding ֮��ͼƬ��С')
disp(size(R))
disp(size(X))
s=size(R);
m=s(1);
n=s(2);
blk_m=m/blk_size;
blk_n=n/blk_size;
X_2=zeros(m,n,3);
psnr_blks=zeros(blk_m,blk_n);
psnr_means=zeros(blk_m,blk_n);
for blk_id_m=1:blk_m
    for blk_id_n=1:blk_n
        % ��ͼƬ�����и�
        fprintf('blk_id_m:%d / %d  blk_id_n:%d / %d \n',blk_id_m,blk_m,blk_id_n,blk_n);
        [ r,x ,psnr_mean,trans_params,r_around,r_around2] = cut_trans_around_img( R,X,blk_size,blk_id_m,blk_id_n,max_trans);
        psnr_means(blk_id_m,blk_id_n)=psnr_mean;
        if psnr_mean<25  && max(abs(trans_params))<3
            % �Ż����⣬��ȡ��ѵ�Ȩ��
            cvx_begin
                variable w(4);
                minimize(loss_func2( r(:,:,:,5),r_around,w));
                subject to
                    w >= 0.0; %#ok<VUNUS>
                    sum(w)==1;  %#ok<*EQEFF>
            cvx_end
            disp(w);
            % ��ȡ��һ֡��ѹ���ͼƬ
            % ��ȡ��ǰ֡�ĸ�����padding֮���ͼƬ�͹���ͼƬ
            x_2= weight_around_img2( w,r_around2 );
            % ��ʾ���psnr
            psnr_blk=psnr_avg(x,x_2);
            psnr_blks(blk_id_m,blk_id_n)=psnr_blk;
            X_2((blk_id_m-1)*blk_size+1:blk_id_m*blk_size,(blk_id_n-1)*blk_size+1:blk_id_n*blk_size,:)=x_2;
        else  
            % �Ż����⣬��ȡ��ѵ�Ȩ��
            cvx_begin
                variable w(blk_size,blk_size,4);
                minimize(loss_func( r(:,:,:,5),r_around,w));
                subject to
                    w >= 0.0; %#ok<VUNUS>
                    sum(w,3)==1+zeros(blk_size,blk_size);  %#ok<*EQEFF>
            cvx_end
            % ��ȡ��һ֡��ѹ���ͼƬ
            %r5_2= weight_around_img( w,r_around );
            % ��ȡ��ǰ֡�ĸ�����padding֮���ͼƬ�͹���ͼƬ
            x_2= weight_around_img( w,r_around2 );
            % ��ʾ���psnr
            psnr_blk=psnr_avg(x,x_2);
            psnr_blks(blk_id_m,blk_id_n)=psnr_blk;
            X_2((blk_id_m-1)*blk_size+1:blk_id_m*blk_size,(blk_id_n-1)*blk_size+1:blk_id_n*blk_size,:)=x_2;
        end
    end
end

save([file_name,'_psnr_blks.mat'],'psnr_blks');
save([file_name,'_psnr_means.mat'],'psnr_means');
X=X(1:m_true,1:n_true,:);
X_2=X_2(1:m_true,1:n_true,:);
disp('----------PSNR--------------')
psnr_final=psnr_avg(X,X_2);   %�������յ�PSNRֵ�����棬��ʱΪdouble���͵ģ�
disp(psnr_final);
save([file_name,'_psnr_final.mat'],'psnr_final');

% ����ͼƬ
X_2=uint8(X_2);  %����ͼƬ��ʱ����Ҫ��uint8��ʽ��
imwrite(X_2,[file_name,'\X2.png']);

% ���ͼƬ�ԱȽ��
% figure();
% imshow(X);
% figure();
% imshow(X_2);
end