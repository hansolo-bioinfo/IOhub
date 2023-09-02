function(input, output, session) {

    output$study_choice <- renderUI(
        {
            if ("All" %in% input$catype_dropdown) {
                catype_meta <- meta
            } else {
                catype_meta <- meta[
                    meta$Type_Shiny %in% input$catype_dropdown, ]
        }
         
            selectInput(
                inputId = "study_dropdown",
                label = "Study",
                choices = c("All", 
                             sort(unique(catype_meta$Study_Shiny))
                ),
                width = "400px",
                multiple = TRUE
            )
        }
    )
    
    observeEvent(input$catype_dropdown, {
        
        Selected <- input$catype_dropdown
        
        if(length(Selected) > 1 & "All" %in% Selected) {
            Selected <- "All"
        }
        
        updateSelectInput(session = session,
                          inputId = "catype_dropdown",
                          selected = Selected)
        
    }, ignoreNULL = TRUE)
    
    observeEvent(input$study_dropdown, {
        
        Selected <- input$study_dropdown
        
        if(length(Selected) > 1 & "All" %in% Selected) {
            Selected <- "All"
        }
        
        updateSelectInput(session = session,
                          inputId = "study_dropdown",
                          selected = Selected)
        
    }, ignoreNULL = TRUE)
    
    observeEvent(input$timepoint_dropdown, {
        
        Selected <- input$timepoint_dropdown
        
        if(length(Selected) > 1 & "All" %in% Selected) {
            Selected <- "All"
        }
        
        updateSelectInput(session = session,
                          inputId = "timepoint_dropdown",
                          selected = Selected)
        
    }, ignoreNULL = TRUE)
    
    observeEvent(input$response_dropdown, {
        
        Selected <- input$response_dropdown
        
        if(length(Selected) > 1 & "All" %in% Selected) {
            Selected <- "All"
        }
        
        updateSelectInput(session = session,
                          inputId = "response_dropdown",
                          selected = Selected)
        
    }, ignoreNULL = TRUE)
    
    output$db_lst <- renderTable(db)
    
    observeEvent(input$inquire_button, {
        if ("All" %in% input$catype_dropdown) {
            this_meta <- meta
        } else {
            this_meta <- meta[meta$Type_Shiny %in% input$catype_dropdown, ]
        }
        if ("All" %in% input$study_dropdown) {
            this_meta <- this_meta
        } else {
            this_meta <- this_meta[this_meta$Study_Shiny %in% input$study_dropdown, ]
        }
        if ("All" %in% input$response_dropdown) {
            this_meta <- this_meta
        } else {
            this_meta <- this_meta[this_meta$Response %in% input$response_dropdown, ]
        }
        if ("All" %in% input$timepoint_dropdown) {
            this_meta <- this_meta
        } else {
            this_meta <- this_meta[this_meta$Time %in% input$timepoint_dropdown, ]
        }
        
        output$request_tbl <- renderTable(this_meta)
        output$download_data <- downloadHandler(
            filename = function() {
                paste0("data-", Sys.Date(), ".tsv")
            },
            content = function(file) {
                write.table(this_meta, file, sep = "\t", quote = FALSE)
            }
        )
    })
}