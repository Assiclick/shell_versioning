#!/bin/bash
. ./shell_versioning/templates.sh
. ./shell_versioning/github_pat.sh

if [ -f version ]; then
    git checkout master
    BASE_STRING=`cat version`
    git checkout develop
    BASE_LIST=(`echo $BASE_STRING | tr '.' ' '`)
    V_MAJOR=${BASE_LIST[0]}
    V_MINOR=${BASE_LIST[1]}
    V_PATCH=${BASE_LIST[2]}
    echo -e "${INFO_FLAG}Current version: ${WHITE}$BASE_STRING"
    V_MINOR=$((V_MINOR + 1))
    V_PATCH=0
    SUGGESTED_VERSION="$V_MAJOR.$V_MINOR.$V_PATCH"
    echo -ne "${QUESTION_FLAG}Enter a version number ${RESET}[${YELLOW}$SUGGESTED_VERSION${RESET}]: "
    read INPUT_STRING
    if [ "$INPUT_STRING" = "" ]; then
        INPUT_STRING=$SUGGESTED_VERSION
    fi
    echo -e "${NOTICE_FLAG}Will set new version to be ${WHITE}$INPUT_STRING"
    RELEASE=release-v${INPUT_STRING}
    git checkout -b $RELEASE develop
    echo -e "${INFO_FLAG}Release branch created."
else
    echo -e "${ERROR_FLAG}There is no version file."
fi