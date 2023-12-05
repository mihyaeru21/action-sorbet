#!/bin/sh -e
# original implementation: https://github.com/tk0miya/action-steep

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

TEMP_PATH="$(mktemp -d)"
PATH="${TEMP_PATH}:$PATH"

echo '::group::🐶 Installing reviewdog ... https://github.com/reviewdog/reviewdog'
curl -sfL https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b "${TEMP_PATH}" 2>&1
echo '::endgroup::'

echo '::group:: Running sorbet with reviewdog 🐶 ...'
bundle exec srb typecheck 2>&1 | ruby ${GITHUB_ACTION_PATH}/rdjson_filter.rb \
  | reviewdog \
      -f=rdjson \
      -reporter="${INPUT_REPORTER}" \
      -filter-mode="${INPUT_FILTER_MODE}" \
      -level="${INPUT_LEVEL}"
echo '::endgroup::'
