library(shiny)
library(DT)

# Carga el archivo RDS
df_shiny <- readRDS("clean_airbnb_data.rds")

# Ajustes para el filtrado
df_shiny$barrio <- as.character(df_shiny$barrio)
df_shiny$tipo_propiedad <- as.character(df_shiny$tipo_propiedad)

# UI
ui <- fluidPage(
  titlePanel("Airbnb Apartment Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      h1("Menú de filtros"),
      
      br(),
      
      h2("Localización"),
      selectInput("barrio", "Barrio", choices = c("Todos", unique(df_shiny$barrio))),
      sliderInput("latitud", "Latitud", value = c(min(df_shiny$latitud, na.rm = TRUE), max(df_shiny$latitud, na.rm = TRUE)), min = min(df_shiny$latitud, na.rm = TRUE), max = max(df_shiny$latitud, na.rm = TRUE), step = 0.001),
      sliderInput("longitud", "Longitud", value = c(min(df_shiny$longitud, na.rm = TRUE), max(df_shiny$longitud, na.rm = TRUE)), min = min(df_shiny$longitud, na.rm = TRUE), max = max(df_shiny$longitud, na.rm = TRUE), step = 0.001),
      
      br(),
      
      h2("Características de la propiedad"),
      selectInput("tipo_propiedad", "Tipo de propiedad", choices = c("Todos", unique(df_shiny$tipo_propiedad))),
      sliderInput("capacidad", "Capacidad de personas", value = c(min(df_shiny$capacidad, na.rm = TRUE), max(df_shiny$capacidad, na.rm = TRUE)), min = min(df_shiny$capacidad, na.rm = TRUE), max = max(df_shiny$capacidad, na.rm = TRUE), step = 1),
      sliderInput("banos", "Número de baños", value = c(min(df_shiny$banos, na.rm = TRUE), max(df_shiny$banos, na.rm = TRUE)), min = min(df_shiny$banos, na.rm = TRUE), max = max(df_shiny$banos, na.rm = TRUE), step = 0.5),
      selectInput("bano_compartido", "Baño compartido", choices = c("Todos", unique(df_shiny$bano_compartido))),
      sliderInput("dormitorios", "Número de dormitorios", value = c(min(df_shiny$dormitorios, na.rm = TRUE), max(df_shiny$dormitorios, na.rm = TRUE)), min = min(df_shiny$dormitorios, na.rm = TRUE), max = max(df_shiny$dormitorios, na.rm = TRUE), step = 1),
      sliderInput("camas", "Número de camas", value = c(min(df_shiny$camas, na.rm = TRUE), max(df_shiny$camas, na.rm = TRUE)), min = min(df_shiny$camas, na.rm = TRUE), max = max(df_shiny$camas, na.rm = TRUE), step = 1),
      
      br(),
      
      h2("Condiciones de la reserva"),
      sliderInput("precio", "Precio", value = c(min(df_shiny$precio, na.rm = TRUE), max(df_shiny$precio, na.rm = TRUE)), min = min(df_shiny$precio, na.rm = TRUE), max = max(df_shiny$precio, na.rm = TRUE), step = 1),
      sliderInput("noches_minimas", "Noches mínimas", value = c(min(df_shiny$noches_minimas, na.rm = TRUE), max(df_shiny$noches_minimas, na.rm = TRUE)), min = min(df_shiny$noches_minimas, na.rm = TRUE), max = max(df_shiny$noches_minimas, na.rm = TRUE), step = 1),
      sliderInput("noches_maximas", "Noches máximas", value = c(min(df_shiny$noches_maximas, na.rm = TRUE), max(df_shiny$noches_maximas, na.rm = TRUE)), min = min(df_shiny$noches_maximas, na.rm = TRUE), max = max(df_shiny$noches_maximas, na.rm = TRUE), step = 1),
      
      br(),
      
      h2("Disponibilidad"),
      selectInput("disponible", "¿Está disponible?", choices = c("Todos", unique(df_shiny$disponible))),
      numericInput("disponibilidad_30", "Mínimo de disponibilidad en los próximos 30 días", value = 0, min = 0, max = 30),
      numericInput("disponibilidad_60", "Mínimo de disponibilidad en los próximos 60 días", value = 0, min = 0, max = 60),
      numericInput("disponibilidad_90", "Mínimo de disponibilidad en los próximos 90 días", value = 0, min = 0, max = 90),
      numericInput("disponibilidad_365", "Mínimo de disponibilidad en los próximos 365 días", value = 0, min = 0, max = 365),
      
      br(),
      
      h2("Reseñas"),
      sliderInput("puntuacion_reviews_general", "Puntuación general de reseñas", value = c(min(df_shiny$puntuacion_reviews_general, na.rm = TRUE), max(df_shiny$puntuacion_reviews_general, na.rm = TRUE)), min = min(df_shiny$puntuacion_reviews_general, na.rm = TRUE), max = max(df_shiny$puntuacion_reviews_general, na.rm = TRUE), step = 0.1),
      sliderInput("puntuacion_reviews_precision", "Puntuación de reseñas en precisión", value = c(min(df_shiny$puntuacion_reviews_precision, na.rm = TRUE), max(df_shiny$puntuacion_reviews_precision, na.rm = TRUE)), min = min(df_shiny$puntuacion_reviews_precision, na.rm = TRUE), max = max(df_shiny$puntuacion_reviews_precision, na.rm = TRUE), step = 0.1),
      sliderInput("puntuacion_reviews_limpieza", "Puntuación de reseñas en limpieza", value = c(min(df_shiny$puntuacion_reviews_limpieza, na.rm = TRUE), max(df_shiny$puntuacion_reviews_limpieza, na.rm = TRUE)), min = min(df_shiny$puntuacion_reviews_limpieza, na.rm = TRUE), max = max(df_shiny$puntuacion_reviews_limpieza, na.rm = TRUE), step = 0.1),
      sliderInput("puntuacion_reviews_checkin", "Puntuación de reseñas en check-in", value = c(min(df_shiny$puntuacion_reviews_checkin, na.rm = TRUE), max(df_shiny$puntuacion_reviews_checkin, na.rm = TRUE)), min = min(df_shiny$puntuacion_reviews_checkin, na.rm = TRUE), max = max(df_shiny$puntuacion_reviews_checkin, na.rm = TRUE), step = 0.1),
      sliderInput("puntuacion_reviews_comunicacion", "Puntuación de reseñas en comunicación", value = c(min(df_shiny$puntuacion_reviews_comunicacion, na.rm = TRUE), max(df_shiny$puntuacion_reviews_comunicacion, na.rm = TRUE)), min = min(df_shiny$puntuacion_reviews_comunicacion, na.rm = TRUE), max = max(df_shiny$puntuacion_reviews_comunicacion, na.rm = TRUE), step = 0.1),
      sliderInput("puntuacion_reviews_localizacion", "Puntuación de reseñas en localización", value = c(min(df_shiny$puntuacion_reviews_localizacion, na.rm = TRUE), max(df_shiny$puntuacion_reviews_localizacion, na.rm = TRUE)), min = min(df_shiny$puntuacion_reviews_localizacion, na.rm = TRUE), max = max(df_shiny$puntuacion_reviews_localizacion, na.rm = TRUE), step = 0.1),
      sliderInput("puntuacion_reviews_valor", "Puntuación de reseñas en valor", value = c(min(df_shiny$puntuacion_reviews_valor, na.rm = TRUE), max(df_shiny$puntuacion_reviews_valor, na.rm = TRUE)), min = min(df_shiny$puntuacion_reviews_valor, na.rm = TRUE), max = max(df_shiny$puntuacion_reviews_valor, na.rm = TRUE), step = 0.1)
      
    ),
    mainPanel(
      h1("Tabla filtrada"),
      DTOutput("tablaFiltrada")
    )
  )
)

