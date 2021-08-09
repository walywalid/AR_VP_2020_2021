function [u, v] = HS(im1, im2, lambda, ite)
% Horn-Schunck optical flow method 


%% Default parameters
if nargin<1 || nargin<2
    im1=imread('dt_001.jpg');
    im2=imread('dt_002.jpg');
end
if nargin<3
    alpha=1;
end
if nargin<4
    ite=100;
end
if nargin<5 || nargin<6
    uInitial = zeros(size(im1(:,:,1)));
    vInitial = zeros(size(im2(:,:,1)));
elseif size(uInitial,1) ==0 || size(vInitial,1)==0
    uInitial = zeros(size(im1(:,:,1)));
    vInitial = zeros(size(im2(:,:,1)));
end
if nargin<7
    displayFlow=1;
end
if nargin<8
    displayImg=im1;
end
 
%% Convert images to grayscale
if size(size(im1),2)==3
    im1=rgb2gray(im1);
end
if size(size(im2),2)==3
    im2=rgb2gray(im2);
end
im1=double(im1);
im2=double(im2);

im1=smoothImg(im1,1);
im2=smoothImg(im2,1);

tic;

%%
% Set initial value for the flow vectors
u = uInitial;
v = vInitial;

% Estimate spatiotemporal derivatives
[fx, fy, ft] = computeDerivatives(im1, im2);

% Averaging kernel
kernel_1=[1/12 1/6 1/12;1/6 0 1/6;1/12 1/6 1/12];

% Iterations
for i=1:ite
    % Compute local averages of the flow vectors
    uAvg=conv2(u,kernel_1,'same');
    vAvg=conv2(v,kernel_1,'same');
    % Compute flow vectors constrained by its local average and the optical flow constraints
    u= uAvg - ( fx .* ( ( fx .* uAvg ) + ( fy .* vAvg ) + ft ) ) ./ ( alpha^2 + fx.^2 + fy.^2); 
    v= vAvg - ( fy .* ( ( fx .* uAvg ) + ( fy .* vAvg ) + ft ) ) ./ ( alpha^2 + fx.^2 + fy.^2);
end

u(isnan(u))=0;
v(isnan(v))=0;

%% Plotting
if displayFlow==1
    plotFlow(u, v, displayImg, 5, 5); 
end