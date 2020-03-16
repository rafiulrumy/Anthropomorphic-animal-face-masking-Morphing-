function [movingPoints] = MovingPoints(im1)

%%Human Face Detection
%Read the input image
%I = imread('1.jpg');
%J = imread('Bear.jpg');
I = im1;
% Face Detection
%To detect Face
FDetect = vision.CascadeObjectDetector;

%Returns Bounding Box values based on number of objects
BB_face = step(FDetect,I);

[center_face,radius_face] = CR(BB_face);
figure,
imshow(I); hold on
for i = 1:size(BB_face,1)
    viscircles(center_face,radius_face);
    %rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
end
title('Face Detection');
hold off;

t = 0:30:360; % degrees for creating the circle
%radius = 10;  % radius of the circle
%center = [6, 14]; % the coordinates of the center
circle_x_face = center_face(1) + radius_face*cosd(t);
circle_x_face = circle_x_face(1:end-1);
circle_y_face = center_face(2) + radius_face*sind(t);
circle_y_face = circle_y_face(1:end-1);


%NOSE DETECTION:

%To detect Nose
NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',50);

BB_nose=step(NoseDetect,I);

[center_nose,radius_nose] = CR(BB_nose);
figure,
imshow(I); hold on
for i = 1:size(BB_nose,1)
    viscircles(center_nose,radius_nose);
    %rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
end
title('Nose Detection');
hold off;

t = 0:90:360; % degrees for creating the circle
%radius = 10;  % radius of the circle
%center = [6, 14]; % the coordinates of the center
circle_x_nose = center_nose(1) + radius_nose*cosd(t);
circle_x_nose = circle_x_nose(1:end-1);
circle_y_nose = center_nose(2) + radius_nose*sind(t);
circle_y_nose = circle_y_nose(1:end-1);

%MOUTH DETECTION:
%To detect Mouth
MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',270);

BB_mouth=step(MouthDetect,I);

[center_mouth,radius_mouth] = CR(BB_mouth);
figure,
imshow(I); hold on
for i = 1:size(BB_mouth,1)
    viscircles(center_mouth,radius_mouth);
    %rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
end
title('Mouth Detection');
hold off;

t = 0:90:360; % degrees for creating the circle
%radius = 10;  % radius of the circle
%center = [6, 14]; % the coordinates of the center
circle_x_mouth = center_mouth(1) + radius_mouth*cosd(t);
circle_x_mouth = circle_x_mouth(1:end-1);
circle_y_mouth = center_mouth(2) + radius_mouth*sind(t);
circle_y_mouth = circle_y_mouth(1:end-1);

%RIGHT EYE DETECTION:
%To detect Eyes
%EyeDetect = vision.CascadeObjectDetector('EyePairBig');
EyeDetect = vision.CascadeObjectDetector('RightEyeCART','MergeThreshold',100);
%Read the input Image
%I = imread('1.jpg');

BB_righteye=step(EyeDetect,I);

[center_righteye,radius_righteye] = CR(BB_righteye);
figure,
imshow(I); hold on
for i = 1:size(BB_righteye,1)
    viscircles(center_righteye,radius_righteye);
    %rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
end
title('Right Eye Detection');
hold off;

t = 0:90:360; % degrees for creating the circle
%radius = 10;  % radius of the circle
%center = [6, 14]; % the coordinates of the center
circle_x_righteye = center_righteye(1) + radius_righteye*cosd(t);
circle_x_righteye = circle_x_righteye(1:end-1);
circle_y_righteye = center_righteye(2) + radius_righteye*sind(t);
circle_y_righteye = circle_y_righteye(1:end-1);

%LEFT EYE DETECTION:
%To detect Eyes
%EyeDetect = vision.CascadeObjectDetector('EyePairBig');
EyeDetect = vision.CascadeObjectDetector('LeftEyeCART','MergeThreshold',100);

%Read the input Image
%I = imread('1.jpg');

BB_lefteye=step(EyeDetect,I);

[center_lefteye,radius_lefteye] = CR(BB_lefteye);
figure,
imshow(I); hold on
for i = 1:size(BB_lefteye,1)
    viscircles(center_lefteye,radius_lefteye);
    %rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
end
title('Left Eye Detection');
hold off;

t = 0:90:360; % degrees for creating the circle
%radius = 10;  % radius of the circle
%center = [6, 14]; % the coordinates of the center
circle_x_lefteye = center_lefteye(1) + radius_lefteye*cosd(t);
circle_x_lefteye = circle_x_lefteye(1:end-1);
circle_y_lefteye = center_lefteye(2) + radius_lefteye*sind(t);
circle_y_lefteye = circle_y_lefteye(1:end-1);


movingPoints = double([circle_x_face',circle_y_face';...
                       circle_x_lefteye',circle_y_lefteye';center_lefteye;...
                       circle_x_righteye',circle_y_righteye';center_righteye;...
                       circle_x_nose',circle_y_nose';center_nose;...
                       circle_x_mouth',circle_y_mouth';center_mouth;]);
                   

figure,
imshow(I); hold on
for i = 1:size(movingPoints,1)
    viscircles(center_face,radius_face);
    viscircles(center_lefteye,radius_lefteye);
    viscircles(center_righteye,radius_righteye);
    viscircles(center_nose,radius_nose);
    viscircles(center_mouth,radius_mouth);  
end
title('Source Image Control Points');
hold off;
end