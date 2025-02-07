
##-- App part
ui <- dashboardPage(
  dashboardHeader(title = "Pfizer County Hospitals Potential"),
  dashboardSidebar(
    tags$head(includeCSS('./www/fix_siderbar.css')),
    collapsed = FALSE,
    # fluidRow(column(12, fileInput('summary', 'Please Upload the Raw Data'))),
    br(),
    conditionalPanel(condition = "input.tabselected == 1",
                     selectInput("year", "Year", choices = "", multiple = FALSE)),
    conditionalPanel(condition = "input.tabselected == 2",
                     selectInput("channel", "Channel", choices = c("City" = "city", "County" = "county"), 
                                 selected = c("city", "county"), multiple = TRUE)),
    selectInput("mkt", "Market", choices = "", multiple = FALSE),
    selectInput("province", "Province", choices = "", multiple = TRUE),
    selectInput("chc", "Contain CHC", choices = c("Yes" = "yes", "No" = "no"), selected = "yes", multiple = FALSE),
    
    br(),
    fluidRow(
      tags$div(
        column(12,
               tags$div(actionButton("goButton", "Go!", width = "90px"),
                        style = "display:inline-block; margin-down:1px; vertical-align:middle;"),
               tags$div(downloadButton("download", "Download"),
                        style = "display:inline-block; margin-down:1px; vertical-align:middle;")),
        tags$style(".skin-blue .sidebar a { color: #444; }")
        
        # tags$div(column(#offset = 1, 
        #   2,
        #   downloadButton(outputId = "downloadData", 
        #                  label = "Download")),
        #   style = "display:inline-block;margin-down: 1px;vertical-align:middle")
      )
    )
  ),
  
  dashboardBody(
    useShinyjs(),
    br(),
    tabsetPanel(
      tabPanel(strong("High Level Summary Statistics"), value=1,
               br(),
               fluidRow(
                 box(title = "Cities and Hospitals Statistics",
                     width = 12,
                     solidHeader = TRUE,
                     status = "primary",
                     
                     # fluidRow(column(3, uiOutput("sub_cat_ui"))),
                     # fluidRow(
                     column(width = 4,
                            # offset = 1,
                            div(DT::dataTableOutput("summary_table"), 
                                style = "font-size:90%")),
                     # column(width = 3,
                     #        offset = 1,
                     #        div(DT::dataTableOutput("summary_table1"),
                     #            style = "font-size:90%"),
                     #        br(),
                     #        div(plotlyOutput("summary_bar1", height = "180px"), 
                     #            style = "font-size:90%")
                     # ),
                     # 
                     # column(width = 2,
                     #        offset = 1,
                     #        div(DT::dataTableOutput("summary_table2"),
                     #            style = "font-size:90%"),
                     #        br(),
                     #        div(plotlyOutput("summary_bar2", height = "180px"), 
                     #            style = "font-size:90%")
                     # )
                     # style = "height:200px"
                     # )
                     column(
                       width = 7,
                       offset = 1,
                       fluidRow(
                         column(width = 6,
                                div(DT::dataTableOutput("summary_table1"),
                                    style = "font-size:90%")),
                         column(width = 5,
                                offset = 1,
                                div(DT::dataTableOutput("summary_table2"),
                                    style = "font-size:90%"))
                       ),
                       br(),
                       fluidRow(
                         column(width = 6,
                                div(plotlyOutput("summary_bar1", height = "180px"), 
                                    style = "font-size:90%")),
                         column(width = 5,
                                offset = 1,
                                div(plotlyOutput("summary_bar2", height = "180px"), 
                                    style = "font-size:90%"))
                       )
                     )
                 )
               ),
               
               fluidRow(
                 box(
                   title = "Current Potential by City", 
                   status = "primary",
                   solidHeader = TRUE,
                   collapsible = FALSE,
                   width = 12,
                   
                   br(),
                   h5("1, Current Potential Contribution by City (Tablet/Million)"),
                   br(),
                   div(DT::dataTableOutput("current_potential_by_city"),
                       style = "font-size:90%; overflow-x:scroll;"),
                   
                   br(), br(),
                   h5("2, City Rank of Current Potential Contribution (Tablet/Million)"),
                   br(),
                   div(plotlyOutput("city_rank_current_potential", height = "300px"),
                       style = "font-size:90%; overflow-x:scroll;"),
                   
                   br(), br(),
                   h5("3, Channel Distribution of Current Potential Contribution by City (Tablet/Million)"),
                   br(),
                   div(plotlyOutput("channel_distribution_current_potential_by_city", height = "300px"),
                       style = "font-size:90%; overflow-x:scroll;")
                 )
               ),
               
               fluidRow(
                 box(
                   title = "Channel Distribuion of Hospital Counts by City", 
                   status = "primary",
                   solidHeader = TRUE,
                   collapsible = FALSE,
                   width = 12,
                   
                   br(),
                   # h3("Current Potential Contribution by City (Tablet/Million)"),
                   # br(),
                   div(DT::dataTableOutput("channel_dist_hospital_cnt_by_city"),
                       style = "font-size:90%; overflow-x:scroll;")
                 )
               ),
               
               fluidRow(
                 box(
                   title = "Total Potential and Share by City", 
                   status = "primary",
                   solidHeader = TRUE,
                   collapsible = FALSE,
                   width = 12,
                   
                   br(),
                   h5("1, Total Current Potential and Share by City (Tablet/Million)"),
                   br(),
                   div(DT::dataTableOutput("total_current_potential_share_by_city"),
                       style = "font-size:90%; overflow-x:scroll;"),
                   
                   br(), br(),
                   h5("2, Total Current Potential VS. Pfizer (Tablet/Million)"),
                   br(),
                   div(plotlyOutput("total_current_potential_share", height = "300px"),
                       style = "font-size:90%; overflow-x:scroll;")
                 )
               ),
               
               fluidRow(
                 box(
                   title = "City Hospitals Potential and Share by City", 
                   status = "primary",
                   solidHeader = TRUE,
                   collapsible = FALSE,
                   width = 12,
                   
                   br(),
                   h5("1, City Hospitals Current Potential and Share by City (Tablet/Million)"),
                   br(),
                   div(DT::dataTableOutput("city_hospitals_current_potential_share_by_city"),
                       style = "font-size:90%; overflow-x:scroll;"),
                   
                   br(), br(),
                   h5("2, City Hospitals Current Potential VS. Pfizer (Tablet/Million)"),
                   br(),
                   div(plotlyOutput("city_hospitals_current_potential_share", height = "300px"),
                       style = "font-size:90%; overflow-x:scroll;")
                 )
               ),
               
               fluidRow(
                 box(
                   title = "County Hospitals Current Potential and Share by City", 
                   status = "primary",
                   solidHeader = TRUE,
                   collapsible = FALSE,
                   width = 12,
                   
                   br(),
                   h5("1, County Hospitals Current Potential and Share by City (Tablet/Million)"),
                   br(),
                   div(DT::dataTableOutput("County_hospitals_current_potential_share_by_city"),
                       style = "font-size:90%; overflow-x:scroll;"),
                   
                   br(), br(),
                   h5("2, County Hospitals Current Potential VS. Pfizer (Tablet/Million)"),
                   br(),
                   div(plotlyOutput("county_hospitals_current_potential_share", height = "300px"),
                       style = "font-size:90%; overflow-x:scroll;")
                 )
               ),
               
               fluidRow(
                 box(
                   title = "Current Potential Growth by City", 
                   status = "primary",
                   solidHeader = TRUE,
                   collapsible = FALSE,
                   width = 12,
                   
                   br(),
                   h5("1, Current Potential Growth Between City Hospitals and County Hospitals by City (Tablet/Million)"),
                   br(),
                   div(DT::dataTableOutput("growth_current_potential_by_city"),
                       style = "font-size:90%; overflow-x:scroll;"),
                   
                   br(), br(),
                   h5("2, Current Potential Growth Between City Hospitals and County Hospitals by City (Tablet/Million)"),
                   br(),
                   div(plotlyOutput("growth_current_potential_by_city_chart", height = "300px"),
                       style = "font-size:90%; overflow-x:scroll;")
                 )
               )
      ),
      
      tabPanel(strong("Segmentation Statistics"), value=2,
               
               br(),
               fluidRow(
                 box(title = "Quadrant Table",
                     status = "primary",
                     solidHeader = TRUE,
                     collapsible = FALSE,
                     width = 12,
                     
                     column(12,
                            column(10,
                                   align = "center",
                                   div(
                                     column(12,
                                            align = "center",
                                            div(numericInput("potential_div", label = "2020 Market Potential(%)",
                                                             value = 95, min = 0, max = 100, width = "160px"),
                                                style = "display:inline-block;")),
                                     box(
                                       title = "Opportunistic",
                                       status = "primary",
                                       solidHeader = TRUE,
                                       collapsible = FALSE,
                                       width = 6,
                                       style = "background:#DAEEF3; height:270px;",
                                       div(DT::dataTableOutput("opportunistic"))
                                     ),
                                     # column(6,
                                     #        div(DT::dataTableOutput("oppotunity"),
                                     #            style = "font-size:90%; height:250px;")),
                                     box(
                                       title = "Defend",
                                       status = "primary",
                                       solidHeader = TRUE,
                                       collapsible = FALSE,
                                       width = 6,
                                       style = "background:#EBF1DE; height:270px;",
                                       div(DT::dataTableOutput("defend"))
                                     ),
                                     # column(6,
                                     #        div(DT::dataTableOutput("defend"),
                                     #            style = "font-size:90%; height:250px;")),
                                     box(
                                       title = "Expand",
                                       status = "primary",
                                       solidHeader = TRUE,
                                       collapsible = FALSE,
                                       width = 6,
                                       style = "background:#EBF1DE; height:270px;",
                                       div(DT::dataTableOutput("expand"))
                                     ),
                                     # column(6,
                                     #        div(DT::dataTableOutput("expend"),
                                     #            style = "font-size:90%; height:250px;")),
                                     box(
                                       title = "Compete",
                                       status = "primary",
                                       solidHeader = TRUE,
                                       collapsible = FALSE,
                                       width = 6,
                                       style = "background:#DAEEF3; height:270px;",
                                       div(DT::dataTableOutput("compete"))
                                     ),
                                     # column(6,
                                     #        div(DT::dataTableOutput("top"),
                                     #            style = "font-size:90%; height:250px;")),
                                     # column(12,
                                     #        align = "center",
                                     #        div(actionButton("refresh", label = "Refresh", width = "200px"),
                                     #            style = "display:inline-block;")),
                                     style = "height:400px;"
                                   )),
                            column(2,
                                   align = "center",
                                   div(numericInput("share_div", label = "Share(TTH/Molecule, %)", value = 50, min = 0, max = 100, width = "155px"),
                                       style = "text-align:center; margin-top:350px; display:inline-block; height:400px; font-size:90%;"))),
                     column(12,
                            align = "left",
                            div(plotlyOutput("scatter", height = "700px", width = "95%")))
                 )
               ),
               
               fluidRow(
                 box(
                   title = "Details of Potential and Share",
                   status = "primary",
                   solidHeader = TRUE,
                   collapsible = FALSE,
                   width = 12,
                   div(DT::dataTableOutput("detail"),
                       style = "overflow-x:scroll;")
                 )
               )
      ),
      id = "tabselected"
    )
  )
  
)
