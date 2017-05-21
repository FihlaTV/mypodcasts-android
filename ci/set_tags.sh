#!/usr/bin/env bash

BRANCH="master"

# Are we on the right branch?
if [ "$TRAVIS_BRANCH" = "$BRANCH" ]; then

  # Is this not a Pull Request?
  if [ "$TRAVIS_PULL_REQUEST" = false ]; then

    # Is this not a build which was triggered by setting a new tag?
    if [ -z "$TRAVIS_TAG" ]; then
      echo -e "Starting to tag commit.\n"

      git config --global user.email "travis@travis-ci.org"
      git config --global user.name "Travis"

      APK_VERSION=$(cat app/build.gradle | grep versionName | awk '{print $2}' | sed 's/"//g')

      # Add tag and push to master.
      git tag -a v${APK_VERSION}-${TRAVIS_BUILD_NUMBER} -m "Travis build $TRAVIS_BUILD_NUMBER pushed a tag."
      git push origin --tags
      git fetch origin

      echo -e "Pushed a tag v${APK_VERSION}-${TRAVIS_BUILD_NUMBER}"
  fi
  fi
fi