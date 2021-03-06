# -*-  coding: utf-8 -*-

# Copyright (C) 2015 ZetaOps Inc.
#
# This file is licensed under the GNU General Public License v3
# (GPLv3).  See LICENSE.txt for details.

import datetime
from redmine import Redmine
import os

__author__ = 'Evren Kutar'
redmine_key = os.getenv('REDMINE_KEY')
redmine_url = os.getenv('REDMINE_URL')
redmine_project = os.getenv('REDMINE_PROJECT')

redmine = Redmine(redmine_url, key=redmine_key)

issue = redmine.issue.create(
	project_id='aerp',
	subject='vagrantbox test',
	tracker_id=2,
	description='vagrantbox test edilmesi',
	assigned_to_id=23)