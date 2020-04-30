#' @title Get Song
#' @name get_genius_song
#' @description This function gets 'genius' song information
#' @author Alberto Almuiña
#' @param song_id Genius Song ID
#' @param access_token Genius Web API token. Defaults to Sys.getenv('GENIUS_API_TOKEN').
#' @return
#' Returns a data frame with the song's information
#' @details To use this function, you need to first use 'search_genius_song' to get the song ID.
#' @export
#' @examples
#' \dontrun{
#' get_genius_song('3440889')
#' }



get_genius_song<-function(song_id, access_token = Sys.getenv('GENIUS_API_TOKEN')){

  res<-RETRY('GET', url = str_glue('https://api.genius.com/songs/{song_id}'),
             query = list(access_token = access_token),
             quiet = TRUE) %>% content

  if(res$meta$status != 200){stop(str_glue('Information not found for song_id: {song_id}'))}

  info<-res$response$song

  song<-purrr::map_df(1, function(x){

    list(
      id = info$id,
      title = info$title,
      url = info$url,
      full_title = info$full_title,
      apple_player = info$apple_music_player_url,
      lyrics_state = info$lyrics_state,
      release_date = if_else(length(info$release_date) == 0, NA_character_, info$release_date),
      artist_id = info$primary_artist$id,
      artist_name = info$primary_artist$name,
      artist_url = info$primary_artist$url,
      artist_img = info$primary_artist$image_url,
      embed_content = info$embed_content
    )

  })

  return(song)

}
