package com.ekappzone.ringhub

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity()

MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "custom.ringtone/set").setMethodCallHandler {
    call, result ->
    if (call.method == "setTone") {
        val path = call.argument<String>("path")
        val type = call.argument<String>("type")
        val file = File(path!!)
        if (file.exists() && type != null) {
            setAudioTone(file, type)
            result.success("Tone set")
        } else {
            result.error("INVALID", "Missing file or type", null)
        }
    }
}

private fun setAudioTone(file: File, type: String) {
    val values = ContentValues().apply {
        put(MediaStore.MediaColumns.DATA, file.absolutePath)
        put(MediaStore.MediaColumns.TITLE, file.name)
        put(MediaStore.MediaColumns.MIME_TYPE, "audio/mp3")
        when (type) {
            "ringtone" -> put(MediaStore.Audio.Media.IS_RINGTONE, true)
            "notification" -> put(MediaStore.Audio.Media.IS_NOTIFICATION, true)
            "alarm" -> put(MediaStore.Audio.Media.IS_ALARM, true)
        }
    }

    val uri = MediaStore.Audio.Media.getContentUriForPath(file.absolutePath)
    val newUri = contentResolver.insert(uri!!, values)

    val typeInt = when (type) {
        "ringtone" -> RingtoneManager.TYPE_RINGTONE
        "notification" -> RingtoneManager.TYPE_NOTIFICATION
        "alarm" -> RingtoneManager.TYPE_ALARM
        else -> RingtoneManager.TYPE_RINGTONE
    }

    RingtoneManager.setActualDefaultRingtoneUri(this, typeInt, newUri)
}
