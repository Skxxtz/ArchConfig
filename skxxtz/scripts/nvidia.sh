echo "Nvidia drm modeset"
# https://wiki.archlinux.org/title/NVIDIA#modeset
if [[ "$(cat /sys/module/nvidia_drm/parameters/modeset)" == "Y" ]]; then
    echo "✓ Passed"
else
    echo "✗ Not Passed"
fi 
echo "────────────────────" 
echo ""


echo "Nvidia fbdev"
# https://wiki.archlinux.org/title/NVIDIA#fbdev
if [[ "$(cat /sys/module/nvidia_drm/parameters/fbdev)" == "Y" ]]; then
    echo "✓ Passed"
else
    echo "✗ Not Passed"
fi 
echo "────────────────────" 

