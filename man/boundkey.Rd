\name{boundkey}
\alias{boundkey}
\title{Generate Boundkey Diagram}
\description{
  This function generates a Boundkey diagram to visualize export and import flows between regions.
}
\usage{
boundkey(data, color_palette = NULL, title = "Boundkey Diagram")
}
\arguments{
  \item{data}{A data frame containing columns: type, origin, destination, and value.}
  \item{color_palette}{An optional named vector of colors for the regions and types. Defaults to pre-defined colors.}
  \item{title}{An optional string specifying the title of the diagram.}
}
\details{
  The function visualizes the flows between regions using arcs, where the type of flow (Export or Import) determines the direction of the arcs.
  The arc thickness is proportional to the `value` column, representing the flow magnitude.
  The color palette for the diagram can be customized or will default to "Export" as purple, "Import" as red, and regions as white.
}

\examples{
  # Example data frame
  data <- data.frame(
    type = c("Export", "Import", "Export", "Import"),
    origin = c("Region A", "Region B", "Region C", "Region A"),
    destination = c("Region B", "Region A", "Region A", "Region C"),
    value = c(10, 5, 20, 15)
  )

  # Generate Boundkey Diagram
  boundkey(data)
}
