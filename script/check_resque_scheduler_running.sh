#!/bin/bash

# Check if resque workers are running
# Restart workers if they are not running
# Usage: check_resque_scheduler_running.sh <hostname> <development|production>

if ps aux | grep -v grep | grep 'resque-scheduler' > /dev/null 2>&1
  then
    sleep 1;
  else
    echo "Hydra server $1 did not have resque-scheduler running.  It has been automatically restarted and will be checked again in one hour." > /tmp/resquealert
    sleep 1
    mail -s "Scholar resque-scheduler restarted on $1" scholar@uc.edu < /tmp/resquealert
    cd /srv/apps/curate_uc/script
    export PATH=$PATH:/srv/apps/.gem/ruby/2.1.0/bin:/opt/fits/fits-0.6.2/
    /srv/apps/curate_uc/script/restart_resque_scheduler.sh $2
fi
