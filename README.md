# Club Wampus Android
## Documentacón

## Compilación del Blunde (aab)
Para crear un archivo aab firmado de tu proyecto Cordova, debes seguir estos pasos:

1. Abre una terminal y navega hasta el directorio de tu proyecto Cordova.
2. Ejecuta el siguiente comando para generar el archivo aab sin firmar:

```
cordova build android --release --aab
```

Este comando generará un archivo `.aab` sin firmar en el directorio `platforms/android/build/outputs/bundle/release`.

3. Luego, debes firmar el archivo aab con los archivos `private_key.pepk` y `wampus.jks`. Para ello, ejecuta el siguiente comando:


jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore wampus.jks -storepass <password> -signedjar app-release-signed.aab app-release.aab <alias>


Donde:

* `app-release-signed.aab` es el nombre del archivo aab firmado que deseas crear.
* `app-release.aab` es el nombre del archivo aab sin firmar que generaste en el paso 2.
* `<password>` es la contraseña de la clavestore `wampus.jks`.
* `<alias>` es el alias de la clavestore `wampus.jks`.

Por ejemplo, si la contraseña de la clavestore es `my-password` y el alias de la clavestore es `my-alias`, puedes usar el siguiente comando para firmar el archivo aab:


jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore wampus.jks -storepass my-password -signedjar app-release-signed.aab app-release.aab my-alias


Una vez que hayas firmado el archivo aab, puedes subirlo a la Google Play Store o a cualquier otro mercado de aplicaciones.

En tu caso, los comandos que debes ejecutar son los siguientes:


cordova build android --release --aab
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore wampus.jks -storepass <password> -signedjar app-release-signed.aab app-release.aab <alias>

Donde:

* `<password>` = '21071972' es la contraseña del archivo `private_key.pepk`.
* `<alias>` ='clubwampus' es el alias del archivo `wampus.jks`.

Por ejemplo, si la contraseña del archivo `private_key.pepk` es `my-password` y el alias del archivo `wampus.jks` es `my-alias`, puedes usar los siguientes comandos:

> jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore wampus.jks -storepass 21071972 -signedjar app-release-signed.aab app-release.aab clubwampus

Estos comandos generarán un archivo `app-release-signed.aab` firmado en el directorio `platforms/android/build/outputs/bundle/release`.
