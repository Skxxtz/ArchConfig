
#!/bin/bash


# Handle command-line arguments
case "$1" in
    "--list-apps")
      pactl list sink-inputs | grep 'application.name =' | awk -F= '{print $2}' | sed 's/"//g' | awk '{$1=$1};1'
    ;;
    *)
    exit 1
    ;;
esac

exit 0
