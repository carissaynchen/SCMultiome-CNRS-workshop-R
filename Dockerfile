FROM bioconductor/bioconductor_docker:RELEASE_3_14

#WORKDIR /home/rstudio

#COPY --chown=rstudio:rstudio . /home/rstudio/

#RUN Rscript -e "options(repos = c(CRAN = 'https://cran.r-project.org')); BiocManager::install(ask=FALSE)"

#RUN Rscript -e "options(repos = c(CRAN = 'https://cran.r-project.org')); devtools::install('.', dependencies=TRUE, build_vignettes=TRUE, repos = BiocManager::repositories())"


## R package installation scripts
ADD install.R /home/ 

## Setup folder structure
ADD docker_setup.sh /home/

## Set up tests for Docker compile, large memory, use config.yaml when building Docker
# ADD docker_test.R /home/

## Set up data and teaching materials
RUN bash /home/docker_setup.sh 

## Install all R packages
RUN R -f /home/install.R

## Running test
# RUN R -f /home/docker_test.R