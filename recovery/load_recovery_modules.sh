#!/system/bin/sh

MODULE_DIR=/lib/modules
MODULE_LIST="$MODULE_DIR/modules.load.recovery"
TOYBOX=/system/bin/toybox

log_msg() {
    echo "load_recovery_modules: $1" > /dev/kmsg
}

if [ ! -r "$MODULE_LIST" ]; then
    log_msg "missing $MODULE_LIST"
    exit 0
fi

if [ ! -x "$TOYBOX" ]; then
    log_msg "missing $TOYBOX"
    exit 1
fi

while IFS= read -r module || [ -n "$module" ]; do
    case "$module" in
        ""|\#*)
            continue
            ;;
    esac

    module_path="$MODULE_DIR/$module"
    if [ ! -f "$module_path" ]; then
        log_msg "skip missing $module_path"
        continue
    fi

    "$TOYBOX" insmod "$module_path" >/dev/null 2>&1 || log_msg "insmod failed for $module"
done < "$MODULE_LIST"

log_msg "module load pass finished"
