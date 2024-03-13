# first off, reading the images needed for the meme and name the image for later use
meme_chad <- image_read("meme_chad.jpeg")
meme_grumpy <- image_read("meme_grumpy.png")

# I made the two images the same sized squares
cropped_chad <- image_modulate(image_crop(meme_chad, "190x220+20"), brightness = 120, saturation = 140, hue = 90) # make Chad and Mr.grumpy the same sized figure and make the former figure clearer to see
grumpy_resize1 <- image_scale(meme_grumpy, "236")
grumpy_resize2 <- image_scale(grumpy_resize1, "x236")
chad_resize <- image_scale(cropped_chad, "x236")

# making two caption squares
cap1 <- image_blank(width = 200,
                    height = 100,
                    color = "white") %>%
  image_annotate(text = "Average probability stats lover", 
                 color = "black", 
                 size = 16, 
                 font = "Times New Roman", 
                 gravity = "center")
cap2 <- image_blank(width = 200,
                    height = 100,
                    color = "white") %>%
  image_annotate(text = "Average data science enjoyer",
                 color = "black",
                 size = 16, 
                 font = "Times New Roman", 
                 gravity = "center")

# Final stage of making the meme using image_append() and vector functions
cap_vec <- c(cap1, cap2)
top_row <- image_append(cap_vec)
img_vec <- c(grumpy_resize2, chad_resize)
bot_row <- image_append(img_vec)
# nested approach this time
final_meme <- image_scale(image_append(c(top_row, bot_row), stack = TRUE), 800)
final_meme %>% image_write("final_meme.png")
final_meme


# creating the background of the meme
caption_sqr <- image_blank(width = 400,
                           height = 400,
                           color = "white") %>%
  image_annotate(text = "AVERGAE DATA SCIENCE ENJOYER!!!",
                 color = "black",
                 size = 22,
                 font = "Times New Roman",
                 gravity = "north")

background <- image_background(caption_sqr, "white", flatten = TRUE)

# add numbers to make it epic
counts <- 1 : 3 %>% as.character()

count1 <- image_blank(color = "white", width = 190, height = 220) %>%
  image_annotate(text = counts[3], size = 100, gravity = "center")

count2 <- image_blank(color = "white", width = 190, height = 220) %>%
  image_annotate(text = counts[2], size = 100, gravity = "center")

count3 <- image_blank(color = "white", width = 190, height = 220) %>%
  image_annotate(text = counts[1], size = 100, gravity = "center")

# creating the content frames of the meme
figure1 <- image_read("meme_chad.jpeg") %>%
  image_crop("190x220+20") %>%
  image_modulate(brightness = 120, saturation = 140, hue = 90)

figure2 <- image_read("meme_chad2.jpeg") %>%
  image_crop("190x220+100") %>%
  image_modulate(brightness = 120, saturation = 140, hue = 90)

figure3 <- image_read("meme_chris.jpeg") %>%
  image_scale("1000") %>%
  image_scale("x220") %>%
  image_crop("190x220+100") %>%
  image_modulate(brightness = 120, saturation = 140, hue = 90)

figure4 <- image_read("meme_chadt.jpeg") %>%
  image_scale("200") %>%
  image_scale("x220") %>%
  image_crop("190x220+30") %>%
  image_modulate(brightness = 80, saturation = 0, hue = 0)

# now we make the frames needed to be attached to the background
frame1 <- image_composite(background, count1, offset = "+100+100")
frame2 <- image_composite(background, count2, offset = "+100+100")
frame3 <- image_composite(background, count3, offset = "+100+100")
frame4 <- image_composite(background, figure1, offset = "+100+100")
frame5 <- image_composite(background, figure2, offset = "+100+100")
frame6 <- image_composite(background, figure3, offset = "+100+100")
frame7 <- image_composite(background, figure4, offset = "+100+100")

# make the frames into vector
frames <- c(frame1, frame2, frame3, frame4, frame5, frame6, frame7)
gif_meme <- image_morph(frames) %>%
  image_animate(fps = 10)
image_write(gif_meme, "animated_gif.gif")
  