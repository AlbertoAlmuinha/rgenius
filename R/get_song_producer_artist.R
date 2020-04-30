#' @title Get Song Producer
#' @name get_song_producer_artist
#' @description This function gets song producer information
#' @author Alberto Almuiña
#' @param song_id Genius Song ID
#' @param access_token Genius Web API token. Defaults to Sys.getenv('GENIUS_API_TOKEN').
#' @return
#' Returns a tibble with the producer's information
#' @details To use this function, you need to first use 'search_genius_song' to get the song ID.
#' This function returns the producer name and links to their genius profiles and images.
#' @export
#' @examples
#' \dontrun{
#' get_song_producer_artist('55882')
#' }


get_song_producer_artist<-function(song_id, access_token = Sys.getenv('GENIUS_API_TOKEN')){

  res<-RETRY('GET', url = str_glue('https://api.genius.com/songs/{song_id}'),
             query = list(access_token = access_token),
             quiet = TRUE) %>% content

  if(res$meta$status != 200){stop(str_glue('Information not found for song_id: {song_id}'))}

  info<-res$response$song$producer_artists

  if(length(info)==0){stop(str_glue('No producer artists found for the song id: {song_id}'))}

  producer<-purrr::map_df(seq(length(info)), function(this_producer){

    prod<-info[[this_producer]]

    list(
      song_id = song_id,
      producer_id = prod$id,
      producer_name = prod$name,
      producer_url = prod$url,
      producer_img_url = prod$image_url
    )

  })

  return(producer)

}
