#!/bin/bash

# WARNING: DO NOT EDIT, THIS FILE IS PROBABLY A COPY
#
# The original version of this file is located in the https://github.com/istio/common-files repo.
# If you're looking at this file in a different repo and want to make a change, please go to the
# common-files repo, make the change there and check it in. Then come back to this repo and run
# "make update-common".

# Copyright Istio Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOTDIR=$(dirname "${SCRIPTPATH}")
cd "${ROOTDIR}"

ret=0
for fn in $(find "${ROOTDIR}" -type f \( -name '*.go' -o -name '*.cc' -o -name '*.h' -o -name '*.sh' -o -name '*.proto' \) | grep -v vendor); do
  if [[ $fn == *.pb.* ]] || [[ $fn == *.gen.* ]];then
    continue
  fi

  if ! head -20 "$fn" | grep "Apache License, Version 2" > /dev/null; then
    echo "${fn} missing license"
    ret=$((ret+1))
  fi

  if ! head -20 "$fn" | grep Copyright > /dev/null; then
    echo "${fn} missing Copyright"
    ret=$((ret+1))
  fi
done

exit $ret
