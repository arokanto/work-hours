# work-hours
A tiny shell script that tells you how long you worked each day for the past week. Infers the info from when your screen first turned on and last turned off each day.

Note that this uses the MacOS `pmset` to get the screen's on/off signals, so it won't work on other operating systems. Linux apparently has something similar in `/var/log/syslog` so porting this should be pretty easy, especially if you're okay to burn some tokens and let AI do it for you.

## Installation

Run this:
```bash
curl -fsSL https://raw.githubusercontent.com/arokanto/work-hours/main/install.sh | sh
```

That installs `wh` into your `~/.local/bin` and adds that dir to your PATH if it isn't there yet. Although it's good practice to check that the script matches what random people on the internet tell you.

## Usage

To get your working hours for the past week:
```bash
wh
```

To get a detailed log
```bash
wh --log
```

It looks something like this:

```bash
2026-05-04  opened: 12:21:26  closed: 14:42:14  working hours: 2h 20m

2026-05-05  opened: 08:38:08  closed: 17:32:06  working hours: 8h 53m

2026-05-06  opened: 08:22:13  closed: 19:28:39  working hours: 11h 6m

2026-05-07  opened: 07:53:36  closed: 16:18:46  working hours: 8h 25m

2026-05-08  opened: 09:07:05  closed: 17:09:29  working hours: 8h 2m

2026-05-09  opened: 17:04:26  closed: 18:48:42  working hours: 1h 44m
```
