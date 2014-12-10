#!/bin/sh
command -v drush >/dev/null 2>&1 || { echo '$ drush is not in $PATH. Aborting.' >&2; exit 1; }
if [ ! -e "$HOME/.drush/site_audit" ]
then
    echo "You must install drush site_audit first, see"
    echo "https://www.drupal.org/project/site_audit"
    exit 0
fi
drush ac --html --detail > /tmp/site_audit.html && drush abp --detail >> /tmp/site_audit.html && firefox /tmp/site_audit.html > /dev/null 2>&1
