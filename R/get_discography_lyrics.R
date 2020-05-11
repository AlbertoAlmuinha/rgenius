#' @title Get Discography Lyrics
#' @name get_discography_lyrics
#' @description This function gets the lyrics of the desired song.
#' @author Alberto Almuiña
#' @param artist_id Genius Artist ID
#' @param cores Number of cores to use for parallel computing. Default: parallel::detectCores()
#' @param access_token Genius Web API token. Defaults to Sys.getenv('GENIUS_API_TOKEN').
#' @return
#' Returns a named list containing all the lyrics of the artist's songs.
#' @details To use this function, you need to first use 'search_genius_artist' to get the artist ID.
#' This function uses parallel processing to increase performance. Use the different cores of your device to achieve this,
#' so there may be noticeable differences in performance depending on the device.
#' @export
#' @examples
#' \dontrun{
#' get_discography_lyrics('343657', cores = 2)
#' }


get_discography_lyrics<-function(artist_id, cores = detectCores(), access_token = Sys.getenv('GENIUS_API_TOKEN')){

  discography<-get_genius_artist_songs(artist_id = artist_id) %>% .[,c("id", "title", "lyrics_state")] %>%
    filter(lyrics_state == "complete")

  cl<-makeCluster(cores)

  registerDoParallel(cl)

  clusterExport(cl,list('get_genius_song_lyrics', 'get_genius_song'))

  lyrics<-foreach(index = seq(dim(discography)[1]),
                  .packages = c('dplyr', 'httr', 'stringr', 'purrr', 'rvest'),
                  .inorder = FALSE) %dopar%

    get_genius_song_lyrics(discography$id[index], output = 'text', access_token = access_token)


  names(lyrics)<-discography$title

  stopImplicitCluster()

  return(lyrics)
}
