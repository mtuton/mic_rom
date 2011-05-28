#!/bin/sh

# Applies customisation to a ROM

remove_file()
{
	file=$1
	echo -n "removing $file"
	if test -f "$file"; then
		rm "$file"
	else
		echo "$file already removed."
	fi
	echo "done"
}

echo -n "Copying updater-script..."
cp -rp customisations/META-INF rom
echo "done."

echo -n "Copying kernel & modem..."
cp customisations/kernel/zImage rom/updates
cp customisations/modem/modem.bin rom/updates
echo "done."

echo -n "Copying CSC files..."
cp -rp customisations/csc-system/* rom/system
echo "done."

#echo -n "Copying GPS files..."
#cp -rp customisations/gps/system rom/system
#echo "done."

echo -n "Copying bootanimation..."
cp customisations/bootanimation/bootanimation.zip rom/system/media
echo "done."

echo -n "Rooting the ROM..."
cp -p customisations/root/system/xbin/busybox rom/system/xbin
cp -p customisations/root/system/xbin/su rom/system/xbin
cp -p customisations/root/system/app/Superuser.apk rom/system/app
echo "done."

echo -n "Copying zipalign..."
cp -p customisations/system-bin/zipalign rom/system/bin
chmod 755 rom/system/bin/zipalign
echo "done"

echo -n "Copying init.d files..."
cp -rp customisations/init.d rom/system/etc
echo "done."

echo -n "Copying armeabi-v7a library files..."
cp -rp customisations/lib/armeabi-v7a rom/system/lib
echo "done."

echo "APPLYING CUSTOM APPS"

echo -n "Copying Email-iPhone app..."
cp customisations/custom-apps/Email.apk rom/system/app
echo "done."

echo "DONE - APPLYING CUSTOM APPS"

echo "TRIMMING THE ROM"

echo -n "Removing Swype..."
remove_file rom/system/app/Swype.apk
remove_file rom/system/lib/libSwypeCode.so
echo "done."

echo -n "Removing Protips..."
remove_file rom/system/app/Protips.apk
echo "done."

echo -n "Removing Samsung All..." 
remove_file rom/system/app/Dlna.apk
echo "done."

echo -n "Removing Sim Toolkit..."
remove_file rom/system/app/Stk.apk
echo "done."

echo -n "Removing PhoneSetupWizard..."
remove_file rom/system/app/PhoneSetupWizard.apk
echo "done."

echo -n "Removing PressReader..."
remove_file rom/system/app/PressReader.apk
echo "done."

echo -n "Removing GoogleFeedback..."
remove_file rom/system/app/GoogleFeedback.apk
echo "done."

echo -n "Removing autorun.iso.."
remove_file rom/system/etc/autorun.iso
echo "done."

echo -n "Removing startup sounds..."
remove_file rom/system/etc/PowerOn.wav
remove_file rom/system/etc/PowerOn.snd
echo "done."

echo -n "Removing battery notification tone..."
remove_file rom/system/media/audio/ui/TW_Battery_caution.ogg
echo "done."

echo "DONE - TRIMMING THE ROM"


# All these files will be created as symlinks when the ROM is installed

echo -n "Cleaning up ROM..."
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
echo "done."
