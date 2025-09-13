#!/bin/bash

echo "Running setup script for new terminal session..."

# Source the ROS 2 Jazzy setup script
source /ros_entrypoint.sh

# Disable exit on error to prevent terminal from closing
set +e