#' @title Get Artist Songs
#' @name get_genius_artist_songs
#' @description This function gets all the songs of the artist in genius.
#' @author Alberto Almuiña
#' @param artist_id Genius Artist ID
#' @param access_token Genius Web API token. Defaults to Sys.getenv('GENIUS_API_TOKEN').
#' @return
#' Returns a data frame with the artist's songs information
#' @details To use this function, you need to first use 'search_genius_artist' to get the artist ID.
#' @export
#' @examples
#' \dontrun{
#' get_genius_artist_songs('343657')
#' }


get_genius_artist_songs<-function(artist_id, access_token = Sys.getenv('GENIUS_API_TOKEN')){

  page<-1

  info<-list()

  while(page>0){

    res<-RETRY('GET', url = str_glue('https://api.genius.com/artists/{artist_id}/songs'),
               query = list(per_page = 50,
                            page = page,
                            access_token = access_token),
               quiet = TRUE) %>% content

    if(res$meta$status != 200){stop(str_glue('Information not found for artist_id: {artist_id}'))}

    songs<-purrr::map_df(seq(length(res$response$songs)), function(this_song){

      info<-res$response$songs[[this_song]]
      artist<-info$primary_artist

      list(
        id = info$id,
        title = info$title,
        url = info$url,
        full_title = info$full_title,
        lyrics_state = info$lyrics_state,
        annotation_count = info$annotation_count,
        artist_id = artist$id,
        artist_name = artist$name,
        artist_url = artist$url,
        artist_image_url = artist$image_url
      )

    })

    info[[page]]<-songs

    if(!is.null(res$response$next_page)){
      page<-res$response$next_page
    } else{
      break()
    }

  }

  max_art<-purrr::compose(names, which.max, table)

  info<-purrr::map_df(info, bind_rows) %>% filter(artist_name == max_art(artist_name))

  return(info)

}
