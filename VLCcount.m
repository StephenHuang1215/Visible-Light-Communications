clear

pic = imread('VLC3.jpg') ;
gray_pic = zeros(size(pic,1),size(pic,2));

for j=1:size(pic,1)
   for i= 1:size(pic,2)
       gray_pic(j,i) = pic(j,i,3);
   end
end
imshow(uint8(gray_pic))

gray_pic_col = zeros(1, size(pic,2));

for i = 1:size(gray_pic_col,2)
    gray_pic_col(i) = mean(gray_pic(:,i));
end

i=1;
light_point=0;
dark_point=0;
diff_threshold=10;

while i <= size(gray_pic_col,2)-1
    
    first_up_flag=1;
    first_up_value=0;
    while gray_pic_col(i) < gray_pic_col(i+1)
        if (first_up_flag)
            first_up_value = gray_pic_col(i);
            first_up_flag=0;
        end
        i=i+1;
        if (i == size(gray_pic_col,2))
            break;
        end
    end
    if (first_up_flag == 0)
        if (abs(first_up_value - gray_pic_col(i)) > diff_threshold)
            if (light_point == 0)
                light_point = i;
            else
                light_point = [light_point i];
            end
        end
    end
    
    first_down_flag=1;
    first_down_value=0;
    while gray_pic_col(i) > gray_pic_col(i+1)
        if (first_down_flag)
            first_down_value = gray_pic_col(i);
            first_down_flag=0;
        end
        i=i+1;
        if (i == size(gray_pic_col,2))
            break;
        end
    end
    if (first_down_flag == 0)
        if (abs(first_down_value - gray_pic_col(i)) > diff_threshold)
            if (dark_point == 0)
                dark_point = i;
            else
                dark_point = [dark_point i];
            end
        end
    end
    
    if (i < size(gray_pic_col,2))
        if (gray_pic_col(i) == gray_pic_col(i+1))
            i=i+1;
        end
    end
    count = size(light_point, 2);
end
