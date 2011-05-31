#!/bin/sh

# Kernel, Modem & CSC
rom_kernel="mic_kernel-v06.2"
rom_modem="xxjq1"
rom_csc="xsa"
rom_bootanimation="android_rings"

# Apply custom GPS files
include_custom_gps=0

#
# Which custom apps to include in the ROM
#
#  1 - include app in the ROM
#  0 - do not include app in the ROM
#
#  default is to NOT include the custom app
#
include_custom_app_in_rom()
{
	case $1 in
		Email)		include_app=1 ;;
		Superuser)	include_app=1 ;;
		*)		include_app=0 ;;
	esac
}



# Swype
include_Swype=0

# Aldiko Standard eBook Reader
include_Aldiko=0

# Bluetooth Test Mode
include_BluetoothTestMode=1

# Days - widget for touchwiz launcher
include_Days=0

# Days - widget for touchwiz launcher
include_DualClock=0

# Facebook support. SNS Provider, Account, Unified Inbox
#   - to have facebook/twitter/myspace accounts synced in your contacts and calendar and have all the updates of posts there
include_Sns=1

# Google Feedback
include_GoogleFeedback=1

# HTML Viewer
include_HTMLViewer=1

# Info Alarm
include_InfoAlarm=1

# Layar samsung
include_Layar=0

# Memo
include_Memo=0

# Mini Diary
include_MiniDiary=0

# Mtp Application - let Samsung Kies recognize and connect to your PDA
include_Mtpapplication=1

# Press Reader
include_PressReader=0

# Protips
include_Protips=0

# Samsung All Share - wireless communication with other Samsung dlna compatible devices
include_Dlna=0

# Samsung Apps
include_SamsungApps=0

# Samsung Widget Calendar Clock - shows a calendar/clock on your homescreen
include_SamsungWidget_CalendarClock=1

# Samsung Widget Feed And Update - view rss feeds on your homescreen
include_SamsungWidget_FeedAndUpdate=1

# Samsung Widget Stock Clock - shows clock on your homescreen
include_SamsungWidget_StockClock=1

# Sim Toolkit
include_Stk=0

# Street View
include_Street=1

# ThinkDroid - ThinkFree Office
include_Thinkdroid=1

# TW (Touch Wiz) Live Wallpapers 
include_TWLiveWallpapers=1

# Voice Recorder
include_VoiceRecorder=1

# Voice Search
include_VoiceSearch=1

# Wipereceiver 
include_Wipereceiver=1

# Write and Go
include_WriteandGo=0

# YouTube
include_YouTube=1


#
# Which apps to include in the ROM
#
#  1 - include app in the ROM
#  0 - do not include app in the ROM
#
#  default is to leave the app in the ROM
#
include_app_in_rom()
{
	case $1 in
		aldiko-standard-1.2.6.1-samsung-s1)	include_app=0 ;;
		YouTube)				include_app=1 ;;
		*)					include_app=1 ;;
	esac
}

#################################################################################################

# Details of the ROM we're using as the base
rom_base="rom_bases/rom"
target_rom="rom"

custom="customisations"

#
# Base ROM locations
#
get_rom_base_dir()
{
	# ROM base location
	case $1 in
		data)		rom_base_dir="$rom_base/data"   ;;
		system)		rom_base_dir="$rom_base/system" ;;
		updates)	rom_base_dir="$custom/updates"  ;;
		kernel)		rom_base_dir="$custom/kernel"   ;;
		modem)		rom_base_dir="$custom/modem"	;;
		csc)		rom_base_dir="$custom/csc"	;;
		gps)		rom_base_dir="$custom/gps/system"  ;;
		bootanimation)	rom_base_dir="$custom/bootanimation" ;;
		xbin)		rom_base_dir="$custom/system-xbin" ;;
		bin)		rom_base_dir="$custom/system-bin"  ;;
		lib)		rom_base_dir="$custom/system-lib"  ;;
		etc)		rom_base_dir="$custom/system-etc"  ;;
		meta_inf)	rom_base_dir="$custom/META-INF"    ;;
		app)		rom_base_dir="$custom/app"	   ;;
	esac
}

