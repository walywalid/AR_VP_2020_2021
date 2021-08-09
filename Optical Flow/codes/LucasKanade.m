function [u, v] = LucasKanade(im1, im2, windowSize)
% Lucas and Kanade of OF method

if size(size(im1),2)==3
    im1=rgb2gray(im1);
end
if size(size(im2),2)==3
    im2=rgb2gray(im2);
end

im1=double(im1);
im2=double(im2);

im1 = imgaussfilt(im1,2);
im2 = imgaussfilt(im2,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Begin of "Write your code here" section %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Read The Input
v = im1;
A=squeeze(v);

 a1 = im1;
 a2 = im2;
% a1= rgb2gray(a1);
% a2 = rgb2gray(a2);
% 
figure;
imshow(imresize(uint8(A(:,:,1)),0.5));
hold on
for i2 = 1:5:size(A,3)-5

% i2=20;
a1 = imresize(A(:,:,i2),0.5);
a2 = imresize(A(:,:,i2+5),0.5);


b = size(a1);
a1 = double(a1);
a2 = double(a2);

%% Generating Fx Fy and Ft
rx = [-1 1;-1 1];
ry = [1 1;-1 -1];

fx = zeros(b(1)-1,b(2)-1);
fy = zeros(b(1)-1,b(2)-1);
ft = zeros(b(1)-1,b(2)-1);
for i = 1:b(1)-1
    for j = 1:b(2)-1
        fx(i,j) = 0.5*(sum(sum(a1(i:i+1,j:j+1).*rx)) + sum(sum(a2(i:i+1,j:j+1).*rx)));
        fy(i,j) = 0.5*(sum(sum(a1(i:i+1,j:j+1).*ry)) + sum(sum(a2(i:i+1,j:j+1).*ry)));
        ft(i,j) = sum(sum(a2(i:i+1,j:j+1) - a1(i:i+1,j:j+1)));
    end
end

%% Creating the u and v matrices
u = zeros(b(1)-1,b(2)-1);
v = zeros(b(1)-1,b(2)-1);
    
    for i = 2:b(1)-3
        for j = 2:b(2)-3
            x = fx(i-1:i+1,j-1:j+1);
            x = x(:);
            y = fy(i-1:i+1,j-1:j+1);
            y = y(:);
            t = -ft(i-1:i+1,j-1:j+1);
            t = t(:);
            Amat = [x(:),y(:)];
            bvec = t(:);
            if det((Amat')*Amat) ~=0
                U = ((Amat')*Amat)\(Amat'*bvec);
                u(i,j) = U(1);
                v(i,j) = U(2);
            end
            
        end
    end
    

%% Ploting velocity vectors
 figure;
 imshow(imresize(A(:,:,i2),0.5));
 hold on

% figure;
quiver(u,v,'b');
hold on

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Begin of "Write your code here" section %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% u(isnan(u))=0;
% v(isnan(v))=0;
