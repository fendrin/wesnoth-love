love = love

log = (require"log")"music"

add_to_playlist = (file) ->

    log.info"adding #{file} to playlist"
    source = love.audio.newSource( file, 'stream' )
    love.audio.play( source )
    volume = love.audio.getVolume!
    log.info"The master volume is: #{volume}"

update = (dt) ->
    love.audio.setVol


{
    :add_to_playlist
    :update
}
