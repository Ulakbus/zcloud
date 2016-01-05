# Copyright (C) 2015 ZetaOps Inc.
#
# This file is licensed under the GNU General Public License v3
# (GPLv3).  See LICENSE.txt for details.

import sys
import os
import subprocess
import docker

if __name__ == '__main__':
	# get files of latest comment
    files = subprocess.check_output("git diff-tree --no-commit-id --name-only -r $(git rev-parse HEAD)", shell=True).split('\n')

    # if file in containers directory new docker image must be built
    containers = [f.split('/')[1] for f in files if 'containers' in f]

    # remove duplicates of container names
    unique_containers = set(containers)
    # basepath for reaching proper Dockerfile
    basepath = '/buildslave/sourcefiles/containers/'

    for i in unique_containers:
        os.chdir(basepath+i)
        print("directory and its contents: ", os.getcwd(), os.listdir('.'))

        # get buildname from Dockerfile
        # it must be commented line with format: # BUILDNAME='sample/buildname'
        f = open("Dockerfile", "r")
        buildname = [line.split('=') for line in f.readlines() if 'BUILDNAME' in line][0][1]
        buildname = buildname.replace('\n', '')

        print("buildname: ", buildname, "will be built")

        client = docker.Client("http://ulakbus-buildbot-slave-01.zetaops.local:2375", version="auto")
        buildit= client.build(tag=buildname, path=os.getcwd())
        for i in buildit:
        	print(i)
        
        print("############# build finished ############")

        login = client.login(email=os.getenv('DOCKERHUBMAIL'), username=os.getenv('DOCKERHUBUSERNAME'), password=os.getenv('DOCKERHUBPASS'))

        pushit= client.push(buildname)
        for i in pushit:
        	print(i)

        print("############# push finished ############")

    # thanks