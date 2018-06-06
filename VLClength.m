clear

pic = imread('VLC3.jpg') ;
gray_pic = zeros(size(pic,1),size(pic,2));

for j=1:size(pic,1)
   for i= 1:size(pic,2)
       gray_pic(j,i) = round(pic(j,i,3));
   end
end

color_threahold = 130;
gray_pic(gray_pic>color_threahold)=255;
gray_pic(gray_pic<=color_threahold)=0;
imshow(uint8(gray_pic))

gray_pic_col = zeros(1, size(pic,2));

for i = 1:size(gray_pic_col,2)
    gray_pic_col(i) = mean(gray_pic(:,i));
end

start = 0;
terminal = 0;
light_length = 0;
black_length = 0;
avg_threshold = 230;
for i = 1:size(gray_pic_col,2)-1
    if (gray_pic_col(i) <= avg_threshold && gray_pic_col(i+1) > avg_threshold) 
        start = i;
        if (terminal)
            if (black_length == 0)
                black_length = start-terminal;
            else
                black_length = [black_length start-terminal];
            end
        end
    end
    if (gray_pic_col(i) > avg_threshold && gray_pic_col(i+1) <= avg_threshold)
        terminal = i;
        if (start)
            if (light_length == 0)
                light_length = terminal-start;
            else
                light_length = [light_length terminal-start];
            end
        end
    end
    num_light = size(light_length, 2);
end