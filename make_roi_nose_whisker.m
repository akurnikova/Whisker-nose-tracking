curdir = pwd;
folder = ['E:\Rat_cutnerve\BIRTles09\raw_videos_cutnerve\'];
cd(folder);
fle = ls('*avi');
cd(curdir);
% 
% %% Make new ROI
vr = VideoReader([folder,fle(1,:)]);
vidFrames = read(vr,[1000,1500]);
maxim = max(vidFrames(:,:,:,:),[],4);
image(uint8(maxim));
axis equal;
hold on;


filename = get(vr, 'name');

image(uint8(maxim));
axis equal;
hold on;


title('DEFINE TOP');
BWroi_TOP = roipoly;
save([filename(1:end-4),'_ROI.mat'],'BWroi_TOP');

title('Click for TOP axis');
[x_head_T,y_head_T] = ginput(2);
angle_head_TOP = atand(diff(y_head_T)/diff(x_head_T));
save([filename(1:end-4),'_ROI.mat'],'x_head_T','y_head_T','angle_head_TOP','-append');

%% mirror image;

title('DEFINE MIRROR');
BWroi_MIR = roipoly;
save([filename(1:end-4),'_ROI.mat'],'BWroi_MIR','-append');

title('Click for MIRROR axis');
[x_head_M,y_head_M] = ginput(2);
angle_head_MIR = atand(diff(y_head_T)/diff(x_head_T));
save([filename(1:end-4),'_ROI.mat'],'x_head_M','y_head_M','angle_head_MIR','-append');

%% Whiker roi
image(uint8(maxim));
    axis equal;
    hold on;
    title('DEFINE_IPSI');
    BWroi_IPSI = roipoly;
    save([filename(1:end-4),'_ROI.mat'],'BWroi_IPSI','-append');
        

    title('DEFINE_CONTRA');
    BWroi_CONTRA = roipoly;
    save([filename(1:end-4),'_ROI.mat'],'BWroi_CONTRA','-append');
    

 title('Click for head axis');
 [x_head,y_head] = ginput(2);
    save([filename(1:end-4),'_ROI.mat'],'x_head','y_head','-append');


close all;

thresh = track_bvangle_make_roi_white(vidFrames,.77);
save([filename(1:end-4),'_ROI.mat'],'thresh','-append');



ImTOP = imrotate(maxim(:,:,1,1).*uint8(BWroi_TOP),angle_head_TOP+90);
ImMIR = imrotate(maxim(:,:,1,1).*uint8(BWroi_MIR),angle_head_MIR+90);

limT1 = find(sum(ImTOP,1)>100,1,'first');
limT2 = find(sum(ImTOP,1)>100,1,'last');
limT3 = find(sum(ImTOP,2)>100,1,'first');
limT4 = find(sum(ImTOP,2)>100,1,'last');

limM1 = find(sum(ImMIR,1)>100,1,'first');
limM2 = find(sum(ImMIR,1)>100,1,'last');
limM3 = find(sum(ImMIR,2)>100,1,'first');
limM4 = find(sum(ImMIR,2)>100,1,'last');

figure;
subplot(1,2,1); hold on;
imagesc(ImTOP); axis square; colormap bone;
axis([limT1,limT2,limT3,limT4])

subplot(1,2,2); hold on;
imagesc(ImMIR); axis square; colormap bone;
axis([limM1,limM2,limM3,limM4])





