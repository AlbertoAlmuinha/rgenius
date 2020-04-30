#' @title Search Artist
#' @name search_genius_artist
#' @description This function searches 'genius' artists by name
#' @author Alberto Almuiña
#' @param artist_name String of artist name
#' @param access_token Genius Web API token. Defaults to Sys.getenv('GENIUS_API_TOKEN').
#' @return
#' Returns a data frame with the artist's information
#' @details All Genius API endpoints require an artist or song ID. The `search_` functions in this package
#' try to search for the desired artists/songs to obtain their Genius ID and to use them later.
#' @export
#' @examples
#' \dontrun{
#' search_genius_artist('Arctic Monkeys')
#' }

search_genius_artist<-function(artist_name, access_token = Sys.getenv('GENIUS_API_TOKEN')){

  res<-RETRY('GET', url = 'https://api.genius.com/search',
             query = list(q=artist_name,
                          per_page = 50,
                          access_token= access_token),
             quiet = TRUE) %>% content

  if(res$meta$status != 200){stop(str_glue('Information not found for artist_name: {artist_name}'))}

  info1<-res$response$hits

  result<-purrr::map_df(seq(length(info1)), function(this_artist){

    info<-info1[[this_artist]]$result$primary_artist

    list(

      id = info$id,
      name = info$name,
      url = info$url,
      image_url = info$image_url,
      header_image_url = info$header_image_url,
      is_verified = info$is_verified,
      is_meme_verified = info$is_meme_verified
    )

  }) %>% distinct()

  return(result)

}
