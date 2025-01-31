library(ggplot2)
library(dplyr)
library(purrr)

# Function to process TE files for an accession
process_accession <- function(accession_name, copia_path, gypsy_path) {
  copia <- read.delim(copia_path, skip=1, header=FALSE,
                     col.names=c("TE","Order","Superfamily","Clade","Complete",
                                 "Strand","Domains","abundance_count"))
  gypsy <- read.delim(gypsy_path, skip=1, header=FALSE,
                     col.names=c("TE","Order","Superfamily","Clade","Complete",
                                 "Strand","Domains","abundance_count"))
  bind_rows(copia, gypsy) %>% 
    mutate(Accession = accession_name)
}

# Get list of accessions to compare (excluding Leo)
accession_files <- list.files("/data/users/amaalouf/transcriptome_assembly/annotation/output/TE_sorter/compare/",
                             pattern = "(copia|gypsy)_(Kar1|Lu_1)\\.tsv$")

# Create accession list
accessions <- unique(gsub("(copia|gypsy)_([A-Za-z0-9]+)\\.tsv", "\\2", accession_files))

# Process all accessions
all_data <- map_dfr(accessions, function(acc) {
  process_accession(
    accession_name = acc,
    copia_path = paste0("/data/users/amaalouf/transcriptome_assembly/annotation/output/TE_sorter/compare/copia_", acc, ".tsv"),
    gypsy_path = paste0("/data/users/amaalouf/transcriptome_assembly/annotation/output/TE_sorter/compare/gypsy_", acc, ".tsv")
  )
}) %>% 
  # Add Sah-0 data
  bind_rows(
    process_accession(
      "Sah-0",
      "/data/users/mvolosko/asse_anno_course/annotations/output/TEsorter/copia_tmp.mutX4LU9f5",
      "/data/users/mvolosko/asse_anno_course/annotations/output/TEsorter/gypsy_tmp.6AztfsBCbh"
    )
  )

# Aggregate data
summary_df <- all_data %>%
  group_by(Accession, Superfamily, Clade) %>%
  summarise(total_abundance = sum(abundance_count), .groups = "drop")

# Generate comparative visualization
ggplot(summary_df, aes(x = Clade, y = total_abundance, fill = Superfamily)) +
  geom_col(position = position_dodge(width = 0.8)) +
  facet_wrap(~ Accession, scales = "free_y", ncol = 1) +
  labs(title = "Comparative TE Abundance Across Accessions",
       y = "Total Abundance", x = "Clade") +
  scale_fill_manual(values = c("Copia" = "#E69F00", "Gypsy" = "#56B4E9")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "top",
        strip.text = element_text(size = 10, face = "bold"))

# Save plot
ggsave("TE_comparison.png", width = 14, height = 10, dpi = 300)
