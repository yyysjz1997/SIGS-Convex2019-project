function [ result ] = loss_func2( r5,r_around,w )
%�Ż���Ŀ�꺯��
result = 0;
for k=1:3
    % Ԥ��ֵ
    % wΪ������ʽ
    r_k=r_around(:,:,k,1).*w(1)+r_around(:,:,k,2).*w(2)+r_around(:,:,k,3).*w(3)+r_around(:,:,k,4).*w(4);  
    %����
    MSE=norm(r5(:,:,k)-r_k(:,:),1);
    result = result + MSE;
end
end

