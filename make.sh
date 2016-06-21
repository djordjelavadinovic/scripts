#!/bin/bash
# Djordje Lavadinovic <djordje.lavdinovic@asseco-see.rs>
#
# This script compiles Java project and creates .war file for camunda-bpm
#
# If maven is present localy, then it uses maven to install dependencies, compile
# source and run unit tests.
#
# If not, runs maven Docker container to do the same job.
#

if [ -n "`type -t mvn`" ]
# If there's maven
then
  cd bpm-common
  mvn install
  cd ../bpm-camunda
  mvn install
elif [ -n "`type -t docker`" ]
# Otherwise, start maven in a container
then
# First, make a folder for caching dependencies used by maven and project
  mkdir -p .m2
# Docker run options:
# --rm  : remove maven container after compiling
# -v    : mount app's source dir on /usr/src/app inside maven container
# -v    : mount .m2 folder on /root/.m2 of maven container for persistency reasons
# -w    : make current folder working folder for container
#
# Bootstrap - by running container, this script will be executed again
# (but with maven present)
#
  docker run --rm -it -v $(pwd):/usr/src/app -v $(pwd)/.m2:/root/.m2 -w "/usr/src/app" maven:latest ./scripts/make.sh
fi
