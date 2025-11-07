## !-asus-oem-config-repair.ps1

#### I need a script to restore the relationships of the partitions on the G713QM I am repairing. I will not have access to Powershell on my rescue USB, so a .bat would also be needed. The commands that are needed are explained in this:

```
# 
# Fix MyAsus in WinRE
# Ensure that BitLocker is turned off

# Download DiskGenius

# Ensure you have RECOVERY, RESTORE, MYASUS partition (if you don’t have, try this)

# RECOVERY partition should have Recovery/WindowsRE/ReAgent.xml
# RESTORE partition should have Recovery/RecoveryImage/ASUS.swm
# MYASUS partition should have AsusWinRE/AsusWinRE.idx
# Screenshot 2024-06-16 123050-min
# In some cases the name of partition might be different or multiple partitions exist in that case explore all partition through DiskGenius and look for the files mentioned above
# Assign proper label to following partitions (case sensitive)

# To set label, in DiskGenius select the partition you want to rename right click --> set volume name --> type the proper name in the textbox --> hit ok
# Screenshot 2024-06-16 123304-min
# Set the label of C: drive to OS
# Make sure the label of recovery, restore, myasus is correctly set to RECOVERY, RESTORE, MYASUS
# Set the name of system partition to SYSTEM (sometimes has a blank label, this partition should contain EFI folder and is around 100MB in size)
# Screenshot 2024-06-16 122623-min
# Link Windows Recovery Environment to RECOVERY partition

# Search for command prompt and run it as administrator and execute the following commands:

# diskpart
# list disk
# select disk # (probably disk 0)
# list vol
# select vol # (select the RECOVERY partition)
# assign letter=x
# exit
# Screenshot 2024-06-16 122859-min
# Next, navigate in Windows Explorer to C:\windows\system32\Recovery DELETE or RENAME the file ReAgent.xml

# Go back to the elevated command prompt and execute the following commands:

# reagentc /disable (just in case it’s enabled with the wrong image, likely not)
# reagentc /setreimage /path x:\Recovery\WindowsRE /target C:\Windows
# reagentc /enable
# diskpart
# list disk
# select disk # (probably disk 0)
# list vol
# select vol # (select the RECOVERY partition)
# remove letter=x
# exit
# Screenshot 2024-06-16 122918-min
# Now go to WinRE (by holding shift and hitting restart) in troubleshoot there should be MyAsus in WinRE option!
# b864020e-5000-493c-8695-f3c28fbc4fcb-min

# credits:

# https://www.reddit.com/r/ASUS/comments/r6rd94/comment/k5hbaqi https://www.reddit.com/r/ZephyrusG14/comments/nvvldu/comment/h167f0e

# Restore RECOVERY, RESTORE, MYASUS partitions
# For this to work we need to acquire donor backup images of MYASUS, RESTORE, RECOVERY partitions ideally from someone with the same device.
# To create backup image ask the donor to follow this guide: How to Backup Partition to Image File
# If no donor available and you have RESTORE partition intact you can try using this backup image. The file format, partition size and link are given below (EXPERIMENTAL NOT TESTED)
# MYASUS partition [FAT32, 200MB]: https://drive.google.com/file/d/1utA8hrVOf7s10cC5dd0eqMBdIXuT9id6/view?usp=sharing
# RECOVERY partition [NTFS, 700 MB] (HIGHLY EXPERIMENTAL) : https://drive.google.com/file/d/1fb5E8ffKV2C-t8K5khG5SrvRO9xrmik5/view?usp=sharing
# Create partitions with same size and file format as the donor (ask donor for the size and file format of the partition) for me RESTORE partition is around 22GB (22*1024 MB)
# On the newly created partition restore the backup image: Restore Partition from Backup Image File
# 
---
Can you add error handling to the batch script? Up to this point, I've done all this manually, but I've had to start over from scratch too many times over the past 2 months; I want a more repeatable and revisable process. I have backups of all the partitions I keep refining, so wiping the drive and recreating the config has become old hat. But, with all the steps, it's too easy to forget something. I hope the script can help with that. I'll test it out. If I run into problems, I'll revisit this thread.

