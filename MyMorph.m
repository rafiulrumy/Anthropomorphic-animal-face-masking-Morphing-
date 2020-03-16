clear
clc

% Select morphing method
triangles = 0;
video = 0;

%% Loading Images to Memory

im1 = imread('seb.jpg');
%im2 = imread('will.jpg');
im2 = imread('E:\Research files\Journal\1st Journal\ImageMorphing-master\Fixed Points\Dog\Dog.jpg');
[H,W,C]=size(im2);
im1=imresize(im1,[H,W]);

%% Click Correspondences

movingPoints = MovingPoints(im1);
im1_pts = movingPoints;
%%
fixedPoints = fixedPoints(im2);
im2_pts = fixedPoints;
%%
im2_pts = load('E:\Research files\Journal\1st Journal\ImageMorphing-master\Fixed Points\Dog\Dog.mat');
im2_pts = im2_pts.fixedPoints;
cornerPoints = [1,1; 0.25*W,1; 0.5*W,1; 0.75*W,1;...
                W,1; W,0.25*H; W,0.5*H; W,0.75*H;...
                W,H; 0.75*W,H; 0.5*W,H; 0.25*W,H;...
                1,H; 1,0.75*H; 1,0.5*H; 1,0.25*H];

im1_pts=[im1_pts;cornerPoints];
im2_pts=[im2_pts;cornerPoints];
% obtain user input for points
%[im1_pts, im2_pts] = click_correspondences(im1, im2);

% triangulate
mean_pts = (im1_pts + im2_pts)/2;
triangulation = delaunayTriangulation(mean_pts);

%% Plot
%subplot(1,2,1);
figure(1);
imshow(im1);
hold on
triplot(triangulation, im1_pts(:,1), im1_pts(:,2));
triplot(triangulation, mean_pts(:,1), mean_pts(:,2),'r');
hold off

%subplot(1,2,2);
figure(2);
imshow(im2);
hold on
triplot(triangulation, im2_pts(:,1), im2_pts(:,2));
triplot(triangulation, mean_pts(:,1), mean_pts(:,2),'r');
hold off
%%
%axis equal

aviobj =VideoWriter('Triangulation.avi');
open(aviobj);
fracs = linspace(0,1,500);
for i = 1:500  
  morphed_image = morph(im1, im2, im1_pts, im2_pts, triangulation, fracs(i), fracs(i));
%  morphed_image = morph_tps_wrapper(im1, im2, im1_pts, im2_pts, fracs(i), fracs(i));

  figure(3);imshow(morphed_image);
  %axis image; axis off;drawnow;
  frame = getframe(figure(3));
  writeVideo(aviobj,frame);
end
aviobj =close;
%%
%To collect any single frame
morphed_pic = morph(im1, im2, im1_pts, im2_pts, triangulation, .75, .75);
figure
imshow(morphed_pic);
%%
% write video frames
tic;
vid=VideoReader('Triangulation.avi');
  numFrames = vid.NumberOfFrames;
Folder = 'E:\Research files\Journal\1st Journal\ImageMorphing-master\20 points human\';
for iFrame = 1:numFrames
  frames = read(vid, iFrame);
  imwrite(frames, fullfile(Folder, sprintf('%06d.jpg', iFrame)));
end 
FileList = dir(fullfile(Folder, '*.jpg'));
for iFile = 1:length(FileList)
  aFile = fullfile(Folder, FileList(iFile).name);
  img   = imread(aFile);
end
