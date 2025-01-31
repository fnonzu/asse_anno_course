library(GENESPACE)

# 1st parameter:
# gsParam: A list of genespace parameters. This should be created by setup_genespace, but can be 
#           built manually. Must have the following elements: 
#           blast (file.path to the original orthofinder run), 
#           synteny ( file.path to the directory where syntenic results are stored), 
#           genomeIDs ( character vector of genomeIDs).
# needed variables for that:
# the genespace parameter object is returned or can be loaded into R
out <- load('/Users/lovell/Desktop/gs_v1_runs/test4riptut/run/results/gsParams.rda', verbose = TRUE)
