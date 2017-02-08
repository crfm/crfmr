read_high_seas_data <- function(wb, sheets, year, verbose = FALSE) {
  
  for(i in 1:length(sheets)) {
    # set up column names
    cn1 <- c("month", "day", "lat", "lon", "temp", "hooks")
    species <- c("YFT", "SKJ", "ALB", "BET", "SWO", "WAH", "SPF", "SAI", "Mahi Mahi", "YU KUM")
    details <- c("Wt.T", "weight", "number", "n.measured", "length")
    cn2 <- paste(rep(species, each = 5), details, sep = "_")
    cn3 <- c("Other_Wt.T", "Other_weight", "Ohter_n", "Other_misc",
             "Sharks_Wt.T", "Sharks_weight", "Sharks_n")
    cn4 <- c("bait_Squid", "bait_Sardine", "bait_Mackerel", "bait_Sanma")
    cn <- c(cn1, cn2, cn3, cn4)
    
    d <- readWorksheet(object = wb,
                       sheet = sheets[i],
                       startRow = 16,
                       endRow = 46,
                       startCol = 1,
                       endCol = 67,
                       autofitCol = FALSE,
                       header = FALSE,
                       colTypes = "character")
    names(d) <- cn
    
    
    d <- 
      d %>% 
      filter(!is.na(month), !is.na(day)) %>% 
      unite(date, month, day, sep = "-") %>% 
      mutate(date = paste(year, date, sep = "-"),
             date = ymd(date))

    # check if catch reported but effort missing
    
    if(verbose) {
      x2 <-
        d %>% mutate(id = 1:n(),
                     hooks = as.numeric(hooks)) %>% 
        select(id, hooks, contains("weight")) %>% 
        gather(species, catch, -c(id, hooks)) %>% 
        mutate(catch = as.numeric(catch)) %>% 
        group_by(id) %>% 
        summarise(effort = max(hooks),
                  catch = sum(catch, na.rm = TRUE)) %>% 
        mutate(check = ifelse(catch > 0 & is.na(effort), 
                              "no effort",
                              "ok")) %>% 
        filter(check == "no effort")
      if(nrow(x2) > 0) warning(paste("no effort where catch is reported",
                                     "in sheet", sheets[i]))
    }
    
    tmp.daily.record <- 
      d %>% 
      select(date:hooks, bait_Squid:bait_Sanma) %>%
      mutate(temp = as.numeric(temp),
             hooks = as.numeric(hooks)) %>% 
      filter(!is.na(hooks)) %>% 
      tbl_df()
    d <-
      d %>% 
      select(date, YFT_Wt.T:Sharks_weight)
    
    wt.t <-
      d %>% 
      select(date, contains("Wt.T")) %>% 
      gather(species, value = "Wt.T", -date) %>%
      mutate(species = str_replace(species, "_Wt.T", ""))
    
    little_helper <- function(d, variable = "weight") {
      txt <- paste0("_", variable)
      d %>% 
        tbl_df() %>% 
        select(date, contains(variable)) %>% 
        gather(key = species, value = value, -date) %>%
        mutate(species = str_replace(species, txt, ""))
    }
    wt.t <- little_helper(d, "Wt.T") %>% rename(Wt.T = value)
    weight <- little_helper(d, "weight") %>% rename(weight = value)
    number <- little_helper(d, "number") %>% rename(n = value)
    n.measured <- little_helper(d, "n.measured") %>% rename(n.measured = value)
    Lenghts <- little_helper(d, "length") %>% rename(length = value)
    misc <- little_helper(d, "misc") %>% rename(misc = value)
    
    tmp.catch <-
      wt.t %>% 
      left_join(weight, by = c("date", "species")) %>% 
      left_join(number, by = c("date", "species")) %>% 
      left_join(n.measured, by = c("date", "species")) %>% 
      left_join(Lenghts, by = c("date", "species")) %>% 
      left_join(misc, by = c("date", "species")) %>% 
      mutate(weight = as.numeric(weight),
             n = as.numeric(n),
             n.measured = as.numeric(n.measured),
             sheet = sheets[i]) %>% 
      tbl_df()
    
    if(i == 1) {
      daily.record <- tmp.daily.record
      catch <- tmp.catch
    } else {
      daily.record <- bind_rows(daily.record, tmp.daily.record)
      catch <- rbind(catch, tmp.catch)
    }
  }
  
  res <- list(daily.record = daily.record, catch = catch)
  return(res)
  
}

read_high_seas_metadata <- function(wb, sheets) {
  
  for(i in 1:length(sheets)) {
    
    d <- 
      readWorksheet(object = wb,
                    sheet = sheets[i],
                    startRow = 4,
                    endRow = 9,
                    autofitRow = FALSE,
                    startCol = 1,
                    endCol = 37,
                    autofitCol = FALSE,
                    header = FALSE,
                    colTypes = "character")
    
    x1 <- 
      d %>% 
      select(Col1, Col8, Col21, Col33) %>% 
      gather()
    x2 <- 
      d %>% 
      select(Col4, Col14, Col30, Col37) %>% 
      gather()
    meta <-
      data_frame(variable = x1$value,
                 value = x2$value)
    meta$variable[6] <- "ADDRESS 2"
    meta <-
      meta %>%
      drop_na(variable)
    
    if(i == 1) {
      res <- d
    } else {
      res <- bind_rows(res, d)
    }
  }
  
  return(meta)
}
