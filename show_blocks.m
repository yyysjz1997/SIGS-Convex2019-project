 file_names=[string('img\Trees');
    string('img\Boys');
    string('img\Cam_Still');
    string('img\NagoyaDataLeading');
    string('img\NagoyaFujita');
    string('img\NagoyaOrigami');
    string('img\Toys')];

blk_size=32;
 for i=1:size(file_names,1)
     file_name=[char(file_names(i)),'\X_final.png'];
     disp(file_name)
     img = imread(file_name);
     [M,N,~]=size(img);
     m=ceil(M/blk_size);
     n=ceil(N/blk_size);
     disp(m*n)
     for j=1:m-1
         img(j*blk_size,:,:)=0;
     end
     for j=1:n-1
         img(:,j*blk_size,:)=0;
     end
     img=uint8(img);
     imwrite(img,[char(file_names(i)),'\X_blocks.png'])
 end
