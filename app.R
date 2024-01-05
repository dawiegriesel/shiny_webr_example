library(shiny)
library(bslib)
library(thematic)

# Define UI for application that draws a histogram
ui <- page_sidebar(
    theme = bs_theme(version = 5, bootswatch = "minty"),
    title = "Hello Shinylive!",
    sidebar = sidebar(
        bslib::input_dark_mode(),
        sliderInput("bins",
                    "Number of bins:",
                    min = 1,
                    max = 50,
                    value = 30)
    ),
    card(
        full_screen = TRUE,
        card_header("Old Faithful Geyser Data"),
        plotOutput("distPlot")
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
}

# Run the application 
thematic_shiny()
shinyApp(ui = ui, server = server)

# # create webR app
# shinylive::export(appdir = "./", destdir = "docs")
## test local
# httpuv::runStaticServer("docs/", port=8008)
