 file_names=[string('Trees');
    string('Boys');
    string('Cam_Still');
    string('NagoyaDataLeading');
    string('NagoyaFujita');
    string('NagoyaOrigami');
    string('Toys')];

 for i=1:size(file_names,1)
     file_name=['img\',char(file_names(i)),'_psnr_blks.mat'];
     disp(char(file_names(i)));
     psnr=load(file_name);
     psnr=psnr.psnr_blks;
     figure();
     image(psnr);
     colorbar;
 end


