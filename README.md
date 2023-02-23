# Data story

## Overview

1. Source data was obtained via [Encuesta Nacional de Población Privada de la Libertad (ENPOL) 2021](https://www.inegi.org.mx/programas/enpol/2021/#Microdatos), or the National Survey of Population Deprived of Liberty on 2/23/23 and is in folder `original`.

2. In its original state, the data came as two spreadsheets `ENPOL2021_2_3` and `ENPOL2021_SOC`, where one record in each represents a survey response from an incarcerated person. There are state codes for the following variables, which JB would like to use to create choropleth or flow maps:
  - P1_5: state of birth
  - P2_1: where they lived a week before detention
  - P3_6: state where they committed the crime

3. To do so, we geocoded each response to the state centroid and then counted the number of occurrences within each state, for each variable. The result are two datasets:
  - in `geocoded` folder, find the tables with each survey response containing lat/lon for each variable of interest (generalized to state centroid)
  - in `state-counts` folder, find totals of each variable of interest counted within the geometry of each state


## Steps

There are 61,450 survey responses. We used a combination of OpenRefine, R, and QGIS for data cleaning and geographic analysis functions. 

1. First, we inputted the Mexico admin 1 names for the geocoder using OpenRefine `Facet → Text Facet → Edit`. Find these cleaned up files in folder `cleaned`. 

2. Then we ran this new spreadsheet through an R Script to geocode. Find the script in `scripts/geocode.R`. Note we must specify the country Mexico for it to find state centroids. Find the new datasets with state centroid lat/lons for each variable of interest in folder titled `geocoded`. 

3. We imported the geocoded tables into QGIS via `Add Layer → Add delimited text layer` specifying the lat/lon for one of the three variables.

4. We ran the tool `Vector → Analysis Tools → Count Points in Polygon`. This creates a new polygon layer of each state with a column counting the *number* of each instance of the variable occurring within each polygon. We repeated steps 3 and 4 for each variable of interest, exporting the new state count polygon files into the folder `state_counts`. 

You can use the `geojson` polygon layers in `state_counts` to visualize the data. Note the occurrences have not been normalized to population or any other factor. 


# Documentation to do list
- Add clarification about 97, 98, 99 coded fields
- Update based on any additional cleaning for migration flow mapping

