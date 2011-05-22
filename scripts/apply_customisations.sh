#!/bin/sh

# Applies customisation to a ROM

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

echo -n "Copying GPS files..."
cp -rp customisations/gps/system rom/system
echo "done."

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
rm rom/system/app/Swype.apk
rm rom/system/lib/libSwypeCode.so
echo "done."

echo -n "Removing Protips..."
rm rom/system/app/Protips.apk
echo "done."

echo -n "Removing Samsung All..." 
rm rom/system/app/Dlna.apk
echo "done."

echo -n "Removing Sim Toolkit..."
rm rom/system/app/Stk.apk
echo "done."

echo -n "Removing PhoneSetupWizard..."
rm rom/system/app/PhoneSetupWizard.apk
echo "done."

echo -n "Removing PressReader..."
rm rom/system/app/PressReader.apk
echo "done."

echo -n "Removing GoogleFeedback..."
rm rom/system/app/GoogleFeedback.apk
echo "done."

echo -n "Removing autorun.iso.."
rm rom/system/etc/autorun.iso
echo "done."

echo -n "Removing startup sounds..."
rm rom/system/etc/PowerOn.wav
rm rom/system/etc/PowerOn.snd
echo "done."

echo -n "Removing battery notification tone..."
rm rom/system/media/audio/ui/TW_Battery_caution.ogg
echo "done."

echo "DONE - TRIMMING THE ROM"


# All these files will be created as symlinks when the ROM is installed

echo -n "Cleaning up ROM..."
rm rom/system/zipalign.log
rm rom/system/bin/cat
rm rom/system/bin/chmod
rm rom/system/bin/chown
rm rom/system/bin/cmp
rm rom/system/bin/date
rm rom/system/bin/dd
rm rom/system/bin/df
rm rom/system/bin/dmesg
rm rom/system/bin/getevent
rm rom/system/bin/getprop
rm rom/system/bin/hd
rm rom/system/bin/id
rm rom/system/bin/ifconfig
rm rom/system/bin/iftop
rm rom/system/bin/insmod
rm rom/system/bin/ioctl
rm rom/system/bin/ionice
rm rom/system/bin/kill
rm rom/system/bin/ln
rm rom/system/bin/log
rm rom/system/bin/ls
rm rom/system/bin/lsmod
rm rom/system/bin/mkdir
rm rom/system/bin/mount
rm rom/system/bin/mv
rm rom/system/bin/nandread
rm rom/system/bin/netstat
rm rom/system/bin/newfs_msdos
rm rom/system/bin/notify
rm rom/system/bin/printenv
rm rom/system/bin/ps
rm rom/system/bin/reboot
rm rom/system/bin/renice
rm rom/system/bin/rm
rm rom/system/bin/rmdir
rm rom/system/bin/rmmod
rm rom/system/bin/route
rm rom/system/bin/schedtop
rm rom/system/bin/sendevent
rm rom/system/bin/setconsole
rm rom/system/bin/setprop
rm rom/system/bin/sleep
rm rom/system/bin/smd
rm rom/system/bin/start
rm rom/system/bin/stop
rm rom/system/bin/sync
rm rom/system/bin/top
rm rom/system/bin/umount
rm rom/system/bin/vmstat
rm rom/system/bin/watchprops
rm rom/system/bin/wipe
rm rom/system/bin/dumpmesg
rm rom/system/bin/csview
echo "done."
