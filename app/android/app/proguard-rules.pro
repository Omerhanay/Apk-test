# ML Kit's text-recognition plugin references every script's recognizer, but
# LIFE OS only bundles the Latin one (it covers Turkish). The others are
# optional dependencies and are never loaded.
-dontwarn com.google.mlkit.vision.text.chinese.**
-dontwarn com.google.mlkit.vision.text.devanagari.**
-dontwarn com.google.mlkit.vision.text.japanese.**
-dontwarn com.google.mlkit.vision.text.korean.**
