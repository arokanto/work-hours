#!/bin/sh

show_log=0
for arg in "$@"; do
    [ "$arg" = "--log" ] && show_log=1
done

today=$(date +%Y-%m-%d)
now_time=$(date +%H:%M:%S)
IFS=: read -r _h _m _s <<< "$now_time"
now_secs=$(( 10#$_h * 3600 + 10#$_m * 60 + 10#$_s ))

pmset -g log | grep "Display is turned" | awk \
    -v show_log="$show_log" \
    -v today="$today" \
    -v now_secs="$now_secs" \
    -v now_time="$now_time" \
'
BEGIN {
    GREEN = "\033[32m"
    RED   = "\033[31m"
    GRAY  = "\033[90m"
    RESET = "\033[0m"
    cur_day = ""; first_on = ""; last_off_secs = -1; on_start = -1; end_time = ""; nlog = 0
}
function t2s(t,   p) {
    split(t, p, ":")
    return p[1]*3600 + p[2]*60 + p[3]
}
function s2hm(s,  h, m) {
    h = int(s / 3600)
    m = int((s % 3600) / 60)
    return h "h " m "m"
}
function flush(   end_secs, first_str, end_str, work_secs, i) {
    if (cur_day == "") return

    if (cur_day == today && on_start >= 0) {
        end_secs = now_secs
        end_time = now_time
    } else {
        end_secs = last_off_secs
    }

    if (show_log) {
        for (i = 1; i <= nlog; i++)
            print GRAY log_lines[i] RESET
    }

    first_str = (first_on != "") ? first_on : "\342\200\224"
    end_str   = (end_secs >= 0) ? end_time  : "\342\200\224"

    work_secs = 0
    if (first_on != "" && end_secs >= 0 && end_secs > t2s(first_on))
        work_secs = end_secs - t2s(first_on)

    print cur_day "  opened: " GREEN first_str RESET "  closed: " RED end_str RESET "  working hours: " s2hm(work_secs)
    print ""
}
{
    if ($1 !~ /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/ || $2 !~ /^[0-9]{2}:[0-9]{2}:[0-9]{2}$/) next

    day = $1
    tm  = $2

    if (day != cur_day) {
        flush()
        cur_day = day; first_on = ""; last_off_secs = -1; on_start = -1; end_time = ""; nlog = 0
    }

    if (/turned on/) {
        state = "on"
        if (first_on == "") first_on = tm
        if (on_start < 0)   on_start = t2s(tm)
    } else {
        state = "off"
        on_start = -1
        last_off_secs = t2s(tm)
        end_time = tm
    }

    if (show_log) log_lines[++nlog] = tm "  display " state
}
END { flush() }
'
