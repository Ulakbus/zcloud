# Copyright (C) 2015 ZetaOps Inc.
#
# This file is licensed under the GNU General Public License v3
# (GPLv3).  See LICENSE.txt for details.

import sys
import subprocess


if __name__ == '__main__':
	subprocess.check_output("./grepdirectories.sh", shell=True)