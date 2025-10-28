#!/bin/bash
# Simple deploy for static Tic-Tac-Toe app
set -e


# Install nginx and git
if [ -x "$(command -v apt-get)" ]; then
apt-get update
