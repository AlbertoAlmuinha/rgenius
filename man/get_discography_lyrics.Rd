% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_discography_lyrics.R
\name{get_discography_lyrics}
\alias{get_discography_lyrics}
\title{Get Discography Lyrics}
\usage{
get_discography_lyrics(artist_id, cores = detectCores(),
  access_token = Sys.getenv("GENIUS_API_TOKEN"))
}
\arguments{
\item{artist_id}{Genius Artist ID}

\item{cores}{Number of cores to use for parallel computing. Default: parallel::detectCores()}

\item{access_token}{Genius Web API token. Defaults to Sys.getenv('GENIUS_API_TOKEN').}
}
\value{
Returns a named list containing all the lyrics of the artist's songs.
}
\description{
This function gets the lyrics of the desired song.
}
\details{
To use this function, you need to first use 'search_genius_artist' to get the artist ID.
This function uses parallel processing to increase performance. Use the different cores of your device to achieve this,
so there may be noticeable differences in performance depending on the device.
}
\examples{
\dontrun{
get_discography_lyrics('343657', cores = 2)
}
}
\author{
Alberto Almuiña
}
