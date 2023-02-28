# ValenSE Source Repo

I'm currently completely rebuilding ValenSE from ground up. It will
no longer come preinstalled with web server software or any of the 
specific to my use case software I bundled originally. ValenSE has
been stripped of everything not essential to boot the LiveISO (this
includes everything needed to allow it to be a headless ISO. P.S. 
SSH is only configured for my personal PC, you will need to add your
own keys), and the installation scripts will be rewritten in C and
also stripped of everything non-essential. The "completed" version
will be forked and serve as the new base for any potential future
ValenOS builds.

WiFi will not work ootb initially. I'll add support for this later
when the core of ValenSE is done.

I briefly went over BIOS support with syslinux. It should work but
if it does not let me know. All my systems are UEFI/iBoot. Grub is
currenty bootloader. I'd like to bundle it with reFind. Mainly
because reFind automatically updates boot options when new OS's
are deleted or added. If this breaks BIOS support then oh well.

Under Construction.
![Valen Server Edition!](https://i.imgur.com/jGpT1qC.jpeg)
