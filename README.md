
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rgenius <img src='man/figures/logo.png' align="right" height="139" />

<!-- badges: start -->

[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
<!-- badges: end -->

> The purpose of this package is to provide an efficient method of
> downloading song lyrics using the ‘genius’ API.

## Installation

You can install the development version of `rgenius` from
[Github](https://github.com/AlbertoAlmuinha/rgenius) with:

``` r
remotes::install_github('AlbertoAlmuinha/rgenius')
```

## Autenthication

To use the package it is necessary to obtain the ‘Genius’ API access
token. You can get one by visiting the following
[link.](https://genius.com/signup_or_login) All the functions in this
package require the `access_token` argument. You can pass it to each
call manually, but our advice is to store it as an environment variable:

``` r
Sys.setenv(GENIUS_API_TOKEN = 'GENIUS_TOKEN')
```

## Usage

### Search Functions

The functions in this package require either the Artist ID or the Song
ID. For this reason, the first step will be to obtain these ID’s. We
achieve this with the `search_genius_artist` and`search_genius_song`
functions.

``` r
library(rgenius)

search_genius_artist(artist_name = 'Arctic Monkeys') %>% kable()
```

<table>

<thead>

<tr>

<th style="text-align:right;">

id

</th>

<th style="text-align:left;">

name

</th>

<th style="text-align:left;">

url

</th>

<th style="text-align:left;">

image\_url

</th>

<th style="text-align:left;">

header\_image\_url

</th>

<th style="text-align:left;">

is\_verified

</th>

<th style="text-align:left;">

is\_meme\_verified

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

12297

</td>

<td style="text-align:left;">

Arctic Monkeys

</td>

<td style="text-align:left;">

<https://genius.com/artists/Arctic-monkeys>

</td>

<td style="text-align:left;">

<https://images.genius.com/12c27f4fbb06ef32dc1c1e432098f447.570x570x1.jpg>

</td>

<td style="text-align:left;">

<https://images.genius.com/b81ac6b3d864301390ef3d44f8095245.1000x563x1.jpg>

</td>

<td style="text-align:left;">

FALSE

</td>

<td style="text-align:left;">

FALSE

</td>

</tr>

</tbody>

</table>

<br> You can also get the ID of a song as follows:

``` r
search_genius_song(song_name = 'Paradise') %>% tail(3) %>% kable()
```

<table>

<thead>

<tr>

<th style="text-align:right;">

id

</th>

<th style="text-align:left;">

name

</th>

<th style="text-align:left;">

url

</th>

<th style="text-align:left;">

full\_title

</th>

<th style="text-align:right;">

artist\_id

</th>

<th style="text-align:left;">

artist

</th>

<th style="text-align:left;">

lyrics\_state

</th>

<th style="text-align:right;">

lyrics\_owner\_id

</th>

<th style="text-align:left;">

song\_art\_image\_url

</th>

<th style="text-align:left;">

song\_art\_image\_thumbnail\_url

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

2343635

</td>

<td style="text-align:left;">

Paradise

</td>

<td style="text-align:left;">

<https://genius.com/Logic-paradise-lyrics>

</td>

<td style="text-align:left;">

Paradise by Logic (Ft. Jesse Boykins III)

</td>

<td style="text-align:right;">

7922

</td>

<td style="text-align:left;">

Logic

</td>

<td style="text-align:left;">

complete

</td>

<td style="text-align:right;">

172030

</td>

<td style="text-align:left;">

<https://images.genius.com/b9b6844bdd8ebfbe10235ad54d885cfa.960x960x1.jpg>

</td>

<td style="text-align:left;">

<https://images.genius.com/b9b6844bdd8ebfbe10235ad54d885cfa.300x300x1.jpg>

</td>

</tr>

<tr>

<td style="text-align:right;">

55882

</td>

<td style="text-align:left;">

Paradise

</td>

<td style="text-align:left;">

<https://genius.com/Coldplay-paradise-lyrics>

</td>

<td style="text-align:left;">

Paradise by Coldplay

</td>

<td style="text-align:right;">

8351

</td>

<td style="text-align:left;">

Coldplay

</td>

<td style="text-align:left;">

complete

</td>

<td style="text-align:right;">

30046

</td>

<td style="text-align:left;">

<https://images.genius.com/8d4d307d9a6c211d1192c44a2cf6598d.1000x1000x1.png>

</td>

<td style="text-align:left;">

<https://images.genius.com/8d4d307d9a6c211d1192c44a2cf6598d.300x300x1.png>

</td>

</tr>

<tr>

<td style="text-align:right;">

2843318

</td>

<td style="text-align:left;">

The Other Side of Paradise

</td>

<td style="text-align:left;">

<https://genius.com/Glass-animals-the-other-side-of-paradise-lyrics>

</td>

<td style="text-align:left;">

The Other Side of Paradise by Glass Animals

</td>

<td style="text-align:right;">

87048

</td>

<td style="text-align:left;">

Glass Animals

</td>

<td style="text-align:left;">

complete

</td>

<td style="text-align:right;">

3642337

</td>

<td style="text-align:left;">

<https://images.genius.com/f94989a22d577632d4f7b2aa084301f9.996x1000x1.jpg>

</td>

<td style="text-align:left;">

<https://images.genius.com/f94989a22d577632d4f7b2aa084301f9.300x301x1.jpg>

</td>

</tr>

</tbody>

</table>

<br>

### Songs Information

#### Media

Information from digital media where a song appears can be obtained from
the `get_song_media()` function. For example, let’s see what we get for
Coldplay’s song ‘Paradise’ whose ID we got earlier:

``` r
get_song_media(song_id = '55882') %>% kable()
```

<table>

<thead>

<tr>

<th style="text-align:left;">

song\_id

</th>

<th style="text-align:left;">

provider

</th>

<th style="text-align:left;">

type

</th>

<th style="text-align:left;">

url

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

55882

</td>

<td style="text-align:left;">

youtube

</td>

<td style="text-align:left;">

video

</td>

<td style="text-align:left;">

<http://www.youtube.com/watch?v=1G4isv_Fylg>

</td>

</tr>

<tr>

<td style="text-align:left;">

55882

</td>

<td style="text-align:left;">

spotify

</td>

<td style="text-align:left;">

audio

</td>

<td style="text-align:left;">

<https://open.spotify.com/track/6nek1Nin9q48AVZcWs9e9D>

</td>

</tr>

<tr>

<td style="text-align:left;">

55882

</td>

<td style="text-align:left;">

soundcloud

</td>

<td style="text-align:left;">

audio

</td>

<td style="text-align:left;">

<https://soundcloud.com/coldplay/paradise?in=coldplay/sets/mylo-xyloto-4>

</td>

</tr>

</tbody>

</table>

Among the information obtained, we find the media that host this song
and a direct link.

<br>

#### Producers

Information from the song’s music producers can be obtained as follows:

``` r
get_song_producer_artist(song_id = '55882') %>% kable()
```

<table>

<thead>

<tr>

<th style="text-align:left;">

song\_id

</th>

<th style="text-align:right;">

producer\_id

</th>

<th style="text-align:left;">

producer\_name

</th>

<th style="text-align:left;">

producer\_url

</th>

<th style="text-align:left;">

producer\_img\_url

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

55882

</td>

<td style="text-align:right;">

29971

</td>

<td style="text-align:left;">

Markus Dravs

</td>

<td style="text-align:left;">

<https://genius.com/artists/Markus-dravs>

</td>

<td style="text-align:left;">

<https://images.genius.com/7f6916eae6a76333e02b239b4145617d.468x468x1.jpg>

</td>

</tr>

<tr>

<td style="text-align:left;">

55882

</td>

<td style="text-align:right;">

112992

</td>

<td style="text-align:left;">

Daniel Green

</td>

<td style="text-align:left;">

<https://genius.com/artists/Daniel-green>

</td>

<td style="text-align:left;">

<https://images.genius.com/fc80827d2d46226d42e9787575e4a4d0.300x350x1.jpg>

</td>

</tr>

<tr>

<td style="text-align:left;">

55882

</td>

<td style="text-align:right;">

29974

</td>

<td style="text-align:left;">

Rik Simpson

</td>

<td style="text-align:left;">

<https://genius.com/artists/Rik-simpson>

</td>

<td style="text-align:left;">

<https://images.genius.com/f6f7d70a2f2220f087b4af8482939714.1000x665x1.jpg>

</td>

</tr>

<tr>

<td style="text-align:left;">

55882

</td>

<td style="text-align:right;">

29972

</td>

<td style="text-align:left;">

Brian Eno

</td>

<td style="text-align:left;">

<https://genius.com/artists/Brian-eno>

</td>

<td style="text-align:left;">

<https://images.genius.com/79c8742c09e5dafa22e970d3c3d15696.751x751x1.jpg>

</td>

</tr>

</tbody>

</table>

<br>

#### Related Songs

You can also search for songs related to the original:

``` r
get_song_relationship(song_id = '55882') %>% head(5) %>% kable()
```

<table>

<thead>

<tr>

<th style="text-align:left;">

type

</th>

<th style="text-align:right;">

id

</th>

<th style="text-align:left;">

title

</th>

<th style="text-align:left;">

url

</th>

<th style="text-align:left;">

full\_title

</th>

<th style="text-align:left;">

img\_url

</th>

<th style="text-align:left;">

lyrics\_state

</th>

<th style="text-align:right;">

artist\_id

</th>

<th style="text-align:left;">

artist\_name

</th>

<th style="text-align:left;">

artist\_url

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

sampled\_in

</td>

<td style="text-align:right;">

2441408

</td>

<td style="text-align:left;">

Wagner is a Cold Player

</td>

<td style="text-align:left;">

<https://genius.com/Wagner-r-b-superstar-wagner-is-a-cold-player-lyrics>

</td>

<td style="text-align:left;">

Wagner is a Cold Player by Wagner: R\&B Superstar

</td>

<td style="text-align:left;">

<https://images.rapgenius.com/d7db994397f67adfa15f0c30418b345e.1000x1000x1.jpg>

</td>

<td style="text-align:left;">

complete

</td>

<td style="text-align:right;">

650686

</td>

<td style="text-align:left;">

Wagner: R\&B Superstar

</td>

<td style="text-align:left;">

<https://genius.com/artists/Wagner-r-b-superstar>

</td>

</tr>

<tr>

<td style="text-align:left;">

covered\_by

</td>

<td style="text-align:right;">

516475

</td>

<td style="text-align:left;">

Paradise

</td>

<td style="text-align:left;">

<https://genius.com/Craig-owens-paradise-lyrics>

</td>

<td style="text-align:left;">

Paradise by Craig Owens

</td>

<td style="text-align:left;">

<https://images.rapgenius.com/e985569b4bed1dc6d0bf5533d04d92bf.300x300x1.jpg>

</td>

<td style="text-align:left;">

complete

</td>

<td style="text-align:right;">

24658

</td>

<td style="text-align:left;">

Craig Owens

</td>

<td style="text-align:left;">

<https://genius.com/artists/Craig-owens>

</td>

</tr>

<tr>

<td style="text-align:left;">

remixed\_by

</td>

<td style="text-align:right;">

423218

</td>

<td style="text-align:left;">

New World

</td>

<td style="text-align:left;">

<https://genius.com/Netnobody-new-world-lyrics>

</td>

<td style="text-align:left;">

New World by NetNobody

</td>

<td style="text-align:left;">

<https://images.genius.com/a156b5d9b3f8386b56e6121bbdb1bb0a.170x170x1.jpg>

</td>

<td style="text-align:left;">

complete

</td>

<td style="text-align:right;">

1167521

</td>

<td style="text-align:left;">

NetNobody

</td>

<td style="text-align:left;">

<https://genius.com/artists/Netnobody>

</td>

</tr>

<tr>

<td style="text-align:left;">

remixed\_by

</td>

<td style="text-align:right;">

1818754

</td>

<td style="text-align:left;">

Paradise (Tiësto Remix)

</td>

<td style="text-align:left;">

<https://genius.com/Coldplay-paradise-tiesto-remix-lyrics>

</td>

<td style="text-align:left;">

Paradise (Tiësto Remix) by Coldplay (Ft. Tiësto)

</td>

<td style="text-align:left;">

<https://images.genius.com/671466e8ef3ac5bcd80d26ae8de21102.600x600x1.jpg>

</td>

<td style="text-align:left;">

complete

</td>

<td style="text-align:right;">

8351

</td>

<td style="text-align:left;">

Coldplay

</td>

<td style="text-align:left;">

<https://genius.com/artists/Coldplay>

</td>

</tr>

<tr>

<td style="text-align:left;">

remixed\_by

</td>

<td style="text-align:right;">

2336572

</td>

<td style="text-align:left;">

Death of Me (Paradise Remix)

</td>

<td style="text-align:left;">

<https://genius.com/Andy-mineo-death-of-me-paradise-remix-lyrics>

</td>

<td style="text-align:left;">

Death of Me (Paradise Remix) by Andy Mineo (Ft. Coldplay)

</td>

<td style="text-align:left;">

<https://images.genius.com/dd1e9062aa638e674b941f9530aa9af6.500x500x1.jpg>

</td>

<td style="text-align:left;">

complete

</td>

<td style="text-align:right;">

14035

</td>

<td style="text-align:left;">

Andy Mineo

</td>

<td style="text-align:left;">

<https://genius.com/artists/Andy-mineo>

</td>

</tr>

</tbody>

</table>

<br>

### Lyrics

Song lyrics can be obtained from the `get_genius_song_lyrics()`
function. Lyrics can be returned either in table format (tibble) or in
text format (character vector).

``` r
get_genius_song_lyrics(song_id = '154314', output = 'tibble') %>% head(5) %>% kable()
```

<table>

<thead>

<tr>

<th style="text-align:left;">

Lyrics

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Have you got colour in your cheeks?Do you ever get that fear that you
can’t shift the type

</td>

</tr>

<tr>

<td style="text-align:left;">

That sticks around like summat in your teeth?Are there some aces up your
sleeve?

</td>

</tr>

<tr>

<td style="text-align:left;">

Have you no idea that you’re in deep?I’ve dreamt about you nearly every
night this week

</td>

</tr>

<tr>

<td style="text-align:left;">

How many secrets can you keep?’Cause there’s this tune I found

</td>

</tr>

<tr>

<td style="text-align:left;">

That makes me think of you somehow an’ I play it on repeatUntil I fall
asleep, spillin’ drinks on my settee

</td>

</tr>

</tbody>

</table>

<br>

``` r
get_genius_song_lyrics(song_id = '154314', output = 'text') %>% kable()
```

<table>

<thead>

<tr>

<th style="text-align:left;">

x

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Have you got colour in your cheeks?Do you ever get that fear that you
can’t shift the type That sticks around like summat in your teeth?Are
there some aces up your sleeve? Have you no idea that you’re in
deep?I’ve dreamt about you nearly every night this week How many
secrets can you keep?‘Cause there’s this tune I found That makes me
think of you somehow an’ I play it on repeatUntil I fall asleep,
spillin’ drinks on my settee (Do I wanna know?) If this feelin’ flows
both ways? (Sad to see you go) Was sorta hopin’ that you’d stay(Baby, we
both know) That the nights were mainly made For sayin’ things that you
can’t say tomorrow day Crawlin’ back to you Ever thought of callin’ when
You’ve had a few? ‘Cause I always doMaybe I’m too Busy bein’ yours To
fall for somebody new Now, I’ve thought it through Crawlin’ back to you
So have you got the guts?Been wonderin’ if your heart’s still open And
if so, I wanna know what time it shutsSimmer down an’ pucker up, I’m
sorry to interrupt It’s just I’m constantly on the cusp of tryin’ to
kiss youI don’t know if you feel the same as I do But we could be
together if you wanted to (Do I wanna know?) If this feelin’ flows both
ways? (Sad to see you go) Was sorta hopin’ that you’d stay(Baby, we both
know) That the nights were mainly made For sayin’ things that you can’t
say tomorrow day Crawlin’ back to you (Crawlin’ back to you) Ever
thought of callin’ when You’ve had a few? (Had a few) ‘Cause I always do
(’Cause I always do)Maybe I’m too (Maybe I’m too busy) Busy bein’ yours
(Bein’ yours) To fall for somebody new Now, I’ve thought it through
Crawlin’ back to you (Do I wanna know?) If this feelin’ flows both ways?
(Sad to see you go) Was sorta hopin’ that you’d stay(Baby, we both know)
That the nights were mainly made For sayin’ things that you can’t say
tomorrow day(Do I wanna know?) Too busy bein’ yours to fall(Sad to see
you go) Ever thought of callin’, darlin’?(Do I wanna know?) Do you want
me crawlin’ back to you?

</td>

</tr>

</tbody>

</table>

<br>

#### Lyrics Discography

You can download the lyrics of an entire discography with the
`get_discography_lyrics()` function. This function uses parallel
processing based on `foreach` package to increase performance. Use the
different cores of your device to achieve this, so there may be
noticeable differences in performance depending on the device.

``` r
lyrics<-get_discography_lyrics(artist_id = '343657') #Leiva

names(lyrics)
#>  [1] "92"                                        
#>  [2] "Afuera en la ciudad"                       
#>  [3] "A Ti Te Ocurre Algo"                       
#>  [4] "Aunque sea un rato"                        
#>  [5] "Breaking Bad"                              
#>  [6] "Cerca"                                     
#>  [7] "Ciencia ficción"                           
#>  [8] "Como Si Fueras a Morir Mañana"             
#>  [9] "Costa de Oaxaca"                           
#> [10] "Dejándose Caer"                            
#> [11] "Del hueso una flor"                        
#> [12] "El Caso de la Rubia Platino"               
#> [13] "Electricidad"                              
#> [14] "El Gigante Big Fish"                       
#> [15] "El Último Incendio"                        
#> [16] "Eme"                                       
#> [17] "En el Espacio"                             
#> [18] "Expertos"                                  
#> [19] "Extasis"                                   
#> [20] "Francesita"                                
#> [21] "Godzilla (feat. Bunbury & Ximena Sariñana)"
#> [22] "Guerra Mundial"                            
#> [23] "Hermosa taquicardia"                       
#> [24] "Hoy no me encuentro"                       
#> [25] "Hoy Tus Ojos"                              
#> [26] "La Llamada"                                
#> [27] "La Lluvia en los Zapatos"                  
#> [28] "Las cuentas"                               
#> [29] "Lobos"                                     
#> [30] "Los cantantes"                             
#> [31] "Maniobras Suicidas"                        
#> [32] "Medicina"                                  
#> [33] "Miedo"                                     
#> [34] "Mi mejor versión"                          
#> [35] "Mi Pequeño Chernóbil"                      
#> [36] "Mirada perdida"                            
#> [37] "Monstruos"                                 
#> [38] "No Te Preocupes por Mí"                    
#> [39] "Nuclear"                                   
#> [40] "Nunca nadie"                               
#> [41] "Palermo No Es Hollywood"                   
#> [42] "Palomas"                                   
#> [43] "Penaltis"                                  
#> [44] "Polvora"                                   
#> [45] "Que nunca mueran los cantantes"            
#> [46] "San Sebastian - Madrid"                    
#> [47] "Sincericidio"                              
#> [48] "Sixteen"                                   
#> [49] "Superpoderes"                              
#> [50] "Telediario"                                
#> [51] "Terriblemente Cruel"                       
#> [52] "Todo Lo Que Tu Quieras"                    
#> [53] "Vertigo"                                   
#> [54] "Vis a vis"
```

``` r
lyrics$`San Sebastian - Madrid` %>% kable()
```

<table>

<thead>

<tr>

<th style="text-align:left;">

x

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Letra de “San Sebastian - Madrid” Atravesando las nubes Tu decidiendo
por mi A ver si no me destruye Lo que quería decir Tu ibas cogiendo las
olas Yo andaba loco por ti Cuando giraron las cosas San Sebastián-Madrid
Vuelve a mi Vuele despacio y lento Hacia aquí A veces saco los dientes A
veces quiero dejarte ir A veces vamos de frente A veces vuelvo a confíar
en ti A veces no me convences Y el miedo a pensarlo Vuelve a alejarme de
ti Yo me tumbaba en las vías Tu conseguías dormir Por una vez en la vida
Me recordaste a mí Tu ibas abriendo las alas Yo me intentaba rendir Otro
verano se acaba San Sebastián-Madrid Vuelve a mi Vuele despacio y lento
Hacia aquí A veces saco los dientes A veces quiero dejarte ir A veces
vamos de frente A veces vuelvo a confíar en ti A veces no me comprendes
Y el miedo a pensarlo Vuelve a alejarme de ti (pa, pa pa pa, papa, pa) A
veces saco los dientes A veces quiero dejarte ir A veces vamos de frente
A veces vuelvo a confiar en mi A veces no me convences Y el miedo a
pensarlo Vuelve a alejarme de ti

</td>

</tr>

</tbody>

</table>

<br>

### Getting Help

If you encounter a bug, please file an issue with a minimal reproducible
example on [Issues](https://github.com/AlbertoAlmuinha/rgenius/issues).
You can also make an inquiry if you wish.
