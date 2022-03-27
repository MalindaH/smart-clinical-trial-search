library(shiny)
library(shinythemes)

source("function.R")

if(!"r-reticulate" %in% conda_list()$name){
  conda_create("r-reticulate")
  conda_install("r-reticulate", "rdkit")
  conda_install("r-reticulate", "numpy")
  conda_install("r-reticulate", "pandas")
}
use_condaenv("r-reticulate")
rdkit <- import('rdkit')
numpy <- import('numpy')
pandas <- import('pandas')

####################################################################################

shinyApp(
  ui <- navbarPage("Smart Clinical Trial Search for Small Molecule Drugs",
                   tabPanel("Query",fluidPage(theme = shinytheme("flatly")),
                            tags$head(
                              tags$style(HTML(".shiny-output-error-validation{color: red;}"))),
                            sidebarLayout(
                              sidebarPanel(
                                p("Compare the molecular fingerprint similarity to give you the most up-to-date clinical trial information."),
                                hr(), 
                                p("Please start by entering the SMILES of your drug of interest:\n"),
                                textInput("drugname", "SMILES of Drug of Interest", "COC1=C(OCCCN2CCOCC2)C=C2C(NC3=CC(Cl)=C(F)C=C3)=NC=NC2=C1"),
                                verbatimTextOutput("value"),
                                div(
                                  sliderInput("threshold", label="Similarity Threshold",min=0,value=0.7,max=1,step=0.05)),
                                width=3
                                ),
                              mainPanel(
                                div(DT::dataTableOutput("tbl"), style = "font-size: 100%; width: 110%")
                              )
                            )),
                   tabPanel("About",
                            div(p("This is a smart clinical search engine for the clinical trial information of your drug of interest, based on molecular similarity between your input and drugs in the government clinical trial database\n",style = "font-size:20px"), 
                              hr(),
                              p("We collect clinical trial data from various databases, including",
                              a("ClinicalTrials.gov", href="https://clinicaltrials.gov/ct2/results?cond=&term=small+molecule&cntry=&state=&city=&dist=&Search=Search&recrs=e", target="_blank"),
                              "from US NIH, identify the small molecules used in clinical trials, and retrieve SMILES of the small molecules from ",
                              a("DrugBank", href="https://go.drugbank.com/releases/latest", target="_blank"), 
                              "for molecular fingerprint similarity calculation.",style = "font-size:16px"),
                              p("Our molecular similarity calculation is powered by ",
                              a("RDKit", href="https://www.rdkit.org/docs/GettingStartedInPython.html", target="_blank"),
                              " . Only clinical trial information with similar drugs are shown.",style = "font-size:16px"),
                              style = "padding: 0 100px 0 100px;")
                   ),
                  tabPanel("Authors",
                       tags$div(
                         p("Authors:",style = "font-size:25px"),
                        p(a("Malinda Huang", href="https://github.com/MalindaH", target="_blank"),style = "font-size:25px"),
                       p("e-mail: malindahuanglh@gmail.com",style = "font-size:20px"),
                       p(a("Mingyang Ma", href="https://github.com/Anthonyma0706", target="_blank"),style = "font-size:25px"),
                       p("e-mail: mingyang.ma@mail.mcgill.ca",style = "font-size:20px"),
                       p(a("Meihan Liu", href="", target="_blank"),style = "font-size:25px"),
                       p("e-mail: mollyliu0201@gmail.com",style = "font-size:20px"),
                       hr(),
                       a("GitHub link",href="https://github.com/MalindaH/smart-clinical-trial-search",style = "font-size:20px"),
                       p("Developed in PharmaHacks 2022"), style = "padding: 0 100px 0 100px; text-align: center;"))
                   ),
  
  server = function(input, output) {
    update_data <- reactive({
      get_df_to_display(input$drugname, input$threshold)
    })
    
    output$tbl <- DT::renderDataTable(
      DT::datatable(
        update_data(), rownames = FALSE, options = list(
          order = list(0, 'desc'),
          autoWidth = TRUE,
          columnDefs = list(
            list(targets=c(1), visible=TRUE, width='400'),
            list(targets=c(6), visible=TRUE, width='100'),
            list(targets=c(11), visible=TRUE, width='200'),
            list(targets='_all', visible=TRUE)
            ),
          pageLength = 6,
          scrollX = T,
          lengthMenu = c(6, 10, 15, 20)
        ) 
      ) %>% formatRound(columns=1, digits=3)
    )
  }
)


