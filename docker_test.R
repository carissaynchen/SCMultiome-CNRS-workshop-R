# Running tests
root_folder = "/home/gittmp/"
setwd(root_folder)
# (all_rmd = list.files(path = root_folder, pattern = "*Rmd",
#                       full.names = TRUE))

message("Begin internal test")
start = Sys.time()
# (all_rmd = paste0(root_folder, c("qc.Rmd", "scMerge.Rmd", "downstream.Rmd")))
# rmarkdown::render(all_rmd[1])
# gc()
# rmarkdown::render(all_rmd[2])
# gc()
# rmarkdown::render(all_rmd[3])
# gc()
rmarkdown::render_site(encoding = 'UTF-8')
end = Sys.time()

message("The test completed in ", round(end - start, 2), " secs! You are good to go!")