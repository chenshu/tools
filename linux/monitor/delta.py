#!/usr/bin/python

import re
import sys
import time
import subprocess

SLEEP_FOR = 2.0
RED = 196
NUMBER_REGEX = re.compile(r'-?\d+')

def colorize(text, color):
    return '\033[38;5;%sm%s\033[0;00m' % (color, text)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print "Usage: ./delta COMMAND"
        sys.exit(1)

    command = " ".join(sys.argv[1:]) + "; exit 0;"
    result = []
    prev_result = []
    now = time.time()
    while True:
        result = subprocess.check_output(command, shell=True)
        delta_t = time.time() - now
        now = time.time()
        if result:
            result = result.split('\n')
            subbed_lines = []
            for (index, line) in enumerate(result):
                if index < len(prev_result):
                    prev_matches = list(NUMBER_REGEX.findall(prev_result[index]))

                    def delta_from_prev_match(match):
                        delta_v = int(match.group(0)) - int(prev_matches.pop(0)) if len(prev_matches) > 0 else 0
                        return colorize("%0.1f/sec" % (delta_v / delta_t), RED) if delta_v != 0 else match.group(0)

                    subbed_lines.append(NUMBER_REGEX.sub(delta_from_prev_match, line))
                else:
                    subbed_lines.append(line)
            print '\n'.join(subbed_lines)
            prev_result = result
        time.sleep(SLEEP_FOR)
