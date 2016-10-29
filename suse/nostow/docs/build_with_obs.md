https://en.opensuse.org/openSUSE:Build_Service_Tutorial

```
# Add user to /etc/sudoers:
sudo /usr/sbin/visudo

<youruser> ALL = NOPASSWD: /usr/bin/build
LOGIN    ALL = NOPASSWD: /usr/bin/osc
```

Install deps
https://en.opensuse.org/openSUSE:OSC


https://en.opensuse.org/openSUSE:Build_Service_Tips_and_Tricks
https://en.opensuse.org/openSUSE:Specfile_guidelines
https://en.opensuse.org/openSUSE:Creating_a_changes_file_(RPM)
https://en.opensuse.org/openSUSE:Build_Service_cross_distribution_howto
