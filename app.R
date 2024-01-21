library(shiny)
library(DT)  # Para tablas interactivas

# Cargo el archivo RDS
df_shiny <- readRDS("clean_airbnb_data.rds")

# Datos
lista_barrios <- unique(df_shiny$barrio)

# Shiny
# UI
ui <- fluidPage(
  titlePanel("AirBnb Apartment Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("barrio",
                  "Barrio",
                  unique(df_shiny$barrio)),
      
      sliderInput("latitud",
                  "Latitud",
                  value = c(41.35186, 41.45956),
                  min = 41.35186,
                  max = 41.45956,
                  step = 0.001),
      
      sliderInput("longitud",
                  "Longitud",
                  value = c(41.35186, 41.45956),
                  min = 41.35186,
                  max = 41.45956,
                  step = 0.001),
      
      selectInput("tipo_propiedad",
                  "Tipo de propiedad",
                  choices = c(1, 2)),
      
      sliderInput("capacidad",
                  "Capacidad de personas",
                  value = c(min(df_shiny$capacidad), max(dfshiny$capacidad)),
                  min = min(df_shiny$capacidad),
                  max = max(dfshiny$capacidad),
                  step = 1),
      
      sliderInput("banos",
                  "Número de baños",
                  value = c(min(df_shiny$banos), max(dfshiny$banos)),
                  min = min(df_shiny$banos),
                  max = max(dfshiny$banos),
                  step = 0.5),
      
      selectInput("bano_compartido",
                  "Baño compartido",
                  unique(df_shiny$bano_compartido)),
      
      sliderInput("dormitorios",
                  "Número de dormitorios",
                  value = c(min(df_shiny$dormitorios), max(dfshiny$dormitorios)),
                  min = min(df_shiny$dormitorios),
                  max = max(dfshiny$dormitorios),
                  step = 1),
      
      sliderInput("camas",
                  "Número de camas",
                  value = c(min(df_shiny$camas), max(dfshiny$camas)),
                  min = min(df_shiny$camas),
                  max = max(dfshiny$camas),
                  step = 1),
      
      sliderInput("precio",
                  "Precio",
                  value = c(min(df_shiny$precio), max(dfshiny$precio)),
                  min = min(df_shiny$precio),
                  max = max(dfshiny$precio),
                  step = 1),
      
      sliderInput("noches_minimas",
                  "Noches mínimas",
                  value = min(df_shiny$noches_minimas),
                  min = min(df_shiny$noches_minimas),
                  max = max(dfshiny$noches_minimas),
                  step = 1),
      
      sliderInput("noches_maximas",
                  "Noches mínimas",
                  value = min(df_shiny$noches_minimas),
                  min = min(df_shiny$noches_minimas),
                  max = max(dfshiny$noches_minimas),
                  step = 1),
      
      sliderInput("disponible")
      
      # Añade tantos filtros como necesites
    ),
    mainPanel(
      DTOutput("tablaFiltrada")
    )
  )
)


server <- function(input, output) {
  # Supongamos que 'mi_dataframe' es tu dataframe original
  df_shiny <- readRDS("clean_airbnb_data.rds")  
  # Crear un dataframe reactivo que se actualiza con los filtros
  dataframeFiltrado <- reactive({
    df_temp <- df_shiny
    # Aplicar filtros
    # Ejemplo: df_temp <- df_temp[df_temp$columna == input$filtro1, ]
    # Repite el proceso para cada filtro
    df_temp
  })
  
  # Renderizar la tabla
  output$tablaFiltrada <- renderDT({
    datatable(dataframeFiltrado())
  })
}


shinyApp(ui = ui, server = server)