server <- function(input, output) {
    output$tablaFiltrada <- renderDT({
      filtered_data <- df_shiny
      
      # Filtrado con dplyr
      filtered_data <- filtered_data %>%
        filter(if(input$barrio != "Todos") barrio == input$barrio else TRUE) %>%
        filter(if(input$tipo_propiedad != "Todos") tipo_propiedad == input$tipo_propiedad else TRUE) %>%
        filter(if(input$disponible != "Todos") disponible == (input$disponible == "Sí") else TRUE) %>%
        filter(latitud >= input$latitud[1], latitud <= input$latitud[2]) %>%
        filter(longitud >= input$longitud[1], longitud <= input$longitud[2]) %>%
        filter(capacidad >= input$capacidad[1], capacidad <= input$capacidad[2]) %>%
        filter(banos >= input$banos[1], banos <= input$banos[2]) %>%
        filter(dormitorios >= input$dormitorios[1], dormitorios <= input$dormitorios[2]) %>%
        filter(camas >= input$camas[1], camas <= input$camas[2]) %>%
        filter(precio >= input$precio[1], precio <= input$precio[2]) %>%
        filter(noches_minimas >= input$noches_minimas[1], noches_minimas <= input$noches_minimas[2]) %>%
        filter(noches_maximas >= input$noches_maximas[1], noches_maximas <= input$noches_maximas[2]) %>%
        filter(disponibilidad_30 >= input$disponibilidad_30) %>%
        filter(disponibilidad_60 >= input$disponibilidad_60) %>%
        filter(disponibilidad_90 >= input$disponibilidad_90) %>%
        filter(disponibilidad_365 >= input$disponibilidad_365) %>%
        filter(puntuacion_reviews_general >= input$puntuacion_reviews_general[1], puntuacion_reviews_general <= input$puntuacion_reviews_general[2]) %>%
        filter(puntuacion_reviews_precision >= input$puntuacion_reviews_precision[1], puntuacion_reviews_precision <= input$puntuacion_reviews_precision[2]) %>%
        filter(puntuacion_reviews_limpieza >= input$puntuacion_reviews_limpieza[1], puntuacion_reviews_limpieza <= input$puntuacion_reviews_limpieza[2]) %>%
        filter(puntuacion_reviews_checkin >= input$puntuacion_reviews_checkin[1], puntuacion_reviews_checkin <= input$puntuacion_reviews_checkin[2]) %>%
        filter(puntuacion_reviews_comunicacion >= input$puntuacion_reviews_comunicacion[1], puntuacion_reviews_comunicacion <= input$puntuacion_reviews_comunicacion[2]) %>%
        filter(puntuacion_reviews_localizacion >= input$puntuacion_reviews_localizacion[1], puntuacion_reviews_localizacion <= input$puntuacion_reviews_localizacion[2]) %>%
        filter(puntuacion_reviews_valor >= input$puntuacion_reviews_valor[1], puntuacion_reviews_valor <= input$puntuacion_reviews_valor[2])
      
      datatable(filtered_data)
    })
  }
  



# Ejecuta la aplicación
shinyApp(ui = ui, server = server)




