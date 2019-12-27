function psnr_mean = psnr_avg(X, Y)
% 计算三通道平均PSNR的函数
[M,N,~] = size(X);
psnr_temp = 0;
X = double(X);
Y = double(Y);
for k=1:3
    MSE = sum(sum((X(:,:,k)-Y(:,:,k)).^2))/M/N; 
    PSNR = 10*log10(255^2 / MSE);
    psnr_temp = psnr_temp + PSNR;
end
psnr_mean = psnr_temp/3;
