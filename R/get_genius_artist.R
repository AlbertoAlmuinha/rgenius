#' @title Get Artist
#' @name get_genius_artist
#' @description This function gets 'genius' artist information
#' @author Alberto Almuiña
#' @param artist_id Genius Artist ID
#' @param access_token Genius Web API token. Defaults to Sys.getenv('GENIUS_API_TOKEN').
#' @return
#' Returns a data frame with the artist's information
#' @details To use this function, you need to first use 'search_genius_artist' to get the artist ID.
#' @export
#' @examples
#' \dontrun{
#' get_genius_artist('343657')
#' }


get_genius_artist<-function(artist_id, access_token = Sys.getenv('GENIUS_API_TOKEN')){

  res<-RETRY('GET', url = str_glue('https://api.genius.com/artists/{artist_id}'),
             query = list(per_page = 1,
                          page = 1,
                          access_token = access_token),
             quiet = TRUE) %>% content

  if(res$meta$status != 200){stop(str_glue('Information not found for artist_id: {artist_id}'))}

  info<-res$response$artist

  result<-purrr::map_df(1, function(...){

    list(

      id = info$id,
      name = info$name,
      url = info$url,
      image_url = info$image_url,
      header_image_url = info$header_image_url,
      followers_count = info$followers_count,
      is_meme_verified = info$is_meme_verified,
      is_verified = info$is_verified
    )

  })

  return(result)

}
