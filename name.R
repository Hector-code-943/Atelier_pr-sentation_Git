# 11/06/2026
# Mellina Sidous et Hector Seiler 

# Importer les paquets utiles
library(sf)
library(tidyverse)
library(mapview)

# Importer les données
# consommation d'alcool au sein de chaque région
consommation <- read.csv("data/alcool-consommation-quotidienne-region.csv")  %>% 
  dplyr::select("Année", "Région", "Sexe", "Taux.standardisé")  %>% 
  pivot_wider(names_from= "Sexe", values_from="Taux.standardisé") 
# limites de chaque région
regions<-st_read("data/regions-20180101.shp") %>% 
  rename(Région = nom) %>% 
  dplyr::select(-c(nuts2, wikipedia, code_insee)) %>%
  left_join( consommation, by="Région")

# Afficher les régions françaises
mapview(regions, legend = FALSE,alpha.regions = 0.3, aplha = 1.4, col.regions = "grey") 

# colorer les régions françaises selon la consommation d'alcool 
mapview(regions, zcol = "Hommes", alpha.regions = 0.3, legend = TRUE)
mapview(regions, zcol = "Femmes", alpha.regions = 0.3, legend = TRUE)

# Les femmes et les hommes sont-ils alcoliques dans les mêmes régions?