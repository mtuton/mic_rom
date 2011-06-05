#!/bin/sh

#
# The name of the module to insert into the ROM
#   - Kernel, Modem, CSC & Boot animation
#
get_module_name()
{
	case $1 in
		kernel)		module_name="kernel" 		;;
		modem)		module_name="modem" 		;;
		csc)		module_name="xsa"		;;
		bootanimation)	module_name="bootanimation"	;;
	esac
}

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
		Email)		include_app=0 ;;
		Superuser)	include_app=1 ;;
		*)		include_app=0 ;;
	esac
}

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
		aldiko-standard-1.2.6.1-samsung-s1)	include_app=0 ;; # Aldiko Standard eBook reader
		BlueToothTestMode)			include_app=1 ;; # Blue Test Mode
		BuddiesNow)				include_app=0 ;; # Buddies Now - widget for touchwiz launcher
		Days)					include_app=0 ;; # Days - widget for touchwiz launcher
		Dlna)					include_app=0 ;; # Samsung All Share - wireless communication with other 
									 #   Samsung dlna compatible devices
		DualClock)				include_app=0 ;; # Dual Clock - have two clocks on your homescreen for different timezones
		Email)					include_app=0 ;; # this will be replaced by a custom Email app
		GoogleFeedback)				include_app=0 ;; # Google Feedback
		HTMLViewer)				include_app=1 ;; # HTML Viewer
		InfoAlarm)				include_app=0 ;; # Info Alarm (Daily Briefing)
		Layar-samsung)				include_app=0 ;; # Layar
		Memo)					include_app=1 ;; # Memo
		MiniDiary)				include_app=0 ;; # Mini Diary
		MtpApplication)				include_app=1 ;; # Mtp Application - let Samsung Kies recognize and connect to your PDA
		PhoneSetupWizard)			include_app=0 ;; # Run Setup Wizard on boot (always remove this from ROM)
		PressReader)				include_app=0 ;; # Press Reader
		Protips)				include_app=0 ;; # Protime (useless app)
		SamsungApps)				include_app=0 ;; # Samsung Apps
		SamsungWidget_CalendarClock)		include_app=1 ;; # Samsung Widget Calendar Clock - shows a calendar/clock on your homescreen
		SamsungWidget_FeedAndUpdate)		include_app=1 ;; # Samsung Widget Feed And Update - view rss feeds on your homescreen
		SamsungWidget_StockClock)		include_app=1 ;; # Samsung Widget Stock Clock - shows clock on your homescreen
		SnsAccount)				include_app=1 ;; # Facebook support. SNS Provider, Account, Unified Inbox
		SnsProvider)				include_app=1 ;; #   - to have facebook/twitter/myspace accounts synced in 
									 #     your contacts and calendar and have all the updates of posts there
		Stk)					include_app=0 ;; # Sim Toolkit
		Street)					include_app=1 ;; # Street View (part of Google Maps)
		Swype)					include_app=0 ;; # Swype (ensure that the Swype lib files are also removed)
		thinkdroid)				include_app=1 ;; # ThinkDriod - Think Office Free
		TwWallpaperChooser)			include_app=1 ;; # TW (TouchWiz) Live Wallpapers
		TATLiveWallpaperBeach)			include_app=1 ;; #   "
		TATLiveWallpapersAurora)		include_app=1 ;; #   "
		TATLiveWallpapersBlueSea)		include_app=1 ;; #   "
		VoiceRecorder)				include_app=1 ;; # Voice Recorder
		VoiceSearch)				include_app=1 ;; # Voice Search
		wipereceiver)				include_app=1 ;; # Wipereceiver (Samsung Dive)
		MobileTrackerEngineTwo)			include_app=1 ;; #    "
		MobileTrackerUI)			include_app=1 ;; #    "
		WriteandGo)				include_app=0 ;; # Write and Go
		YouTube)				include_app=1 ;; # YouTube
		*)					include_app=1 ;; # default - include app in ROM
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
		data)		rom_base_dir="$custom/data"     ;;
		data-app)	rom_base_dir="$custom/data/app" ;;
		system)		rom_base_dir="$rom_base/system" ;;
		updates)	rom_base_dir="$custom/updates"  ;;
		kernel)		rom_base_dir="$custom/kernel"   ;;
		modem)		rom_base_dir="$custom/modem"	;;
		csc)		rom_base_dir="$custom/csc"	;;
		gps)		rom_base_dir="$custom/gps/system"    ;;
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
		data)		target_rom_dir="$target_rom/data"     ;;
		data-app)	target_rom_dir="$target_rom/data/app" ;;
		system)		target_rom_dir="$target_rom/system"   ;;
		updates)	target_rom_dir="$target_rom/updates"  ;;
		kernel)		target_rom_dir="$target_rom/updates"  ;;
		modem)		target_rom_dir="$target_rom/updates"  ;;
		csc)		target_rom_dir="$target_rom/system"   ;;
		gps)		target_rom_dir="$target_rom/system"   ;;
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
	#echo -n "  removing: $file "
	rm -f "$file"
	#echo "done."
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
	get_rom_base_dir bootanimation
	get_target_rom_dir bootanimation
	get_module_name bootanimation

	custom_file="$rom_base_dir/$module_name/bootanimation.zip"

	echo "  adding: bootanimation"
	if test -e $custom_file; then
		cp $custom_file $target_rom_dir
	else
		echo "ERROR: cannot find bootanimation: $module_name in $custom_file"
		exit 1
	fi
}


