file_names=[string('Trees');
    string('Boys');
    string('Cam_Still');
    string('NagoyaDataLeading');
    string('NagoyaFujita');
    string('NagoyaOrigami');
    string('Toys')];

 for i=1:size(file_names,1)
     psnr_total=[];
     file_name=['img\',char(file_names(i)),'_psnr_means.mat'];
     disp(char(file_names(i)));
     psnr=load(file_name);
     psnr=psnr.psnr_means;
     [m,n] = size(psnr);
     for k=1:m
         for j=1:n
             psnr_total(size(psnr_total)+1)=psnr(k,j);
         end
     end 
     figure();
     hist(psnr_total,size(psnr_total,2))
 end


