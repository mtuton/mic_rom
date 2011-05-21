Custom components

The following contains the details for customising the ROM.

*** SYSTEM FILES ***

Kernel & Modem
- copy file in kernal & modem fodler into the /updates folder
    - Kernel - mic_kernel v06
    - Modem  - XXJQ1

CSC
- copy csc-system files into /system and /system/csc folders

GPS
- copy gps files into /system folder

Bootanimation
- copy bootanimation.zip into /system/media folder

Root (busybox, su & Superuser.apk)
- copy system files into /system
- /system/xbin
- /system/app

zipalign
- copy system-bin files into /system/bin folder

init.d
- copy init.d files into /system/etc

armeabi-v7a
- copy lib/armeabi-v7a folder into /system/lib

 ** Deodex the ROM now **


*** APPLICATIONS ***

Email-iPhone
- ROM needs to be deodexed before inserting this app into ROM
- copy custom-apps/Email.apk into /system/app


*** TRIM THE ROM ***

Trim the ROM
- remove the following files
- Swype
    - /system/app/Swype.apk
    - /system/lib/libSwypeCode.so

- Protips
    - /system/apps/Protips.apk

- Samsung All Share
    - /system/app/Dlna.apk

- STK - Sim Toolkit
    - /system/app/Stk.apk

- PhoneSetupWizard
    - /system/app/PhoneSetupWizard.apk

- PressReader
    - /system/app/PressReader.apk

- GoogleFeedback
    - /system/app/GoogleFeedback.apk

- autorun.iso
    - /system/etc/autorun.iso

- startup sounds
    - /system/etc/PowerOn.wav
    - /system/etc/PowerOn.snd

*** CLEANUP ***

Remove the following files

rm system/zipalign.log
rm system/bin/cat
rm system/bin/chmod
rm system/bin/chown
rm system/bin/cmp
rm system/bin/date
rm system/bin/dd
rm system/bin/df
rm system/bin/dmesg
rm system/bin/getevent
rm system/bin/getprop
rm system/bin/hd
rm system/bin/id
rm system/bin/ifconfig
rm system/bin/iftop
rm system/bin/insmod
rm system/bin/ioctl
rm system/bin/ionice
rm system/bin/kill
rm system/bin/ln
rm system/bin/log
rm system/bin/ls
rm system/bin/lsmod
rm system/bin/mkdir
rm system/bin/mount
rm system/bin/mv
rm system/bin/nandread
rm system/bin/netstat
rm system/bin/newfs_msdos
rm system/bin/notify
rm system/bin/printenv
rm system/bin/ps
rm system/bin/reboot
rm system/bin/renice
rm system/bin/rm
rm system/bin/rmdir
rm system/bin/rmmod
rm system/bin/route
rm system/bin/schedtop
rm system/bin/sendevent
rm system/bin/setconsole
rm system/bin/setprop
rm system/bin/sleep
rm system/bin/smd
rm system/bin/start
rm system/bin/stop
rm system/bin/sync
rm system/bin/top
rm system/bin/umount
rm system/bin/vmstat
rm system/bin/watchprops
rm system/bin/wipe

