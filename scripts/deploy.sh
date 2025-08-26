#!/bin/bash
set -e
rsync -avz ./frontend/ ${SERVER_USER}@${SERVER_HOST}:${PROJECT_PATH}
rsync -avz ./backend/ ${SERVER_USER}@${SERVER_HOST}:${PROJECT_PATH}/backend
