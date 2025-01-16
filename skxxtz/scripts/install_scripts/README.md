## Auth
To use a fingerprint on my machine, I need to add the following line to the `/etc/pam.d/_` file:<br>
`auth		sufficient  	pam_fprintd.so`.<br>
Required packages:
- libfprintd
- fprintd
