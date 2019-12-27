clear;clc;
file_names=[string('img\Trees');
    string('img\Boys');
    string('img\Cam_Still');
    string('img\NagoyaDataLeading');
    string('img\NagoyaFujita');
    string('img\NagoyaOrigami');
    string('img\Toys')];

 for i=1:7
     file_name=char(file_names(i));
     disp(file_name);
     psnr_blks=main(file_name);
 end
 
 %输出结果
 disp('所有图片的PSNR结果为：');
 for i=1:7
     file_name=char(file_names(i));
     psnr=load([file_name,'_psnr_final.mat']);
     disp(file_name);
     disp(psnr.psnr_final);
 end