#!/usr/bin/bash

# === Color ===
RED="\033[0;31m"
GREEN="\033[0;32m"
NO_COLOR="\033[0m"

# 해당 리스트에 포함된 의존성의 설치 여부를 확인
# install checklist. script will iterate this list and check if each item is installed
install_checklist=(
  "python3"
  "docker"
  "aws"
)

# 미설치 의존성, 의존성체크가 실패했다면 아래 리스트가 비어있지않음
# Uninstalled dependencies list. if this list is not empty, install check failed
uninstalled_dependencies=()

# === 의존성 체크 ===
# === install check ===
for dependency in "${install_checklist[@]}"; do
  if ! command -v "${dependency}" &>/dev/null; then
    # if dependency is not installed, add it to uninstalled_dependencies list
    uninstalled_dependencies+=("${dependency}")
  fi
done

# === check result ===
# if uninstalled_dependencies list is not empty, install check failed
if [ "${#uninstalled_dependencies[@]}" -ne 0 ]; then
  echo -e "${RED}ERROR${NO_COLOR}: the following dependencies are not installed:"
  for dependency in "${uninstalled_dependencies[@]}"; do
    echo " ${dependency}"
  done
  # trigger failure by exiting with non-zero code
  exit 1
else
  echo -e "${GREEN}INFO${NO_COLOR}: install check passed"
fi
