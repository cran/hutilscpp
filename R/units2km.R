
units2km <- function(string) {
  stopifnot(is.character(string),
            length(string) == 1L)
  # put km before m!
  if (endsWith(string, "km")) {
    dist_km <- sub("\\s*km$", "", string)
    # use as.double here and as.numeric later to separate warning msgs
    dist_km <- as.double(dist_km)
  } else if (endsWith(string, "m")) {
    dist_km <- sub("\\s*m$", "", string)
    dist_km <- as.numeric(dist_km) / 1000
  }
  stopifnot(!anyNA(dist_km), is.numeric(dist_km))
  dist_km
}

