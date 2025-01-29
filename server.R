library(plumber)
pr("screen_controller.R") %>%
    pr_run(port = 8000)
