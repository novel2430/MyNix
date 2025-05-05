{pkgs, ...}:
pkgs.writeShellScriptBin "my-awesome-cpu" ''
  PREV_TOTAL=0
  PREV_IDLE=0
  read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
  TOTAL=$((user + nice + system + idle + iowait + irq + softirq + steal))
  IDLE=$((idle + iowait))
  sleep 1
  read cpu2 user2 nice2 system2 idle2 iowait2 irq2 softirq2 steal2 guest2 guest_nice2 < /proc/stat
  TOTAL2=$((user2 + nice2 + system2 + idle2 + iowait2 + irq2 + softirq2 + steal2))
  IDLE2=$((idle2 + iowait2))
  sleep 1
  awk -v t1="$TOTAL" -v t2="$TOTAL2" -v i1="$IDLE" -v i2="$IDLE2" \
    'BEGIN {
        diff_total = t2 - t1;
        diff_idle  = i2 - i1;
        usage = (diff_total - diff_idle) * 100 / diff_total;
        printf("%.3f", usage);
    }'
''
