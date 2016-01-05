# Copyright (C) 2015 ZetaOps Inc.
#
# This file is licensed under the GNU General Public License v3
# (GPLv3).  See LICENSE.txt for details.

import sys
import os
import subprocess

if __name__ == '__main__':
	files = subprocess.check_output("git diff-tree --no-commit-id --name-only -r $(git rev-parse HEAD)", shell=True).split('\n')
	containers = [f.split('/')[1] for f in files if 'containers' in f]
	unique_containers = set(containers)
	basepath = '/buildslave/sourcefiles/containers/'

	for i in unique_containers:
		os.chdir(basepath+i)
		f = open("Dockerfile", "r")
		buildname = [line.split('=') for line in f.readlines() if 'BUILDNAME' in line][0][1]
		subprocess.check_output("docker build -t %s .") % buildname
		subprocess.check_output("docker push %s") % buildname