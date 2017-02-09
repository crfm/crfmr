read_metadata <- function(wb, sheet) {
  
  res <- list()
  
  for(i in 1:length(sheet)) {
    res[[i]] <-
      readWorksheet(wb, sheet = sheet[i],
                    region = "A4:A6",
                    header = FALSE) %>% 
      separate(Col1, c("variable", "value"), sep = ": ") %>% 
      spread(variable, value)
  }
  meta <- bind_rows(res)
  return(meta)
}

read_catch <- function(wb, sheet) {
  
  res <- list()
  sheets <- getSheets(wb)
  
  for (i in 1:length(sheet)) {
    
    d <- readWorksheet(wb, sheet[i],
                       startRow = 9) %>% 
      tbl_df()
    
    ag <-
      d %>% 
      filter(!is.na(id)) %>% 
      select(id, starts_with("AG")) %>% 
      gather(key = trip, value = ag, -id) %>% 
      separate(trip, c("category", "trip"), convert = TRUE) %>% 
      select(-category) %>% 
      mutate(trip = ifelse(is.na(trip), 0, trip),
             trip = trip + 1,
             ag = as.numeric(ag))
    lg <-
      d %>% 
      filter(!is.na(id)) %>% 
      select(id, starts_with("LG")) %>% 
      gather(key = trip, value = lg, -id) %>% 
      separate(trip, c("category", "trip"), convert = TRUE) %>% 
      select(-category) %>% 
      mutate(trip = ifelse(is.na(trip), 0, trip),
             trip = trip + 1,
             lg = as.numeric(lg))
    res[[i]] <-
      ag %>% 
      left_join(lg, by = c("trip", "id")) %>% 
      filter(!is.na(ag)) %>%  
      mutate(vessel = sheet[i])
  }
  
  catch <- bind_rows(res)
  
  return(catch)
}