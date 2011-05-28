#!/bin/sh

# Applies customisation to a ROM


#
# Removes file from the rom - friendly version
#
remove_file()
{
	file=$1
	echo -n "  removing: $file "
	rm -f "$file"
	echo "done."
}

#
# Removes an app from the ROM
#
remove_app()
{
	file="rom/system/app/$1"
	echo -n "  removing: $file "
	rm -f "$file"
	echo "done."
}


#
# Copy core files to ROM: kernel, modem, CSC, etc
#
echo "Adding core files to ROM"
echo -n "  adding: updater-script..."
cp -rp customisations/META-INF rom
echo "done."

echo -n "  adding: kernel & modem..."
cp -rp customisations/updates rom
cp customisations/kernel/zImage rom/updates
cp customisations/modem/modem.bin rom/updates
echo "done."

echo -n "  adding: CSC files..."
cp -rp customisations/csc-system/* rom/system
echo "done."

#echo -n "Copying GPS files..."
#cp -rp customisations/gps/system rom/system
#echo "done."

echo -n "  adding: bootanimation..."
cp customisations/bootanimation/bootanimation.zip rom/system/media
echo "done."

echo -n "  adding: root..."
cp -p customisations/root/system/xbin/busybox rom/system/xbin
cp -p customisations/root/system/xbin/su rom/system/xbin
cp -p customisations/root/system/app/Superuser.apk rom/system/app
echo "done."

echo -n "  adding: zipalign..."
cp -p customisations/system-bin/zipalign rom/system/bin
chmod 755 rom/system/bin/zipalign
echo "done"

echo -n "  adding: init.d files..."
cp -rp customisations/init.d rom/system/etc
echo "done."

echo -n "  adding: armeabi-v7a library files..."
cp -rp customisations/lib/armeabi-v7a rom/system/lib
echo "done."

#
# Add custom apps to the ROM
#
echo "Adding custom apps"

echo -n "  adding: Email-iPhone app..."
cp customisations/custom-apps/Email.apk rom/system/app
echo "done."


#
# Remove apps from the ROM
#
echo "Trimming the ROM"

# Swype (I'm using the beta version instead)
remove_app Swype.apk
remove_file rom/system/lib/libSwypeCode.so

# Aldiko Standard
#remove_app aldiko-standard-1.2.6.1-samsung-s1.apk

# Bluetooth Test Mode
#remove_app BluetoothTestMode.apk

# Buddies Now - widget for touchwiz launcher
remove_app BuddiesNow.apk

# Days - widget for touchwiz launcher
remove_app Days.apk

# Dual Clock - have two clocks on your homescreen for different timezones
remove_app DualClock.apk

# Facebook support. SNS Provider, Account, Unified Inbox
#   - to have facebook/twitter/myspace accounts synced in your contacts and calendar and have all the updates of posts there
#remove_app SnsAccount.apk
#remove_app SnsProvider.apk
#remove_app SnsAccount.apk
#remove_app SnsProvider.apk

# Google Feedback
remove_app GoogleFeedback.apk

# HTML Viewer
#remove_app HTMLViewer.apk

# Info Alarm
#remove_app InfoAlarm.apk

# Layar samsung
#remove_app Layar-samsung.apk

# Memo
#remove_app Memo.apk

# Mini Diary
#remove_app MiniDiary.apk

# Mtp Application - let Samsung Kies recognize and connect to your PDA
#remove_app Mtpapplication.apk

# Press Reader
remove_app PressReader.apk

# Protips
remove_app Protips.apk

# Samsung All Share - wireless communication with other Samsung dlna compatible devices
remove_app Dlna.apk

# Samsung Apps
remove_app SamsungApps.apk

# Samsung Widget Calendar Clock - shows a calendar/clock on your homescreen
#remove_app SamsungWidget_CalendarClock.apk

# Samsung Widget Feed And Update - view rss feeds on your homescreen
#remove_app SamsungWidget_FeedAndUpdate.apk

# Samsung Widget Stock Clock - shows clock on your homescreen
#remove_app SamsungWidget_StockClock.apk

# Sim Toolkit
remove_app Stk.apk

# Street View
#remove_app Street.apk

# ThinkDroid - ThinkFree Office
#remove_app Thinkdroid.apk

# TW (Touch Wiz) Live Wallpapers 
#remove_app TwWallpaperChooser.apk
#remove_app TATLiveWallpaperBeach.apk
#remove_app TATLiveWallpapersAurora.apk
#remove_app TATLiveWallpapersBlueSea.apk

# Voice Recorder
#remove_app VoiceRecorder.apk

# Voice Search
#remove_app VoiceSearch.apk

# Wipereceiver 
#remove_app wipereceiver.apk
#remove_app MobileTrackerEngineTwo.apk
#remove_app MobileTrackerUI.apk

# Write and Go
remove_app WriteandGo.apk

# YouTube
#remove_app YouTube.apk


#
# Always remove the following apps and files
#

# PhoneSetupWizard - otherwise we'll have to go through the setup each time we load a new ROM
remove_app PhoneSetupWizard.apk

# autorun.iso
remove_file rom/system/etc/autorun.iso

# startup sounds
remove_file rom/system/etc/PowerOn.wav
remove_file rom/system/etc/PowerOn.snd

# battery notification tone - removes sounds when the battery is full (keeps waking me up)
remove_file rom/system/media/audio/ui/TW_Battery_caution.ogg
#
# Finished trimming the ROM.
#

#
# All these files will be created as symlinks when the ROM is installed
#
echo "Removing symlinks (will be re-created when installing the ROM)"
remove_file rom/system/zipalign.log
remove_file rom/system/bin/cat
remove_file rom/system/bin/chmod
remove_file rom/system/bin/chown
remove_file rom/system/bin/cmp
remove_file rom/system/bin/date
remove_file rom/system/bin/dd
remove_file rom/system/bin/df
remove_file rom/system/bin/dmesg
remove_file rom/system/bin/getevent
remove_file rom/system/bin/getprop
remove_file rom/system/bin/hd
remove_file rom/system/bin/id
remove_file rom/system/bin/ifconfig
remove_file rom/system/bin/iftop
remove_file rom/system/bin/insmod
remove_file rom/system/bin/ioctl
remove_file rom/system/bin/ionice
remove_file rom/system/bin/kill
remove_file rom/system/bin/ln
remove_file rom/system/bin/log
remove_file rom/system/bin/ls
remove_file rom/system/bin/lsmod
remove_file rom/system/bin/mkdir
remove_file rom/system/bin/mount
remove_file rom/system/bin/mv
remove_file rom/system/bin/nandread
remove_file rom/system/bin/netstat
remove_file rom/system/bin/newfs_msdos
remove_file rom/system/bin/notify
remove_file rom/system/bin/printenv
remove_file rom/system/bin/ps
remove_file rom/system/bin/reboot
remove_file rom/system/bin/renice
remove_file rom/system/bin/rm
remove_file rom/system/bin/rmdir
remove_file rom/system/bin/rmmod
remove_file rom/system/bin/route
remove_file rom/system/bin/schedtop
remove_file rom/system/bin/sendevent
remove_file rom/system/bin/setconsole
remove_file rom/system/bin/setprop
remove_file rom/system/bin/sleep
remove_file rom/system/bin/smd
remove_file rom/system/bin/start
remove_file rom/system/bin/stop
remove_file rom/system/bin/sync
remove_file rom/system/bin/top
remove_file rom/system/bin/umount
remove_file rom/system/bin/vmstat
remove_file rom/system/bin/watchprops
remove_file rom/system/bin/wipe
remove_file rom/system/bin/dumpmesg
remove_file rom/system/bin/csview
# symlinks removed

# Now we're done
echo "ROM almost complete, ZIP it up and install using CWM."