#
# Target ROM locations
#
get_target_rom_dir()
{
	# target ROM location
	case $1 in
		data)		target_rom_dir="$target_rom/data"    ;;
		system)		target_rom_dir="$target_rom/system"  ;;
		updates)	target_rom_dir="$target_rom/updates" ;;
		kernel)		target_rom_dir="$target_rom/updates" ;;
		modem)		target_rom_dir="$target_rom/updates" ;;
		csc)		target_rom_dir="$target_rom/system"  ;;
		gps)		target_rom_dir="$target_rom/system"  ;;
		bootanimation)	target_rom_dir="$target_rom/system/media" ;;
		xbin)		target_rom_dir="$target_rom/system/xbin"  ;;
		bin)		target_rom_dir="$target_rom/system/bin"   ;;
		lib)		target_rom_dir="$target_rom/system/lib"   ;;
		etc)		target_rom_dir="$target_rom/system/etc"   ;;
		meta_inf)	target_rom_dir="$target_rom/META-INF"	  ;;
		app)		target_rom_dir="$target_rom/system/app"	  ;;
	esac
}

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
# Delete everything from the target ROM directory
#
create_empty_target_rom()
{
	if test -d $target_rom; then
		rm -rf $target_rom/*
	else
		mkdir -p $target_rom
	fi
}

#
# Bulk copy the system files from the base ROM into the target ROM 
#
bulk_populate_rom()
{
	# Add system directory from ROM base into the target ROM
	get_rom_base_dir system 
	get_target_rom_dir system

	if ! test -d $rom_base_dir; then
		echo "ROM base not found: $rom_base_dir"
		exit 1
	fi

	if ! test -d $target_rom_dir; then
		mkdir -p $target_rom_dir
	fi

	echo "Copying system files into $target_rom_dir"
	(cd $rom_base_dir; tar cf - .) | (cd $target_rom_dir; tar xpf -)

	# Add the updates directory from customisations into the target ROM
	get_rom_base_dir updates
	get_target_rom_dir updates

	if test -d $rom_base_dir; then
		cp -rp $rom_base_dir $target_rom_dir
	else
		echo "ERROR: cannot find updates directory: $rom_base_dir"
	fi
}

#
# Add kernel into ROM
#
add_kernel()
{
	name=$1

	get_rom_base_dir kernel
	get_target_rom_dir kernel

	custom_kernel="$rom_base_dir/$name/zImage"

	if test -e $custom_kernel; then
		cp $custom_kernel $target_rom_dir
	else
		echo "ERROR: cannot find kernel: $name in $custom_kernel"
		exit 1
	fi
}

#
# Add modem into ROM
#
add_modem()
{
	name=$1

	get_rom_base_dir modem
	get_target_rom_dir modem

	custom_file="$rom_base_dir/$name/modem.bin"

	if test -e $custom_file; then
		cp $custom_file $target_rom_dir
	else
		echo "ERROR: cannot find modem: $name in $custom_file"
		exit 1
	fi
}

#
# Remove CSC from ROM
#
remove_csc()
{
	get_target_rom_dir csc

	rm -f "$target_rom_dir/CSCFiles.txt"
	rm -f "$target_rom_dir/CSCVersion.txt"
	rm -f "$target_rom_dir/SW_Configuration.xml"
	rm -rf "$target_rom_dir/csc"
}

#
# Add CSC into ROM
#
add_csc()
{
	name=$1

	# first remove the existing CSC
	remove_csc

	get_rom_base_dir csc
	get_target_rom_dir csc

	custom_csc_dir="$rom_base_dir/$name"

	if test -d $custom_csc_dir; then
		cp -rp $custom_csc_dir/* $target_rom_dir
	else
		echo "ERROR: cannot find csc: $name in $custom_csc_dir"
		exit 1
	fi
}

#
# Add Custom GPS
#
add_custom_gps()
{
	if test $include_custom_gps = 0; then
		return
	fi

	echo "  adding custom gps"
	get_rom_base_dir gps
	get_target_rom_dir gps

	if test -d $rom_base_dir; then
		cp -rp $rom_base_dir $target_rom_dir
	fi
}

#
# Add bootanimation into ROM
#
add_bootanimation()
{
	name=$1

	get_rom_base_dir bootanimation
	get_target_rom_dir bootanimation

	custom_file="$rom_base_dir/$name/bootanimation.zip"

	echo "  adding: bootanimation"
	if test -e $custom_file; then
		cp $custom_file $target_rom_dir
	else
		echo "ERROR: cannot find bootanimation: $name in $custom_file"
		exit 1
	fi
}


#
# Add files into the ROM
#
add_into_rom()
{
	function=$1
	name=$2
	case $function in
		kernel)		
			echo "  adding kernel: $name"
			add_kernel $name
			;;
		modem)		
			echo "  adding modem : $name" 
			add_modem $name
			;;
		csc)		
			echo "  adding csc   : $name" 
			add_csc $name
			;;
	esac	
}

#
# Add root
#
add_root()
{
	echo "TODO: add Superuser app"
	# add_custom_app Superuser
	# add_system_xbin
}

#
# Merge custom system/bin to ROM
#
merge_system_bin()
{
	get_rom_base_dir bin
	get_target_rom_dir bin

	if test -d $rom_base_dir; then
		cp -rp $rom_base_dir/* $target_rom_dir
	fi
}

#
# Merge custom system/xbin to ROM
#
merge_system_xbin()
{
	get_rom_base_dir xbin
	get_target_rom_dir xbin

	if test -d $rom_base_dir; then
		cp -rp $rom_base_dir/* $target_rom_dir
	fi
}

#
# Merge custom system/lib to ROM
#
merge_system_lib()
{
	get_rom_base_dir lib
	get_target_rom_dir lib

	if test -d $rom_base_dir; then
		cp -rp $rom_base_dir/* $target_rom_dir
	fi
}

#
# Merge custom system/etc to ROM
#
merge_system_etc()
{
	get_rom_base_dir etc
	get_target_rom_dir etc

	if test -d $rom_base_dir; then
		cp -rp $rom_base_dir/* $target_rom_dir
	fi
}

#
# Add META-INF scripts
#
add_meta_inf()
{
	get_rom_base_dir meta_inf
	get_target_rom_dir meta_inf

	! test -d $target_rom_dir && mkdir -p $target_rom_dir

	cp -rp $rom_base_dir/* $target_rom_dir
}

#
# Add custom app to ROM
#
add_custom_app()
{
	name=$1

	get_rom_base_dir app
	get_target_rom_dir app

	custom_app="$rom_base_dir/$name.apk"

	test -f $custom_app && cp $custom_app $target_rom_dir
}

#
# Add custom apps to ROM
#
add_custom_apps()
{
	get_rom_base_dir app
	get_target_rom_dir app

	for custom_app in $rom_base_dir/*; do

		! test -f $custom_app && continue

		app_name=${custom_app%\.*}
		short_app_name=${app_name#$rom_base_dir/}
		
		include_custom_app_in_rom $short_app_name

		if test $include_app = 1; then
			echo "  adding custom app: $short_app_name"
			cp $custom_app $target_rom_dir
		fi

	done
}

#
# Remove app from ROM
#
trim_apps()
{
	get_rom_base_dir app
	get_target_rom_dir app

	for system_app in $target_rom_dir/*; do

		! test -f $system_app && continue

		app_name=${system_app%\.*}
		short_app_name=${app_name#$target_rom_dir/}

		include_app_in_rom $short_app_name

		if test $include_app = 0; then
			echo "  TODO: removing app: $short_app_name"
			#rm -f $system_app
		fi

	done
}


# main()

echo "Preparing target rom"
create_empty_target_rom
bulk_populate_rom

# adding: kernel, modem & csc..."
add_into_rom kernel $rom_kernel
add_into_rom modem  $rom_modem
add_into_rom csc    $rom_csc
echo "done."

add_custom_gps
add_bootanimation $rom_bootanimation

# merge custom system directories into the ROM
merge_system_xbin
merge_system_bin
merge_system_lib
merge_system_etc

# add the updater-scripts
add_meta_inf

# Start removing apps from the ROM
trim_apps

# Add custom apps into the ROM
add_custom_apps



echo "done (for now!)"
exit 0


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


