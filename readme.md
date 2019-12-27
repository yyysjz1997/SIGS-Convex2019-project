1、运行程序前需要将每张图片的R1-R17添加到img文件夹中该图片对应的文件夹内
2、运行running.m文件，开始预测所有7张图片并输出结果。（running.m文件会循环调用main.m文件）
3、运行show_psnr_means.m文件，输出所有7张图片，前后两帧上下左右图片分块的psnr的频率直方图。
4、运行show_block.m文件，保存所有7张图片的分块结果。
5、运行show_psnr_blocks.m文件，输出所有7张图中，每个小块的psnr热力图


以Boys为例
img/Boys/X.png为原图； img/Boys/X_final.png为最佳的预测结果； img/Boys/X_blocks.png是对X_final.png的分块情况
另外
img/Boys_psnr_blks.mat保存了预测结果图片中每块的psnr指标
img/Boys_psnr_final.mat保存了预测结果图片总体的psnr指标
img/Boys_psnr_means.mat保存了上下帧对应的每块图片之间的差别指标，psnr_means越大，表示该块图片上下帧之间差别越小；