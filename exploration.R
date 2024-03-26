library(tidyverse)
learning_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS-qRVlqsgaz1ntKa4Ll_t2DukzzoIZQWtp7d_EkvDYsygNetUD9c73-OuzJezEDNwEFIP1R-s3EurI/pub?output=csv") %>%
  view()
survey_data_renamed <- learning_data[c(-1)] %>%
  rename(age = 1,
         gender = 2,
         occupation = 3,
         study_time = 4,
         event_stu = 5,
         event_stu_time = 6,
         selfrate_stu = 7,
         task_time = 8,
         event_otr = 9,
         event_otr_time = 10,
         self_rate_otr = 11) %>%
  print()

survey_data_longer <- survey_data_renamed %>%
  separate_rows(event_stu, event_otr, sep = ", ") %>%
  print(n = 50)

survey_data_longer %>%
  drop_na(event_stu) %>%
  ggplot() +
  geom_bar(aes(y = event_stu)
           )

survey_data_longer %>%
  drop_na(study_time) %>%
  ggplot() +
  geom_boxplot(aes(x = gender,
               y = study_time),
               fill = "#ADD8E6",
               outlier.color = "red") + 
  labs(title = "Students' Study Time across Genders",
       subtitle = "Comparing students' study times among different genders",
       x = "Gender (identified)",
       y = "Study Time (hours)"
       )

