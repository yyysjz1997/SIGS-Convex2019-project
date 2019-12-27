function [ result ] = loss_func2( r5,r_around,w )
%优化的目标函数
result = 0;
for k=1:3
    % 预测值
    % w为矩阵形式
    r_k=r_around(:,:,k,1).*w(1)+r_around(:,:,k,2).*w(2)+r_around(:,:,k,3).*w(3)+r_around(:,:,k,4).*w(4);  
    %误差函数
    MSE=norm(r5(:,:,k)-r_k(:,:),1);
    result = result + MSE;
end
end

