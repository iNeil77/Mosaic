#' Tile Co-Incidence Matrix
#'
#' Input a dataset with at least two categorical variables and the Geom 
#' results in coincidence square only if a certain pair of values of the two 
#' variables co-occur.
#' 
#' The GeomTile class has been extended in the following code. The class accepts 
#' x and y centering values (as center coordinates of the rectangle), aling with 
#' width and height aesthetics (as dimensions of each rectangle).
#'
#'
#' @param mapping Set of aesthetic mappings created
#'  by aes or aes_. If specified and inherit.aes = TRUE
#'  (the default), is combined with the default mapping at
#'  the top level of the plot. You only need to supply
#'  mapping if there isn't a mapping defined for the plot.
#'
#' @param data  data frame. If specified, overrides the default
#'  data frame defined at the top level of the plot.
#'
#' @param stat The statistical transformation to use on
#'  the data for this layer, as a string.
#'
#' @param position Position adjustment, either as a string,
#'  or the result of a call to a position adjustment function.
#'
#' @param na.rm f FALSE (the default), removes missing values
#'  with a warning. If TRUE silently removes missing values.
#'
#' @param show.legend logical. Should this layer be included in
#'  the legends? NA, the default, includes if any aesthetics are
#'  mapped. FALSE never includes, and TRUE always includes.
#'
#' @param inherit.aes If FALSE, overrides the default aesthetics,
#'  rather than combining with them. This is most useful for helper
#'  functions that define both data and aesthetics and shouldn't inherit
#'  behaviour from the default plot specification
#'
#'
#'
#' @author Indraneil Paul, \email{indraneil.paul@@research.iiit.ac.in}
#'
#' @examples
#' ggplot(mpg, aes(mpg$manufacturer, mpg$class, mpg$hwy)) + 
#' geom_bloc(aes(height=1,weight=1))
#'
#'
#' @export


StatCategory <- ggproto("StatCategory", Stat,
                        compute_group = function(data, scales) {
                          Ace<-aggregate(data,list(Manufacturer=data$x,Class=data$y),FUN = mean)
                          Ace
                        },
                        required_aes = c("x","y")
)

GeomBloc <- ggproto("GeomBloc", GeomTile,
                    default_aes = aes(colour = "black", fill = "black", size = 0.5, linetype = 1,alpha = NA),
                    draw_key = draw_key_rect,
                    draw_group = function(data,panel_scales){
                      grid::rectGrob(default.units = "native",
                                     gp = grid::gpar(
                                       col = attr$colour,
                                       fill = scales::alpha(attr$fill,attr$alpha),
                                       lwd = attr$size,
                                       lty = attr$linetype
                                     ))
                    }
)

geom_bloc <- function(mapping = NULL, data = NULL, position = "identity", na.rm = FALSE, show.legend = NA, inherit.aes = TRUE, ...) {
  layer(
    stat = StatCategory, 
    geom = GeomBloc, 
    data = data, 
    mapping = mapping,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}

#' @export

ggplot(mpg, aes(mpg$manufacturer, mpg$class, mpg$hwy)) + 
  geom_bloc(aes(height=1,weight=1))