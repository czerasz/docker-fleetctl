#!/bin/bash

# Start the ssh-agent
eval $(ssh-agent) > /dev/null

# Add the ~/.ssh/rd_rsa key to the agent
ssh-add > /dev/null 2>&1

# Run the fleetctl command width given parameters
/usr/bin/fleetctl $@
