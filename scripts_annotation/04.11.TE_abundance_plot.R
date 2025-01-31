# Load required libraries
library(ggplot2)
library(dplyr)

# Read data (adjust paths if needed)
copia <- read.delim("/data/users/mvolosko/asse_anno_course/annotations/output/TEsorter/copia_tmp.mutX4LU9f5", skip=1, header=FALSE,
                   col.names=c("TE","Order","Superfamily","Clade","Complete",
                               "Strand","Domains","abundance_count"))
gypsy <- read.delim("/data/users/mvolosko/asse_anno_course/annotations/output/TEsorter/gypsy_tmp.6AztfsBCbh", skip=1, header=FALSE,
                   col.names=c("TE","Order","Superfamily","Clade","Complete",
                               "Strand","Domains","abundance_count"))

# Combine datasets
combined <- bind_rows(copia, gypsy)

# Aggregate abundance by Superfamily and Clade
summary_df <- combined %>%
  group_by(Superfamily, Clade) %>%
  summarise(total_abundance = sum(abundance_count), .groups = "drop")

# Generate visualization
ggplot(summary_df, aes(x = Clade, y = total_abundance, fill = Superfamily)) +
  geom_col(position = position_dodge(width = 0.8)) +
  labs(title = "TE Abundance by Clade and Superfamily",
       y = "Total Abundance", x = "Clade") +
  scale_fill_manual(values = c("Copia" = "#E69F00", "Gypsy" = "#56B4E9")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "top")

# Save plot
ggsave("TE_abundance.png", width = 12, height = 8, dpi = 300)
