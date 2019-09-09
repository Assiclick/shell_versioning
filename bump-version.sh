#!/bin/bash
. ./shell_versioning/templates.sh
. ./shell_versioning/github_pat.sh

LATEST_HASH=`git log --pretty=format:'%h' -n 1`

ADJUSTMENTS_MSG="${INFO_FLAG}Now you can ${UNDER}make adjustments${RESET}${INFO} to ${WHITE}CHANGELOG.md${INFO}. Then ${BOLD}press enter${RESET}${INFO} to continue."

PUSHING_MSG="${NOTICE_FLAG}Pushing new version to the ${WHITE}origin${NOTICE}${BLINK}...${RESET}"

if [ -f version ]; then
    BASE_STRING=`cat version`
    BASE_LIST=(`echo $BASE_STRING | tr '.' ' '`)
    V_MAJOR=${BASE_LIST[0]}
    V_MINOR=${BASE_LIST[1]}
    V_PATCH=${BASE_LIST[2]}
    echo -e "${INFO_FLAG}Current version: ${WHITE}$BASE_STRING"
    echo -e "${INFO_FLAG}Latest commit hash: ${WHITE}$LATEST_HASH"
    if [ "$VERSION" = "MAJOR" ]; then
        V_MAJOR=$((V_MAJOR + 1))
        V_MINOR=0
        V_PATCH=0
    else
        V_MAJOR=$V_MAJOR
    fi
    if [ "$VERSION" = "MINOR" ]; then
        V_MINOR=$((V_MINOR + 1))
        V_PATCH=0
    else
        V_PATCH=$V_PATCH
    fi
    if [ "$VERSION" = "PATCH" ]; then
        V_PATCH=$((V_PATCH + 1))
    else
        V_PATCH=0
    fi
    SUGGESTED_VERSION="$V_MAJOR.$V_MINOR.$V_PATCH"
    echo -ne "${QUESTION_FLAG}Enter a version number ${RESET}[${YELLOW}$SUGGESTED_VERSION${RESET}]: "
    read INPUT_STRING
    if [ "$INPUT_STRING" = "" ]; then
        INPUT_STRING=$SUGGESTED_VERSION
    fi
    echo -e "${NOTICE_FLAG}Will set new version to be ${WHITE}$INPUT_STRING"
    echo $INPUT_STRING > version
    echo "## $INPUT_STRING ($NOW)" > tmpfile
    git log --pretty=format:"  - %s" "v$BASE_STRING"...HEAD >> tmpfile
    echo "" >> tmpfile
    echo "" >> tmpfile
    cat CHANGELOG.md >> tmpfile
    mv tmpfile CHANGELOG.md
    echo -e "$ADJUSTMENTS_MSG"
    read
    echo -e "$PUSHING_MSG"
    git add CHANGELOG.md version
    git commit -m "Bump version to ${INPUT_STRING}."
    git tag -a -m "Tag version v${INPUT_STRING}." "v$INPUT_STRING"
    git push --follow-tags

    curl -sS -X POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token $GITHUB_PAT" -d '{
  "tag_name": "'v$INPUT_STRING'",
  "target_commitish": "master",
  "name": "'v$INPUT_STRING'",
  "body": "[Changelog](CHANGELOG.md)",
  "draft": false,
  "prerelease": false
}' "https://api.github.com/repos/Assiclick/TestingPlace/releases" > /dev/null

else
    echo -e "${WARNING_FLAG}Could not find a version file."
    echo -ne "${QUESTION_FLAG}Do you want to create a version file and start from scratch? [y|N] (yes/no) ${RESET}[${YELLOW}no${RESET}]: "
    read RESPONSE
    if [ "$RESPONSE" = "Y" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "Yes" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "yes" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "YES" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "y" ]; then
        echo "0.1.0" > version
        echo "## 0.1.0 ($NOW)" > CHANGELOG.md
        git log --pretty=format:"  - %s" >> CHANGELOG.md
        echo "" >> CHANGELOG.md
        echo "" >> CHANGELOG.md
        echo -e "$ADJUSTMENTS_MSG"
        read
        echo -e "$PUSHING_MSG"
        git add version CHANGELOG.md
        git commit -m "Add version and CHANGELOG.md files, Bump version to v0.1.0."
        git tag -a -m "Tag version v0.1.0." "v0.1.0"
        git push --follow-tags

        curl -sS -X POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token '$GITHUB_PAT'" -d '{
  "tag_name": "v0.1.0",
  "target_commitish": "master",
  "name": "v0.1.0",
  "body": "[Changelog](CHANGELOG.md)",
  "draft": false,
  "prerelease": false
}' "https://api.github.com/repos/Assiclick/TestingPlace/releases" > /dev/null
    fi
fi

echo -e "${INFO_FLAG}Versioning done."