library(shiny)
library(DT)  # Para tablas interactivas

# Cargo el archivo RDS
df_shiny <- readRDS("clean_airbnb_data.rds")

# Datos
lista_barrios <- unique(df_shiny$barrio)

# Shiny
# UI
ui <- fluidPage(
  titlePanel("Airbnb Apartment Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      
      h1("Menú de filtros"),
      
      h2("Localización"),
      
      selectInput("barrio", "Barrio", choices = lista_barrios),
      
      sliderInput("latitud", "Latitud", value = c(41.35186, 41.45956), min = 41.35186, max = 41.45956, step = 0.001),
      
      sliderInput("longitud", "Longitud", value = c(2.15899, 2.18336), min = 2.15899, max = 2.18336, step = 0.001),
      
      br(),
      
      h2("Características de la propiedad"),
      
      selectInput("tipo_propiedad", "Tipo de propiedad", choices = unique(df_shiny$tipo_propiedad)),
      
      sliderInput("capacidad", "Capacidad de personas", value = c(min(df_shiny$capacidad), max(df_shiny$capacidad)), min = min(df_shiny$capacidad), max = max(df_shiny$capacidad), step = 1),
      
      sliderInput("banos", "Número de baños", value = c(min(df_shiny$banos), max(df_shiny$banos)), min = min(df_shiny$banos), max = max(df_shiny$banos), step = 0.5),
      
      selectInput("bano_compartido", "Baño compartido", choices = unique(df_shiny$bano_compartido)),
      
      sliderInput("dormitorios", "Número de dormitorios", value = c(min(df_shiny$dormitorios), max(df_shiny$dormitorios)), min = min(df_shiny$dormitorios), max = max(df_shiny$dormitorios), step = 1),
      
      sliderInput("camas", "Número de camas", value = c(min(df_shiny$camas), max(df_shiny$camas)), min = min(df_shiny$camas), max = max(df_shiny$camas), step = 1),
      
      br(),
      
      h2("Condiciones de la reserva"),
      
      sliderInput("precio", "Precio", value = c(min(df_shiny$precio), max(df_shiny$precio)), min = min(df_shiny$precio), max = max(df_shiny$precio), step = 1),
      
      sliderInput("noches_minimas", "Noches mínimas", value = min(df_shiny$noches_minimas), min = min(df_shiny$noches_minimas), max = max(df_shiny$noches_minimas), step = 1),
      
      sliderInput("noches_maximas", "Noches máximas", value = min(df_shiny$noches_maximas), min = min(df_shiny$noches_maximas), max = max(df_shiny$noches_maximas), step = 1),
      
      br(),
      
      h2("Disponibilidad"),
      
      selectInput("disponible", "¿Está disponible?", choices = unique(df_shiny$disponible)),
      
      numericInput("disponibilidad_30", "Mínimo de disponibilidad en los próximos 30 dias", value=0, min=0, max=30),
      
      numericInput("disponibilidad_60", "Mínimo de disponibilidad en los próximos 60 dias", value=0, min=0, max=60),
      
      numericInput("disponibilidad_90", "Mínimo de disponibilidad en los próximos 90 dias", value=0, min=0, max=90),
      
      numericInput("disponibilidad_365", "Mínimo de disponibilidad en los próximos 365 dias", value=0, min=0, max=365),
      
      numericInput("n_reviews_u30d", "Mínimo de reviews en los últimos 30 días", value=0, min=0, max=max(df_shiny$number_of_reviews_l30d)),
      
      br(),
      
      h2("Reseñas"),
      
      sliderInput("puntuacion_reviews_general", "Puntuación reviews", value = min(df_shiny$puntuacion_reviews_general), min = min(df_shiny$puntuacion_reviews_general), max = max(df_shiny$puntuacion_reviews_general), step = 0.1),
      
      sliderInput("puntuacion_reviews_precision", "Puntuación reviews en precisión", value = min(df_shiny$puntuacion_reviews_precision), min = min(df_shiny$puntuacion_reviews_precision), max = max(df_shiny$puntuacion_reviews_precision), step = 0.1),
      
      sliderInput("puntuacion_reviews_limpieza", "Puntuación reviews en limpieza", value = min(df_shiny$puntuacion_reviews_limpieza), min = min(df_shiny$puntuacion_reviews_limpieza), max = max(df_shiny$puntuacion_reviews_limpieza), step = 0.1),
      
      sliderInput("puntuacion_reviews_checkin", "Puntuación reviews en check-in", value = min(df_shiny$puntuacion_reviews_checkin), min = min(df_shiny$puntuacion_reviews_checkin), max = max(df_shiny$puntuacion_reviews_checkin), step = 0.1),
      
      sliderInput("puntuacion_reviews_comunicacion", "Puntuación reviews en comunicación", value = min(df_shiny$puntuacion_reviews_comunicacion), min = min(df_shiny$puntuacion_reviews_comunicacion), max = max(df_shiny$puntuacion_reviews_comunicacion), step = 0.1),
      
      sliderInput("puntuacion_reviews_localizacion", "Puntuación reviews en localización", value = min(df_shiny$puntuacion_reviews_localizacion), min = min(df_shiny$puntuacion_reviews_localizacion), max = max(df_shiny$puntuacion_reviews_localizacion), step = 0.1),
      
      sliderInput("puntuacion_reviews_valor", "Puntuación reviews en valor", value = min(df_shiny$puntuacion_reviews_valor), min = min(df_shiny$puntuacion_reviews_valor), max = max(df_shiny$puntuacion_reviews_valor), step = 0.1),
      
    ),
    
    mainPanel(
      
      h1("Tabla filtrada"),
      
      DTOutput("tablaFiltrada")
    )
  )
)

server <- function(input, output) {
  # Crear un dataframe reactivo que se actualiza con los filtros
  dataframeFiltrado <- reactive({
    df_temp <- df_shiny
    # Aplicar filtros según las entradas del usuario
    # Por ejemplo:
    # df_temp <- df_temp[df_temp$barrio == input$barrio, ]
    # Repite el proceso para cada filtro. Por ejemplo:
    # if (!is.null(input$tipo_propiedad)) {
    #   df_temp <- df_temp[df_temp$tipo_propiedad == input$tipo_propiedad, ]
    # }
    # Continúa aplicando filtros de manera similar para los demás inputs
    df_temp
  })
  
  # Renderizar la tabla
  output$tablaFiltrada <- renderDT({
    datatable(dataframeFiltrado())
  })
}

shinyApp(ui = ui, server = server)
                                                                                                                                                
