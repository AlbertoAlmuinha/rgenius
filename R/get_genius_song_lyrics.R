#' @title Get Song Lyrics
#' @name get_genius_song_lyrics
#' @description This function gets the lyrics of the desired song.
#' @author Alberto Almuiña
#' @param song_id Genius Song ID
#' @param output 'tibble' or 'text'. Default: tibble.
#' @param access_token Genius Web API token. Defaults to Sys.getenv('GENIUS_API_TOKEN').
#' @param url If for some reason the function cannot find the url to download the letter, you can use a genius url to download it.
#' @return
#' Returns a tibble or a character vector with the lyrics
#' @details To use this function, you need to first use 'search_genius_song' to get the song ID.
#' @export
#' @examples
#' \dontrun{
#' get_genius_song_lyrics('55882', output = 'text')
#' }


get_genius_song_lyrics<-function(song_id, output = 'tibble', url = NULL,
                                 access_token = Sys.getenv('GENIUS_API_TOKEN')){

  output<-match.arg(output, c('tibble', 'text'))

  if(is.null(url)){

    url<-get_genius_song(song_id = song_id, access_token = access_token) %>% .$url

  } else {url<-url}

  lyrics<-read_html(url) %>% html_nodes('p') %>% html_text()

  removing<-purrr::partial(str_replace_all, pattern = '\\[.*?\\]', replacement = '')

  removing2<-purrr::partial(str_replace_all, pattern = '\n', replacement = ' ')

  if(output == 'text'){

    lyrics<-lyrics[1] %>% removing() %>% removing2()

  } else{

    lyrics<- str_split(lyrics, pattern = '\n')[[1]] %>%
      enframe(name = NULL, value = 'Lyrics') %>%
      apply(., 2, removing) %>% as_tibble() %>% filter(Lyrics != '')

  }

  return(lyrics)

}