#
# Add files into the ROM
#
add_into_rom()
{
	function=$1
	get_module_name $function
	case $function in
		kernel)		
			echo "  adding kernel: $module_name"
			add_kernel $module_name
			;;
		modem)		
			echo "  adding modem : $module_name" 
			add_modem $module_name
			;;
		csc)		
			echo "  adding csc   : $module_name" 
			add_csc $module_name
			;;
	esac	
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
# Merge custom data directory with ROM data directory
#
merge_rom_data()
{
	get_rom_base_dir data
	get_target_rom_dir data

	if test -d $rom_base_dir; then
		! test -d $target_rom_dir && mkdir -p $target_rom_dir
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
# Cleanup Swype
#
cleanup_swype()
{
	get_target_rom_dir lib
	include_app_in_rom Swype
	test $include_app = 0 && remove_file $target_rom_dir/libSwypeCore.so
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
			rm -f $target_rom_dir/$short_app_name.apk
			rm -f $target_rom_dir/$short_app_name.odex
		fi

	done
}

#
# These files are all symlinks in RFS - we'll re-create them when installing the ROM
#
remove_rfs_symlinks()
{
	get_target_rom_dir bin
	remove_file $target_rom_dir/cat
	remove_file $target_rom_dir/chmod
	remove_file $target_rom_dir/chown
	remove_file $target_rom_dir/cmp
	remove_file $target_rom_dir/date
	remove_file $target_rom_dir/dd
	remove_file $target_rom_dir/df
	remove_file $target_rom_dir/dmesg
	remove_file $target_rom_dir/getevent
	remove_file $target_rom_dir/getprop
	remove_file $target_rom_dir/hd
	remove_file $target_rom_dir/id
	remove_file $target_rom_dir/ifconfig
	remove_file $target_rom_dir/iftop
	remove_file $target_rom_dir/insmod
	remove_file $target_rom_dir/ioctl
	remove_file $target_rom_dir/ionice
	remove_file $target_rom_dir/kill
	remove_file $target_rom_dir/ln
	remove_file $target_rom_dir/log
	remove_file $target_rom_dir/ls
	remove_file $target_rom_dir/lsmod
	remove_file $target_rom_dir/mkdir
	remove_file $target_rom_dir/mount
	remove_file $target_rom_dir/mv
	remove_file $target_rom_dir/nandread
	remove_file $target_rom_dir/netstat
	remove_file $target_rom_dir/newfs_msdos
	remove_file $target_rom_dir/notify
	remove_file $target_rom_dir/printenv
	remove_file $target_rom_dir/ps
	remove_file $target_rom_dir/reboot
	remove_file $target_rom_dir/renice
	remove_file $target_rom_dir/rm
	remove_file $target_rom_dir/rmdir
	remove_file $target_rom_dir/rmmod
	remove_file $target_rom_dir/route
	remove_file $target_rom_dir/schedtop
	remove_file $target_rom_dir/sendevent
	remove_file $target_rom_dir/setconsole
	remove_file $target_rom_dir/setprop
	remove_file $target_rom_dir/sleep
	remove_file $target_rom_dir/smd
	remove_file $target_rom_dir/start
	remove_file $target_rom_dir/stop
	remove_file $target_rom_dir/sync
	remove_file $target_rom_dir/top
	remove_file $target_rom_dir/umount
	remove_file $target_rom_dir/vmstat
	remove_file $target_rom_dir/watchprops
	remove_file $target_rom_dir/wipe
	remove_file $target_rom_dir/dumpmesg
	remove_file $target_rom_dir/csview
}

zip_up_rom()
{
	echo "Creating ROM zip file..."
	zipfile_name="mic_rom-NEW.zip"
	(cd $target_rom; zip -qr $zipfile_name ./*)
	test -f $target_rom/$zipfile_name && mv $target_rom/$zipfile_name .
	echo "ROM is in file: $zipfile_name"
}


# main()

echo "Preparing target rom"
create_empty_target_rom
bulk_populate_rom

# adding: kernel, modem & csc..."
#add_into_rom kernel $rom_kernel
#add_into_rom modem  $rom_modem
#add_into_rom csc    $rom_csc
add_into_rom kernel
add_into_rom modem
add_into_rom csc
echo "done."

echo "Adding custom GPS and bootanimation..."
add_custom_gps
#add_bootanimation $rom_bootanimation
add_bootanimation

# merge custom system directories into the ROM
merge_system_xbin
merge_system_bin
merge_system_lib
merge_system_etc
merge_rom_data

# add the updater-scripts
add_meta_inf
echo "done."

echo "Trimming the ROM..."
# Start removing apps from the ROM
trim_apps
cleanup_swype
echo "done."

echo "Adding custom applications..."
# Add custom apps into the ROM
add_custom_apps
echo "done."

echo "Additional cleanup (removing autorun and startup sounds)... "
# remove autorun.iso
get_target_rom_dir etc
rm -f $target_rom_dir/autorun.iso

# startup sounds
remove_file $target_rom_dir/PowerOn.wav
remove_file $target_rom_dir/PowerOn.snd

# battery notification tone - removes sounds when the battery is full (keeps waking me up)
get_target_rom_dir system
remove_file $target_rom_dir/media/audio/ui/TW_Battery_caution.ogg

# battery notification tone - removes sounds when the battery is full (keeps waking me up)
remove_file rom/system/media/audio/ui/TW_Battery_caution.ogg
#
# Finished trimming the ROM.
#

#
# All these files will be created as symlinks when the ROM is installed
#
echo "Removing symlinks (will be re-created when installing the ROM)"
get_target_rom_dir system
remove_file $target_rom_dir/zipalign.log

# symlinks removed
remove_rfs_symlinks

# zip up the ROM
zip_up_rom

echo "done!"


