# work-hours
A tiny shell script that tells you how long did you work each day for the past week. Infers the info from when your screen first turned on and last turned off each day.

## Installation

Run
```bash
curl -fsSL https://raw.githubusercontent.com/arokanto/work-hours/main/install.sh | sh
```

This installs `wh` into your `~/.local/bin` and adds that dir to your PATH if it isn't there yet. Although it's good practice to check that the script matches what random people on the internet tell you.

## Usage

To get your working hours for the past week:
```bash
wh
```

To get a detailed log
```bash
wh --log
```
