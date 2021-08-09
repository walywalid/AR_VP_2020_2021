function [ compensated] = compensateMotion( im1, u, v )
% substracting the motion of the camera

[xm, ym] = meshgrid(1:size(im1, 2), 1:size(im1, 1));

removedX = xm + u;
removedY = ym + v;
compensated = zeros(size(im1));


for col = 1:size(im1, 2)
    for row = 1:size(im1, 1)
        XVal = round(removedX(row, col));
        YVal = round(removedY(row, col));
        if(XVal > 0 && XVal < size(im1, 2) && YVal > 0 && YVal < size(im1, 1))
            compensated(row, col) = im1(YVal, XVal);
        end
    end
end

figure,  imshow(compensated, []), title 'Compensated';

end
