#' @title Get Song Relationship
#' @name get_song_relationship
#' @description This function fetches songs related to the wanted one.
#' @author Alberto Almuiña
#' @param song_id Genius Song ID
#' @param access_token Genius Web API token. Defaults to Sys.getenv('GENIUS_API_TOKEN').
#' @return
#' Returns a tibble with related song's information
#' @details To use this function, you need to first use 'search_genius_song' to get the song ID.
#' @export
#' @examples
#' \dontrun{
#' get_song_relationship('55882')
#' }


get_song_relationship<-function(song_id, access_token = Sys.getenv('GENIUS_API_TOKEN')){

  res<-RETRY('GET', url = str_glue('https://api.genius.com/songs/{song_id}'),
             query = list(access_token = access_token),
             quiet = TRUE) %>% content

  if(res$meta$status != 200){stop(str_glue('Information not found for song_id: {song_id}'))}

  info<-res$response$song$song_relationships

  if(length(info)==0){stop(str_glue('No song relationships found for the song id: {song_id}'))}

  relation<-purrr::map_df(seq(length(info)), function(this_rel){

    rel<-info[[this_rel]]

    if(length(rel$songs)==0){

      list(
        type = rel$type,
        id = NA_integer_,
        title = NA_character_,
        url = NA_character_,
        full_title = NA_character_,
        img_url = NA_character_,
        lyrics_state = NA_character_,
        artist_id = NA_integer_,
        artist_name = NA_character_,
        artist_url = NA_character_
      )

    } else{

      purrr::map_df(seq(length(rel$songs)), function(this_song){

        song<-rel$songs[[this_song]]

        list(
          type = rel$type,
          id = song$id,
          title = song$title,
          url = song$url,
          full_title = song$full_title,
          img_url = song$header_image_url,
          lyrics_state = song$lyrics_state,
          artist_id = song$primary_artist$id,
          artist_name = song$primary_artist$name,
          artist_url = song$primary_artist$url
        )

      })

    }
  }) %>% na.omit()

  return(relation)

}
