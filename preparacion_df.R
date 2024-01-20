library(tidyverse)

df_og <- read_csv("listings_bcn.csv")

# Para la elaboración de la app, simplemente necesitamos aquellos datos que sean. 
# propios del piso en si, y que sea cuantitativo o cualitativo.
# Cualquier cosa relacionada que no sea relevante en torno al piso se descarta.

df <- df_og |>
  select(id, 
         name, # A pesar de que no es cualitativo, nos sirve para identificar al piso
         neighbourhood_group_cleansed,
         latitude,
         longitude,
         property_type,
         room_type,
         accommodates,
         bathrooms,
         bathrooms_text,
         bedrooms,
         beds,
         amenities,
         price,
         minimum_nights,
         maximum_nights,
         maximum_minimum_nights,
         maximum_maximum_nights,
         minimum_maximum_nights,
         maximum_maximum_nights,
         minimum_nights_avg_ntm,
         maximum_nights_avg_ntm,
         has_availability,
         availability_30,
         availability_60,
         availability_90,
         availability_365,
         number_of_reviews,
         number_of_reviews_ltm,
         number_of_reviews_l30d,
         review_scores_rating,
         review_scores_accuracy,
         review_scores_cleanliness,
         review_scores_checkin,
         review_scores_communication,
         review_scores_location,
         review_scores_value
         ) 

  
