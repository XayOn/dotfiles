#!/usr/bin/env bash

set -e

CONFIG="install.conf.yaml"
DOTBOT_DIR="dotbot"

DOTBOT_BIN="bin/dotbot"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

args="--except apt --except yay"

type apt &> /dev/null && args="--except yay" 
type yay &> /dev/null && args="--except apt"

cd "${BASEDIR}"

(cd "${DOTBOT_DIR}" && git submodule update --init --recursive)
"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -v -p "${BASEDIR}/dotbot-apt/apt.py" -p "${BASEDIR}/dotbot-sudo/sudo.py" -p "${BASEDIR}/dotbot-yay/yay.py"  -d "${BASEDIR}" -c "${CONFIG}" "${@}" $args

zsh
