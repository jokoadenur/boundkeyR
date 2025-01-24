#' Generate Boundkey Diagram
#'
#' This function generates a Boundkey diagram to visualize export and import flows between regions.
#'
#' @param data A data frame containing columns: type, origin, destination, and value.
#' @param color_palette An optional named vector of colors for the regions and types. Defaults to pre-defined colors.
#' @param title An optional string specifying the title of the diagram.
#' @import dplyr
#' @import ggplot2
#' @import tidyverse
#' @import ggforce
#'
#' @return A ggplot object representing the Boundkey diagram.
#' @export

globalVariables(c("%>%", "origin", "destination", "region",
                  "position", "origin_pos", "destination_pos",
                  "type", "x", "y", "value"))

boundkey <- function(data, color_palette = NULL, title = "Boundkey Diagram") {
  # Validate input
  if (!all(c("type", "origin", "destination", "value") %in% colnames(data))) {
    stop("The data must contain the following columns: type, origin, destination, and value.")
  }

  # Check if "value" is numeric
  if (!is.numeric(data$value)) {
    stop("The 'value' column must be numeric.")
  }

  # Set default color palette if none is provided
  if (is.null(color_palette)) {
    color_palette <- c(
      "Export" = "purple",
      "Import" = "red",
      "DefaultRegion" = "white"
    )
  }

  # Generate node positions
  nodes <- data %>%
    dplyr::select(origin, destination) %>%
    tidyr::pivot_longer(cols = dplyr::everything(), names_to = "role", values_to = "region") %>%
    dplyr::distinct(region) %>%
    dplyr::mutate(position = dplyr::row_number())

  # Join node positions with the main data
  data <- data %>%
    dplyr::left_join(nodes, by = c("origin" = "region")) %>%
    dplyr::rename(origin_pos = position) %>%
    dplyr::left_join(nodes, by = c("destination" = "region")) %>%
    dplyr::rename(destination_pos = position)

  # Generate arc data
  arc_data <- data %>%
    dplyr::rowwise() %>%
    dplyr::mutate(
      x = list(c(origin_pos, (origin_pos + destination_pos) / 2, destination_pos)),
      y = if (type == "Export") list(c(0, 0.5, 0)) else list(c(0, -0.5, 0))
    ) %>%
    tidyr::unnest(cols = c(x, y))

  # Create the plot
  plot <- ggplot2::ggplot() +
    # Export arcs
    ggforce::geom_bspline(
      ggplot2::aes(
        x = x, y = y, group = interaction(origin, destination), size = value, color = type
      ),
      data = dplyr::filter(arc_data, type == "Export"),
      inherit.aes = FALSE
    ) +
    # Import arcs
    ggforce::geom_bspline(
      ggplot2::aes(
        x = x, y = y, group = interaction(origin, destination), size = value, color = type
      ),
      data = dplyr::filter(arc_data, type == "Import"),
      inherit.aes = FALSE
    ) +
    # Nodes (regions)
    ggplot2::geom_point(
      data = nodes,
      ggplot2::aes(x = position, y = 0, color = region),
      size = 3,
      show.legend = FALSE
    ) +
    ggplot2::geom_text(
      data = nodes,
      ggplot2::aes(x = position, y = 0, label = region),
      vjust = 1
    ) +
    # Set colors
    ggplot2::scale_color_manual(values = color_palette) +
    # Adjust arc thickness
    ggplot2::scale_size(range = c(1, 4), guide = "none") +
    ggplot2::theme_minimal() +
    ggplot2::labs(
      title = title,
      x = NULL, y = NULL,
      color = NULL
    ) +
    ggplot2::theme(
      axis.text = ggplot2::element_blank(),
      axis.ticks = ggplot2::element_blank(),
      panel.grid = ggplot2::element_blank(),
      legend.position = "bottom"
    )

  return(plot)
}
