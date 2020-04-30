#' @title Search Song
#' @name search_genius_song
#' @description This function searches 'genius' songs by name
#' @author Alberto Almuiña
#' @param song_name String of song name
#' @param access_token Genius Web API token. Defaults to Sys.getenv('GENIUS_API_TOKEN').
#' @return
#' Returns a data frame with the song's information
#' @details All Genius API endpoints require an artist or song ID. The `search_` functions in this package
#' try to search for the desired artists/songs to obtain their Genius ID and to use them later.
#' @export
#' @examples
#' \dontrun{
#' search_genius_song('Paradise')
#' }


search_genius_song<-function(song_name, access_token = Sys.getenv('GENIUS_API_TOKEN')){

  res<-RETRY('GET', url = 'https://api.genius.com/search',
             query = list(q=song_name,
                          access_token= access_token),
             quiet = TRUE) %>% content

  if(res$meta$status != 200){stop(str_glue('Information not found for song_name: {song_name}'))}

  info<-res$response$hits

  result<-purrr::map_df(seq(length(info)), function(this_hit){

    info1<-info[[this_hit]]$result

    list(

      id = info1$id,
      name = info1$title,
      url = info1$url,
      full_title = info1$full_title,
      artist_id = info1$primary_artist$id,
      artist = info1$primary_artist$name,
      lyrics_state = info1$lyrics_state,
      lyrics_owner_id = info1$lyrics_owner_id,
      song_art_image_url = info1$song_art_image_url,
      song_art_image_thumbnail_url = info1$song_art_image_thumbnail_url

    )

  })

  return(result)

}
