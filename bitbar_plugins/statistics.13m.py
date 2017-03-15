#!/usr/bin/env python
# -*- coding: utf-8 -*-
# <bitbar.title>Example</bitbar.title>
# <bitbar.version>v0.1</bitbar.version>
# <bitbar.author.github>damnever</bitbar.author.github>
# <bitbar.author>damnever</bitbar.author>
# <bitbar.desc>Example crontab.</bitbar.desc>
# <bitbar.dependencies>python</bitbar.dependencies>

import subprocess


SMILE = ':smile:'
CRY = ':sob:'
CMD = 'ping -c 66 -q damnever.com'
OUTPUT = r'''{loss:.2f}%{status}
---
:point_right: ^_^ | color=green href=https://github.com/damnever
:heart: | bash="for i in {{0..255}}; do printf \"\x1b[38;5;${{i}}mcolour${{i}}\x1b[0m\n\" done && kill -9 $(ps -p $PPID -o ppid=)"
'''

def network_statistics():
    try:
        output = subprocess.check_output(
            CMD, stderr=subprocess.STDOUT, shell=True)
    except Exception:
        return 100.0
    statistics = output.decode('utf-8').splitlines()
    if len(statistics) <= 2:
        return 100.0
    loss = statistics[-2].rsplit(',', 1)[1]
    return float(loss.split('%', 1)[0].strip())


if __name__ == '__main__':
    loss = network_statistics()
    status = SMILE if loss <= 33.33 else CRY
    print(OUTPUT.format(status=status, loss=loss))
