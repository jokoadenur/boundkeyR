![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)
![CRAN Version](https://img.shields.io/badge/CRAN-7.3.2-brightgreen)
![Open Issues](https://img.shields.io/badge/open%20issues-0-brightgreen)
![License](https://img.shields.io/badge/License-MIT-blue)

![WhatsApp Image 2025-01-24 at 21 44 25](https://github.com/user-attachments/assets/1dd14543-9cea-443f-8913-87a37b412a0d)

# boundkeyR

`boundkeyR` is an R package designed for generating **Boundkey diagrams** to visualize export and import flows between regions. With this package, you can easily create visualizations of trade relationships across various regions using your data.

## Installation

To install the `boundkeyR` package, run the following code in your R script:

```R
# Install package from GitHub
devtools::install_github("jokoadenur/boundkeyR")
```

> **Note:** If prompted to update certain packages (options like 1. All, 2. CRAN, etc.), simply press **ENTER** to skip. Wait until the installation process is complete and the message `DONE (boundkeyR)` appears.

After installation, activate the package with the following code:

```R
# Activate the package
library(boundkeyR)
```

## Usage

To generate a Boundkey diagram, use the boundkey() function with the following format:

```R
boundkey(data, color_palette = NULL, title = "Boundkey Diagram")
```

### Examples:

1. Default data as instance Export-Import Data from jatim.bps.go.id from January-November, 2024:
   ```R
   data <- tibble(type = c("Export", "Export", "Export", "Export", "Import", "Import", "Import", "Import"),
   origin = c("Jatim", "Jatim", "Jatim", "Jatim", "China", "Amerika", "Brazil", "Hongkong"),
   destination = c("Japan", "China", "America", "Malaysia", "Jatim", "Jatim", "Jatim", "Jatim"),
   value = c(3.44, 2.93, 3.08, 1.41, 7.00, 1.39, 1.23, 0.64))

   boundkey(data)
   ```
2. Data with customized colors:
   ```R
   data <- tibble(type = c("Export", "Export", "Export", "Export", "Import", "Import", "Import", "Import"),
   origin = c("Jatim", "Jatim", "Jatim", "Jatim", "China", "Amerika", "Brazil", "Hongkong"),
   destination = c("Japan", "China", "America", "Malaysia", "Jatim", "Jatim", "Jatim", "Jatim"),
   value = c(3.44, 2.93, 3.08, 1.41, 7.00, 1.39, 1.23, 0.64))
   
   custom_colors <- c("Export" = "green", "Import" = "purple", "Jatim" = "orange", "Japan" = "pink", "China" = "yellow", "America" = "cyan", "Malaysia" = "brown", "Brazil" = "blue", "Hongkong" = "red")

   boundkey(data, color_palette = custom_colors)
   ```
3. Customize title manually:
   ```R
   data <- tibble(type = c("Export", "Export", "Export", "Export", "Import", "Import", "Import", "Import"),
   origin = c("Jatim", "Jatim", "Jatim", "Jatim", "China", "Amerika", "Brazil", "Hongkong"),
   destination = c("Japan", "China", "America", "Malaysia", "Jatim", "Jatim", "Jatim", "Jatim"),
   value = c(3.44, 2.93, 3.08, 1.41, 7.00, 1.39, 1.23, 0.64))

   boundkey(data, title = "Export and Import Flows in Southeast Asia")
   ```
### Data Requirements:
  To use the segmonr() function effectively, your data must contain at least two columns:
  
  type: Categorical variable, as instance "Export" and "Import", the type of data: character
  
  origin: The name of origin place
  
  destination: The name of destination place
  
  value: The value representing the flow of data from the origin to the destination, or vice versa
