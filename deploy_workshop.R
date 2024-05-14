Sys.setenv(GCE_AUTH_FILE = '/Users/cchen/Dropbox (Sydney Uni)/workshop-CNRS/sunny-might-421907-m4-04c5b2e4865b.json')
library(googleComputeEngineR)

gce_global_project("sunny-might-421907-m4")
gce_global_zone("europe-west1-b")

## see gce_list_machinetype() for options of predefined_type
tag = "gcr.io/sunny-might-421907-m4/scmultiomecnrsr:alpha"

vm1 <- gce_vm(template = "rstudio",
              name = "scmultiomecnrs1",
              disk_size_gb = 100,
              # predefined_type = "n2-standard-32",
              predefined_type = "e2-highcpu-8",
              dynamic_image = tag,
              user = "rstudio",
              password = "test")

# vm2 <- gce_vm(template = "rstudio",
#              name = "scmultiomecnrs2",
#              disk_size_gb = 10,
#              # predefined_type = "n2-standard-32",
#              predefined_type = "e2-micro",
#              dynamic_image = tag,
#              user = "rstudio",
#              password = "test")