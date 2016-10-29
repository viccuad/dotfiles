if  cat /etc/os-release | grep ID=opensuse ; then
    export LIBVIRT_DEFAULT_URI=qemu:///system;
fi
