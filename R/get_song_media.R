#' @title Get Song Media
#' @name get_song_media
#' @description This function gets 'genius' media information
#' @author Alberto Almuiña
#' @param song_id Genius Song ID
#' @param access_token Genius Web API token. Defaults to Sys.getenv('GENIUS_API_TOKEN').
#' @return
#' Returns a tibble with the media's information
#' @details To use this function, you need to first use 'search_genius_song' to get the song ID.
#' This function returns the provider (YouTube, Spotify ..), the type (audio, video) and a link for the content.
#' @export
#' @examples
#' \dontrun{
#' get_song_media('55882')
#' }


get_song_media<-function(song_id, access_token = Sys.getenv('GENIUS_API_TOKEN')){

  res<-RETRY('GET', url = str_glue('https://api.genius.com/songs/{song_id}'),
             query = list(access_token = access_token),
             quiet = TRUE) %>% content

  if(res$meta$status != 200){stop(str_glue('Information not found for song_id: {song_id}'))}

  info<-res$response$song$media

  if(length(info)==0){stop(str_glue('No media information found for the song id: {song_id}'))}

  media<-purrr::map_df(seq(length(info)), function(this_media){

    med<-info[[this_media]]

    list(
      song_id = song_id,
      provider = med$provider,
      type = med$type,
      url = med$url
    )

  })

  return(media)

}
