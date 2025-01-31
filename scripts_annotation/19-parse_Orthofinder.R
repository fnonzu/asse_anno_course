library(tidyverse)
library(data.table)

# Paths to input data
stats_path <- "/data/users/mvolosko/asse_anno_course/annotations/output/quality/genespace/genespace/orthofinder/Results_Nov18/Comparative_Genomics_Statistics/Statistics_PerSpecies.tsv"
orthogroups_path <- "/data/users/mvolosko/asse_anno_course/annotations/output/quality/genespace/genespace/orthofinder/Results_Nov18/Orthogroups/Orthogroups.GeneCount.tsv"
plots_dir <- "Plots"

# Create output directory for plots if it doesn't exist
if (!dir.exists(plots_dir)) dir.create(plots_dir, recursive = TRUE)

# Load and process data
dat <- fread(stats_path, header = TRUE, fill = TRUE)
genomes <- names(dat)[names(dat) != "V1"]

dat <- dat %>%
  pivot_longer(cols = -V1, names_to = "species", values_to = "perc")

# Filter and process ratios and percentages
ortho_ratio <- dat %>%
  filter(V1 %in% c(
    "Number of genes", "Number of genes in orthogroups", "Number of unassigned genes",
    "Number of orthogroups containing species", "Number of species-specific orthogroups", "Number of genes in species-specific orthogroups"
  ))

ortho_percent <- dat %>%
  filter(V1 %in% c(
    "Percentage of genes in orthogroups", "Percentage of unassigned genes", "Percentage of orthogroups containing species",
    "Percentage of genes in species-specific orthogroups"
  ))

# Convert 'perc' column to numeric
ortho_ratio$perc <- as.numeric(as.character(ortho_ratio$perc))
ortho_percent$perc <- as.numeric(as.character(ortho_percent$perc))

# Generate and save ratio plot
p <- ggplot(ortho_ratio, aes(x = V1, y = perc, fill = species)) +
  geom_col(position = "dodge") +
  cowplot::theme_cowplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(y = "Count") +
  scale_y_continuous(
    breaks = seq(0, max(ortho_ratio$perc, na.rm = TRUE), by = 5000),
    minor_breaks = seq(0, max(ortho_ratio$perc, na.rm = TRUE), by = 1000)
  ) +
  theme(
    panel.grid.major.y = element_line(color = "grey90"),
    panel.grid.minor.y = element_line(color = "grey95", linetype = "dashed")
  )
ggsave(file.path(plots_dir, "orthogroup_plot.pdf"))

# Generate and save percentage plot
p <- ggplot(ortho_percent, aes(x = V1, y = perc, fill = species)) +
  geom_col(position = "dodge") +
  ylim(c(0, 100)) +
  cowplot::theme_cowplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(y = "Percentage")
ggsave(file.path(plots_dir, "orthogroup_percent_plot.pdf"))

# Load and process orthogroups data
orthogroups <- fread(orthogroups_path, header = TRUE)
orthogroups <- orthogroups %>%
  select(-Total)

rownames(orthogroups) <- orthogroups$Orthogroup
ogroups_presence_absence <- orthogroups
ogroups_presence_absence[ogroups_presence_absence > 0] <- 1
ogroups_presence_absence$Orthogroup <- rownames(ogroups_presence_absence)

# Summarize presence/absence
ogroups_presence_absence <- ogroups_presence_absence %>%
  rowwise() %>%
  mutate(SUM = sum(c_across(!ends_with("Orthogroup"))))

ogroups_presence_absence <- data.frame(ogroups_presence_absence)
ogroups_presence_absence[genomes] <- ogroups_presence_absence[genomes] == 1

# Install ComplexUpset locally if not available
local_lib <- "~/Rlibs"
if (!dir.exists(local_lib)) dir.create(local_lib, recursive = TRUE)
if (!requireNamespace("ComplexUpset", quietly = TRUE)) {
  install.packages("ComplexUpset", lib = local_lib, repos = "http://cran.us.r-project.org")
}
library(ComplexUpset, lib.loc = local_lib)

# Generate and save upset plot
pdf(file.path(plots_dir, "one-to-one_orthogroups_plot.complexupset.pdf"), height = 5, width = 10, useDingbats = FALSE)
upset(ogroups_presence_absence, genomes, name = "genre", width_ratio = 0.1, wrap = TRUE, set_sizes = FALSE)
dev.off()
