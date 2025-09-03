# app.R
library(shiny)

make_boxes_data <- function(dob, expected_age, granularity) {
  start_date <- as.Date(dob)
  today <- Sys.Date()
  
  if (granularity == "Weeks") {
    total_units <- ceiling(expected_age * 52.18)
    n_cols <- 52
    dates <- seq.Date(start_date, by = "week", length.out = total_units)
    
    # Current week index
    wi <- floor(as.numeric(difftime(today, start_date, units = "weeks"))) + 1
    current_idx <- if (wi > 0 && wi <= total_units) wi else NA
  } else {
    total_units <- ceiling(expected_age * 12)
    n_cols <- 12
    
    # Start from the first day of the birth month
    month_start <- as.Date(format(start_date, "%Y-%m-01"))
    dates <- seq.Date(month_start, by = "month", length.out = total_units)
    
    # Calculate month index difference
    year_diff <- as.integer(format(today, "%Y")) - as.integer(format(month_start, "%Y"))
    month_diff <- as.integer(format(today, "%m")) - as.integer(format(month_start, "%m"))
    mi <- year_diff * 12 + month_diff + 1
    current_idx <- if (mi > 0 && mi <= total_units) mi else NA
  }
  
  df <- data.frame(date = dates)
  df$lived <- df$date <= today
  df$today <- FALSE
  if (!is.na(current_idx)) {
    df$today[current_idx] <- TRUE
  }
  
  df$status <- ifelse(df$today, "current",
                      ifelse(df$lived, "lived", "future"))
  df$status <- factor(df$status, levels = c("lived", "future", "current"))
  
  df$idx <- seq_len(nrow(df))
  df$row <- floor((df$idx - 1) / n_cols) + 1
  df$col <- ((df$idx - 1) %% n_cols) + 1
  
  return(df)
}

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet",
              href = "https://fonts.googleapis.com/css2?family=Inter:wght@300;600&family=Work+Sans:wght@400;600&display=swap"),
    tags$style(HTML("
      body { font-family:'Work Sans',sans-serif; background:#f8f9fa; margin:0; padding:0 }
      .header { background:#e9ecef; padding:30px 20px; display:flex; align-items:center; gap:40px }
      .header h1 { font-family:'Inter',sans-serif; font-size:3.5rem; font-weight:300; margin:0 }
      .header p { font-size:1.8rem; line-height:1.4; margin:0 }
      
      .sidebar-section { margin-bottom:20px }
      .stats-global-compact { 
        background:#fff; padding:10px; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.08);
        margin-top:20px; 
      }
      .stats-global-compact div { margin:6px 0; font-family:'Inter',sans-serif; color:#2c3e50 }
      .stats-global-compact .value { font-weight:600; font-size:1.2rem }
      .stats-global-compact .label { font-size:0.9rem; color:#7f8c8d; margin-left:6px }
      
      .legend { display:flex; justify-content:center; gap:20px; margin: 18px 0 10px}
      .legend-box { width:14px; height:14px; border-radius:3px; border:1px solid #ccc }
      .grid { background:#fff; padding:12px; border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.1) }
    "))
  ),

  div(class = "header",
      h1("Memento Mori"),
      div(
        p("I make time tangible. It reminds us how silently life slips away."),
        p("It calls us to pause, reflect, and question our very existence—beyond survival, toward meaning.")
      )
  ),

  sidebarLayout(
    sidebarPanel(width = 3,
      div(class = "sidebar-section",
          dateInput("dob", "Date of Birth", 
                    value = as.Date("1990-01-01"), max = Sys.Date()),
          sliderInput("life_exp", "Life Expectancy (years)",
                      min = 50, max = 100, value = 73.4, step = 0.1),
          radioButtons("granularity", "View Mode", 
                       choices = c("Weeks","Months"), selected = "Months")
      ),
      div(class = "stats-global-compact",
          div(span("70.8", class = "value"), span("Global Male LE", class = "label")),
          div(span("76.0", class = "value"), span("Global Female LE", class = "label")),
          div(span("73.4", class = "value"), span("Overall Global LE", class = "label"))
      )
    ),

    mainPanel(width = 9,
      div(class = "legend",
          div(class = "legend-box", style = "background:#3498db"), span("Lived"),
          div(class = "legend-box", style = "background:#ecf0f1; border:1px solid #ccc"), span("Future"),
          div(class = "legend-box", style = "background:#e74c3c"), span("Current")
      ),
      div(class = "grid", plotOutput("grid_plot", height = "480px"))
    )
  )
)

server <- function(input, output, session) {
  df <- reactive(make_boxes_data(input$dob, input$life_exp, input$granularity))

  output$grid_plot <- renderPlot({
    d <- df()
    par(mar = c(0, 0, 0, 0))
    plot(NA, xlim = c(0, max(d$col) + 1), ylim = c(-max(d$row) - 1, 0),
         xaxs = "i", yaxs = "i", axes = FALSE, xlab = "", ylab = "")
    
    colors <- ifelse(d$status == "lived", "#3498db",
              ifelse(d$status == "current", "#e74c3c", "#ecf0f1"))
    
    rect(d$col - 0.45, -d$row - 0.45, d$col + 0.45, -d$row + 0.45,
         col = colors, border = "white", lwd = 0.5)
  })
}

shinyApp(ui, server)
