#!/systeam/bin/sh
List_nmsl() {
fuck_string_list="
hamjin
hamJin
hamJTY
hamjty
HamJin
Hamjin
Hanjty"
    LIST_PATH="/data/adb/modules"
    for loop1 in $fuck_string_list; do
        for loop2 in $(ls -1 $LIST_PATH); do
            if [ "$LIST_PATH/$loop2" != "/data/adb/modules/hamjinRemover" ]; then
                if [ "$(grep "$loop1" <$LIST_PATH/"$loop2"/module.prop)" != "" ]; then
                    echo "[$(date '+%Y-%m-%d %H:%M:%S')][WARNING]: Conflict detected, uninstalled for you: $loop1."
                    chattr -R -i $LIST_PATH/"$loop2"  2>/dev/null
                    sh "$LIST_PATH/$loop2/uninstall.sh" 2>/dev/null
                    rm -rf ${LIST_PATH:?}/"$loop2"
                elif [ -f $LIST_PATH/"$loop2"/service.sh ]; then
                    [ ! -f $LIST_PATH/"$loop2"/service.sh.rlast.sh ] && mv $LIST_PATH/"$loop2"/service.sh $LIST_PATH/"$loop2"/service.sh.rlast.sh
                    cp "$MODPATH"/patchfile/service.sh $LIST_PATH/"$loop2"/service.sh
                fi
            fi
        done
    done
}
echo "
- *******************************

- hamjin Remover —— 用于在检测到系统中安装的某个模块作者为hamjty时, 进行删除操作

- 版本: $(grep_prop versionCode "$MODPATH"/module.prop)
- 作者: $(grep_prop author "$MODPATH"/module.prop)
- *******************************
- 正在安装。。。"
List_nmsl
