function I=binarize_image(I)

if size(I,3)>3
    I=I(:,:,1:3);
end

if ~islogical(I)
    I=im2bw(I);
end