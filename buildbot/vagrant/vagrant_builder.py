# Copyright (C) 2015 ZetaOps Inc.
#
# This file is licensed under the GNU General Public License v3
# (GPLv3).  See LICENSE.txt for details.

import sys
import os
import subprocess
import docker
import json

if __name__ == '__main__':
	# get files of latest comment
    files = subprocess.check_output("git diff-tree --no-commit-id --name-only -r $(git rev-parse HEAD)", shell=True)

    # if file in containers directory new docker image must be built
    scripts = [f.split('/')[1] for f in files.split('\n') if 'scripts' in f]

    # if template.json version changed
    # is_version_changed = True if subprocess.check_output("git diff $(git rev-parse HEAD) template.json | grep version", shell=True) else False
    is_version_changed = False if 'template.json' in files else True

    if is_version_changed:
        f=open('template.json', 'rw')
        fdict=json.loads(f.read())
        version_digits = fdict['post-processors'][0][1]['metadata']['version'].split('.')
        newversion = '.'.join(version_digits[0:2] + [str(int(version_digits[2]) + 1)])
        print("new version is: ", newversion)
        fdict['post-processors'][0][1]['metadata']['version'] = newversion
        f.write(json.dumps(fdict, sort_keys=True, indent=4))
        f.close()

    # thanks