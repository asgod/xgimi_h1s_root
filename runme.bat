@echo off
adb devices
set /p tip=input target ip:
adb connect %tip%
adb root
adb kill-server
adb connect %tip%
adb root
adb devices
set msg=type 1 to skip, 3 to go on:
adb shell mount -o remount,rw /system
pause

:adbon
echo turn on adb forever?
set /p typ1=%msg%
if %typ1%==1 goto showim
adb push build.prop /system/
adb shell chmod 0644 /system/build.prop

:showim
echo show the input method selector in settings?
set /p typ2=%msg%
if %typ2%==1 goto rooton
adb push settings_H1S.ini /system/etc/xgimiconfig
adb shell chmod 0644 /system/etc/xgimiconfig/settings_H1S.ini

:rooton
echo want root?
set /p typ3=%msg%
if %typ3%==1 goto purge
echo install Superuser to system.....
adb push supersu /system/app/
adb shell chmod 0644 /system/app/SuperSU/SuperSU.apk
adb push su /system/bin
adb shell chmod 0755 /system/bin/su
adb push su /system/xbin/su 
adb shell chmod 0755 /system/xbin/su
adb shell su -i
adb shell "su -ad &"
adb shell setenforce 0
adb push xplore /system/app/
adb shell chmod 0644 /system/app/xplore/X-plore_3.98.02.apk

:purge
echo want purge (remove all of shit such as XgimiHome QiyiVideo mango HunanOTT)?
set /p typ4=%msg%
if %typ4%==1 goto gplay
adb shell rm -r /system/app/HunanOTT
adb shell rm -r /system/app/Instruction
adb shell rm -r /system/app/JOS
adb shell rm -r /system/app/KuyunCard
adb shell rm -r /system/app/KuyunLogo
adb shell rm -r /system/app/MPinyinIME
adb shell rm -r /system/lib/libjni_mpinyinime.so
adb push IME /system/app/
adb shell chmod 0644 /system/app/IME/IMEService.apk
adb shell rm -r /system/app/msgcenter
adb shell rm -r /system/app/Mangogame
adb shell rm -r /system/app/puremic
adb shell rm -r /system/app/QiyiVideo
adb shell rm -r /system/app/QQMusic
adb shell rm -r /system/app/SogouIME
adb shell rm -r /system/app/theme
adb shell rm -r /system/app/TVSports
adb shell rm -r /system/app/update
adb shell rm -r /system/app/vcontrol
adb shell rm -r /system/app/wirelessscreen
adb push tvpro /system/app/
adb shell chmod 0644 /system/app/tvpro/tvpro_V4.1_C47.apk
adb shell chmod 0644 /system/app/tvpro/lib/arm/libumeng-spy.so
adb shell chmod 0644 /system/app/tvpro/lib/arm/libswresample.so
adb shell chmod 0644 /system/app/tvpro/lib/arm/librtmp-jni.so
adb shell chmod 0644 /system/app/tvpro/lib/arm/libgit-platinum.so
adb shell chmod 0644 /system/app/tvpro/lib/arm/libffmpeg.so
adb shell chmod 0644 /system/app/tvpro/lib/arm/libcrashsdk.so
adb shell chmod 0644 /system/app/tvpro/lib/arm/libavutil.so
adb shell chmod 0644 /system/app/tvpro/lib/arm/libavresample.so
adb shell chmod 0644 /system/app/tvpro/lib/arm/libavcodec.so
adb shell rm -r /system/app/XgimiAdService
adb shell rm -r /system/app/XgimiBootwizard
adb shell rm -r /system/app/XgimiManager
adb shell rm -r /system/app/XgimiMusicParseService
adb shell rm -r /system/app/XgimiMusicPlayer
adb shell rm -r /system/app/Xgimipaysdk
adb shell rm -r /system/app/xgimiuiapi
adb shell rm -r /system/app/xgimiuser
adb shell rm -r /system/app/xgimiweather
adb shell rm -r /system/app/XgimiHome
adb push XgimiHome /system/app/
adb shell chmod 0644 /system/app/XgimiHome/XgimiHome.apk

:gplay
echo install google play? make sure already pure to get more rom space
set /p typ5=type 2 to purge, %msg%
if %typ5%==2 goto purge
if %typ5%==1 goto apps
adb push priv-app /system/
adb shell chmod 0644 /system/priv-app/GmsCore/GmsCore.apk
adb shell chmod 0644 /system/priv-app/GoogleLoginService/GoogleLoginService.apk
adb shell chmod 0644 /system/priv-app/GoogleServicesFramework/GoogleServicesFramework.apk
adb shell chmod 0644 /system/priv-app/Play/Play.apk
adb shell chmod 0644 /system/priv-app/GmsCore/lib/arm/libAppDataSearch.so
adb shell chmod 0644 /system/priv-app/GmsCore/lib/arm/libconscrypt_gmscore_jni.so
adb shell chmod 0644 /system/priv-app/GmsCore/lib/arm/libgcastv2_base.so
adb shell chmod 0644 /system/priv-app/GmsCore/lib/arm/libgcastv2_support.so
adb shell chmod 0644 /system/priv-app/GmsCore/lib/arm/libgmscore.so
adb shell chmod 0644 /system/priv-app/GmsCore/lib/arm/libgoogle-ocrclient-v3.so
adb shell chmod 0644 /system/priv-app/GmsCore/lib/arm/libjgcastservice.so
adb shell chmod 0644 /system/priv-app/GmsCore/lib/arm/libleveldbjni.so
adb shell chmod 0644 /system/priv-app/GmsCore/lib/arm/libNearbyApp.so
adb shell chmod 0644 /system/priv-app/GmsCore/lib/arm/libsslwrapper_jni.so
adb shell chmod 0644 /system/priv-app/GmsCore/lib/arm/libtango_utility_lib.so
adb shell chmod 0644 /system/priv-app/GmsCore/lib/arm/libwearable-selector.so
adb shell chmod 0644 /system/priv-app/GmsCore/lib/arm/libWhisper.so

:apps
echo one more thing, do u want some smart apps ......
set /p typ6=%msg%
if %typ6%==1 goto end
adb install NB4A-1.3.0-armeabi-v7a.apk
adb push nekobox.json /sdcard/

:end
adb shell mount -o remount,ro /system
adb reboot
adb kill-server
echo pls reboot manually
echo after reboot pls update the binary source of Superuser.apk manually
echo done...  enjoy
