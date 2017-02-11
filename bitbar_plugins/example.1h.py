#!/usr/bin/env python
# -*- coding: utf-8 -*-
# <bitbar.title>Example</bitbar.title>
# <bitbar.version>v0.1</bitbar.version>
# <bitbar.author.github>damnever</bitbar.author.github>
# <bitbar.author>damnever</bitbar.author>
# <bitbar.desc>Example crontab.</bitbar.desc>
# <bitbar.dependencies>python</bitbar.dependencies>

output = ''':smile:
---
:point_right: ^_^ | color=green href=https://github.com/damnever
:heart: | bash="kill -9 $(ps -p $PPID -o ppid=)"
'''


if __name__ == '__main__':
    print(output)
