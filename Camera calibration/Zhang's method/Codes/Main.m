fid = fopen('ptsXY.txt','rt');
C=textscan(fid,'%f%f');
fclose(fid)
I=cell2mat(C);

fid = fopen('pts2D_1.txt','rt');
C=textscan(fid,'%f%f');
fclose(fid)
I1=cell2mat(C);

fid = fopen('pts2D_2.txt','rt');
C=textscan(fid,'%f%f');
fclose(fid)
I2=cell2mat(C);

fid = fopen('pts2D_3.txt','rt');
C=textscan(fid,'%f%f');
fclose(fid)
I3=cell2mat(C);

fid = fopen('pts2D_4.txt','rt');
C=textscan(fid,'%f%f');
fclose(fid)
I4=cell2mat(C);

I = checkerboard(20);imshow(I)

BW = not(im2bw(I));
figure;
imshow(not(BW),[]);

continue_it = 1;
while continue_it
BW_old=BW;
BW_del=zeros(size(BW));
for i=2:size(BW,1)-1
    for j = 2:size(BW,2)-1
        P = [BW(i,j) BW(i-1,j) BW(i-1,j+1) BW(i,j+1) BW(i+1,j+1) BW(i+1,j) BW(i+1,j-1) BW(i,j-1) BW(i-1,j-1) BW(i-1,j)];
        if P(2)*P(4)*P(6)==0 && P(4)*P(6)*P(8)==0 && sum(P(2:end-1))<=6 && sum(P(2:end-1)) >=2
            A = 0;
            for k = 2:size(P(:),1)-1
                if P(k) == 0 && P(k+1)==1
                    A = A+1;
                end%if
            end%for
            if (A==1)
                BW_del(i,j)=1;
            end%if
        end%if
    end%for
end%for

BW(find(BW_del==1))=0;

for i=2:size(BW,1)-1
    for j = 2:size(BW,2)-1
        P = [BW(i,j) BW(i-1,j) BW(i-1,j+1) BW(i,j+1) BW(i+1,j+1) BW(i+1,j) BW(i+1,j-1) BW(i,j-1) BW(i-1,j-1) BW(i-1,j)];
        if P(2)*P(4)*P(8)==0 && P(2)*P(6)*P(8)==0 && sum(P(2:end-1))<=6 && sum(P(2:end-1)) >=2
            A = 0;
            for k = 2:size(P(:),1)-1
                if P(k) == 0 && P(k+1)==1
                    A = A+1;
                end%if
            end%for
            if (A==1)
                BW_del(i,j)=1;
            end%if
        end%if
    end%for
end%for

BW(find(BW_del==1))=0;

if prod(BW_old(:)==BW(:))
   continue_it=0;
end%if

end%while
figure
imshow(not(BW),[])