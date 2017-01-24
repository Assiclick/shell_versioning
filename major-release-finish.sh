#!/bin/bash
. ./shell_versioning/templates.sh
. ./shell_versioning/github_pat.sh

if [ -f version ]; then
    git checkout master
    BASE_STRING=`cat version`
    git checkout -
    BASE_LIST=(`echo $BASE_STRING | tr '.' ' '`)
    V_MAJOR=${BASE_LIST[0]}
    V_MINOR=${BASE_LIST[1]}
    V_PATCH=${BASE_LIST[2]}
    echo -e "${INFO_FLAG}Current version: ${WHITE}$BASE_STRING"
    V_MAJOR=$((V_MAJOR + 1))
    V_MINOR=0
    V_PATCH=0
    SUGGESTED_VERSION="$V_MAJOR.$V_MINOR.$V_PATCH"
    echo -ne "${QUESTION_FLAG}Enter a version number ${RESET}[${YELLOW}$SUGGESTED_VERSION${RESET}]: "
    read INPUT_STRING
    if [ "$INPUT_STRING" = "" ]; then
        INPUT_STRING=$SUGGESTED_VERSION
    fi
    BRANCH=release-v${INPUT_STRING}

    git checkout master
    git merge --no-ff ${BRANCH}

    VERSION=MAJOR
    . ./shell/bump-version.sh

    git checkout develop
    git merge --no-ff ${BRANCH}
    git push

    echo -e "${INFO_FLAG}Done."
else
    echo -e "${ERROR_FLAG}There is no version file on master branch."
fi