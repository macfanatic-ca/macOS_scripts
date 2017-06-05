#!/bin/bash

localAdminUser=example

cd /Users/$localAdminUser && sudo -H -u $localAdminUser /usr/local/bin/autopkg repo-add https://github.com/autopkg/recipes.git
