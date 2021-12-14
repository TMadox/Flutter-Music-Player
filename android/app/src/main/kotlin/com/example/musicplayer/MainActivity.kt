package com.example.musicplayer
import android.content.*
import android.media.AudioAttributes
import android.media.MediaMetadataRetriever
import android.media.MediaPlayer
import android.net.Uri
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "RetrieveSongs"
    override fun configureFlutterEngine (@NonNull flutterEngine: FlutterEngine)
    {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
            call, result ->
            if(call.method=="getSongs")
            {
                var argumentsongpath = call.argument<List<String>>("songpathlist")
                var test = argumentsongpath?.let { getSongs(it) }
                result.success(test)
            }

        }
        
    }
    private fun playSongs (songpath: String): String
        {
            val myUri: Uri = Uri.parse(songpath) // initialize Uri here
            val mediaPlayer = MediaPlayer().apply {
                setAudioAttributes(
                        AudioAttributes.Builder()
                                .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                                .setUsage(AudioAttributes.USAGE_MEDIA)
                                .build()
                )
                setDataSource(applicationContext, myUri)
                prepare()
                start()
            }
            return "test word";
        }

    private fun getSongs(songpathlist: List<String>): List<String> {
        val mapper = jacksonObjectMapper()
        val mmr = MediaMetadataRetriever()
        var songlist = mutableListOf<String>()
        for(i in songpathlist)
        {
            mmr.setDataSource(i)
            val songname = mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_TITLE)
            val albumname = mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ALBUM)
            val artistname = mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ARTIST)
//            val albumartist = mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_ALBUMARTIST)
//            val tracknumber = mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_CD_TRACK_NUMBER)
//            val year = mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_YEAR)
//            val genre = mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_GENRE)
//          val authorname ="mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_AUTHOR)"
//            val writername = mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_WRITER)
//            val discnumber = mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_DISC_NUMBER)
//            val mimetype = mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_MIMETYPE)
//            val trackduration = mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_DURATION)
//            val bitrate = mmr.extractMetadata(MediaMetadataRetriever.METADATA_KEY_BITRATE)
////            val albumart = mmr.embeddedPicture
//            val songpath = i
            val song =  SongInfo(songName = songname!!, artistName = artistname!!, albumName = albumname!!
                    )
            val userJson = mapper.writeValueAsString(song)
            songlist.add(userJson)
        }
        return songlist;
    }
}
