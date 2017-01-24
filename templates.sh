#!/bin/bash
# Define variables
NOW="$(date +'%d %B %Y')"

# Define colors templates
DEF="\033[39m"
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
PURPLE="\033[35m"
CYAN="\033[36m"
LGRAY="\033[37m"
DGRAY="\033[90m"
LRED="\033[91m"
LGREEN="\033[92m"
LYELLOW="\033[93m"
LBLUE="\033[94m"
LPURPLE="\033[95m"
LCYAN="\033[96m"
WHITE="\033[97m"
RESET="\033[0m"

# Define formatting templates
BOLD="\033[1m"
DIM="\033[2m"
UNDER="\033[4m"
BLINK="\033[5m"
REVERSE="\033[7m"
HIDDEN="\033[8m"

# Define styled colors
QUESTION="${GREEN}"
WARNING="${LRED}"
ERROR="${RED}"
NOTICE="${DEF}"
INFO="${GREEN}"

# Define flags
QUESTION_FLAG="${QUESTION}? "
WARNING_FLAG="${WARNING}! "
ERROR_FLAG="${ERROR}! "
NOTICE_FLAG="${NOTICE}❯ "
INFO_FLAG="${INFO}❯ "