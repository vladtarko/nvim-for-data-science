# make sure needed packages are installed --------------------------------------
setdiff(
  c("httpgd", "collapse", "reactable", "rio", "ggplot2", "ggtext"),
  installed.packages()[, "Package"]
) |>
  install.packages()

# my terminal -----------------------------------------------------------------

.my_terminal <- "kitty @ launch --type=tab"

# graphics device -------------------------------------------------------------

# (1) fancy option (plots in the browser)
# use the httpgd graphics device - open plots in browser
# options(device = function(...) {
#   httpgd::hgd(silent = TRUE)
#   httpgd::hgd_browse()
# })

# (2) simple option
# set the position and size of the plot window
grDevices::X11.options(xpos = 900, ypos = 100, width = 10, height = 9)


### USEFUL FUNCTIONS ----------------------------------------------------------

.tarko <- new.env()

.tarko$data_summary <- function(df) {
  collapse::descr(
    df,
    table = FALSE,
    Qprobs = FALSE
  ) |>
    as.data.frame() |>
    reactable::reactable(
      searchable = TRUE,
      resizable = TRUE,
      defaultPageSize = 100,
      showPageSizeOptions = TRUE,
      compact = TRUE
    )
}

.tarko$vd_view <- function(df) {
  filename <- paste0(tempdir(), "/temp-df.csv")
  rio::export(df, file = filename)
  system(paste(.my_terminal, "vd", filename))
}

.tarko$vd_summary <- function(df) {
  df_summary <- collapse::descr(
    df,
    table = FALSE,
    Qprobs = FALSE
  ) |>
    as.data.frame()

  filename <- paste0(tempdir(), "/temp-df.csv")
  rio::export(df_summary, file = filename)
  system(paste(.my_terminal, "vd", filename))
}

attach(.tarko)


### ggplot theme -----------------------------------------------------------------

ggplot2::theme_set(ggplot2::theme_light(base_size = 24))

ggplot2::theme_replace(
  text = ggplot2::element_text(family = "Times"),

  # enable markdown in the texts
  axis.title.x = ggtext::element_markdown(
    padding = ggplot2::unit(c(5, 0, 0, 0), "pt"),
    size = 16
  ),
  axis.title.y = ggtext::element_markdown(
    angle = 90,
    padding = ggplot2::unit(c(0, 0, 5, 0), "pt"),
    size = 16
  ),
  axis.text = ggplot2::element_text(size = 16),
  plot.title = ggtext::element_markdown(size = 24),
  plot.subtitle = ggtext::element_markdown(size = 20),

  # align the caption to the left
  plot.caption.position = "plot",
  plot.caption = ggtext::element_markdown(
    hjust = 0,
    padding = ggplot2::unit(c(10, 0, 0, 0), "pt"),
    size = 14
  ),

  # for facetting
  strip.text = ggplot2::element_text(color = "black", size = 20),
  strip.background = ggplot2::element_rect(color = "white"),
  panel.spacing.x = ggplot2::unit(10, "pt"),
  panel.spacing.y = ggplot2::unit(10, "pt")
)
