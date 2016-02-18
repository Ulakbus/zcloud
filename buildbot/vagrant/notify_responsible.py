# -*-  coding: utf-8 -*-

# Copyright (C) 2015 ZetaOps Inc.
#
# This file is licensed under the GNU General Public License v3
# (GPLv3).  See LICENSE.txt for details.

import datetime
from redmine import Redmine
import os

__author__ = 'Evren Kutar'
redmine_key = os.environ.get('REDMINE_KEY', None)
redmine_url = os.environ.get('REDMINE_URL', None)
redmine_project = os.environ.get('REDMINE_PROJECT', None)

issue = redmine.issue.create(
	project_id='ulakbus',
	subject='vagrantbox test',
	tracker_id=2,
	description='vagrantbox test edilmesi',
	assigned_to_id=23)