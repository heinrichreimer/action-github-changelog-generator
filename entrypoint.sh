#!/bin/bash
istrue () {
  case $1 in
    "true"|"yes"|"y") return 0;;
    *) return 1;;
  esac
}

set -e

# Go to GitHub workspace.
if [ -n "$GITHUB_WORKSPACE" ]; then
  cd "$GITHUB_WORKSPACE" || exit
fi

# Set repository from GitHub, if not set.
if [ -z "$INPUT_REPO" ]; then INPUT_REPO="$GITHUB_REPOSITORY"; fi
# Set user input from repository, if not set.
if [ -z "$INPUT_USER" ]; then INPUT_USER=$(echo "$INPUT_REPO" | cut -d / -f 1 ); fi
# Set project input from repository, if not set.
if [ -z "$INPUT_PROJECT" ]; then INPUT_PROJECT=$(echo "$INPUT_REPO" | cut -d / -f 2- ); fi


# Only show last tag.
if istrue "$INPUT_ONLYLASTTAG"; then
  INPUT_DUETAG=""
  INPUT_SINCETAG=$(git describe --abbrev=0 --tags $(git rev-list --tags --skip=1 --max-count=1))
fi

# Build arguments.
if [ -n "$INPUT_USER" ]; then ARG_USER="--user $INPUT_USER"; fi
if [ -n "$INPUT_PROJECT" ]; then ARG_PROJECT="--project $INPUT_PROJECT"; fi
if [ -n "$INPUT_TOKEN" ]; then ARG_TOKEN="--token $INPUT_TOKEN"; fi
if [ -n "$INPUT_DATEFORMAT" ]; then ARG_DATEFORMAT="--date-format $INPUT_DATEFORMAT"; fi
if [ -n "$INPUT_OUTPUT" ]; then ARG_OUTPUT="--output $INPUT_OUTPUT"; fi
if [ -n "$INPUT_BASE" ]; then ARG_BASE="--base $INPUT_BASE"; fi
if [ -n "$INPUT_HEADERLABEL" ]; then ARG_HEADERLABEL=(--header-label "$INPUT_HEADERLABEL"); fi
if [ -n "$INPUT_CONFIGURESECTIONS" ]; then ARG_CONFIGURESECTIONS=(--configure-sections "$INPUT_CONFIGURESECTIONS"); fi
if [ -n "$INPUT_ADDSECTIONS" ]; then ARG_ADDSECTIONS=(--add-sections "$INPUT_ADDSECTIONS"); fi
if [ -n "$INPUT_FRONTMATTER" ]; then ARG_FRONTMATTER=(--front-matter "$INPUT_FRONTMATTER"); fi
if istrue "$INPUT_ISSUES"; then ARG_ISSUES="--issues"; else ARG_ISSUES="--no-issues"; fi
if istrue "$INPUT_ISSUESWOLABELS"; then ARG_ISSUESWOLABELS="--issues-wo-labels"; else ARG_ISSUESWOLABELS="--no-issues-wo-labels"; fi
if istrue "$INPUT_PULLREQUESTS"; then ARG_PULLREQUESTS="--pull-requests"; else ARG_PULLREQUESTS="--no-pull-requests"; fi
if istrue "$INPUT_PRWOLABELS"; then ARG_PRWOLABELS="--pr-wo-labels"; else ARG_PRWOLABELS="--no-pr-wo-labels"; fi
if istrue "$INPUT_FILTERBYMILESTONE"; then ARG_FILTERBYMILESTONE="--filter-by-milestone"; else ARG_FILTERBYMILESTONE="--no-filter-by-milestone"; fi
if istrue "$INPUT_AUTHOR"; then ARG_AUTHOR="--author"; else ARG_AUTHOR="--no-author"; fi
if istrue "$INPUT_USERNAMESASGITHUBLOGINS"; then ARG_USERNAMESASGITHUBLOGINS="--usernames-as-github-logins"; fi
if istrue "$INPUT_UNRELEASEDONLY"; then ARG_UNRELEASEDONLY="--unreleased-only"; fi
if istrue "$INPUT_UNRELEASED"; then ARG_UNRELEASED="--unreleased"; else ARG_ISSUES="--no-unreleased"; fi
if [ -n "$INPUT_UNRELEASEDLABEL" ]; then ARG_UNRELEASEDLABEL=(--unreleased-label "$INPUT_UNRELEASEDLABEL"); fi
if istrue "$INPUT_COMPARELINK"; then ARG_COMPARELINK="--compare-link"; else ARG_COMPARELINK="--no-compare-link"; fi
if [ -n "$INPUT_INCLUDELABELS" ]; then ARG_INCLUDELABELS="--include-labels $INPUT_INCLUDELABELS"; fi
if [ -n "$INPUT_EXCLUDELABELS" ]; then ARG_EXCLUDELABELS="--exclude-labels $INPUT_EXCLUDELABELS"; fi
if [ -n "$INPUT_ISSUELINELABELS" ]; then ARG_ISSUELINELABELS="--issue-line-labels $INPUT_ISSUELINELABELS"; fi
if [ -n "$INPUT_EXCLUDETAGS" ]; then ARG_EXCLUDETAGS="--exclude-tags $INPUT_EXCLUDETAGS"; fi
if [ -n "$INPUT_EXCLUDETAGSREGEX" ]; then ARG_EXCLUDETAGSREGEX="--exclude-tags-regex $INPUT_EXCLUDETAGSREGEX"; fi
if [ -n "$INPUT_SINCETAG" ]; then ARG_SINCETAG="--since-tag $INPUT_SINCETAG"; fi
if [ -n "$INPUT_DUETAG" ]; then ARG_DUETAG="--due-tag $INPUT_DUETAG"; fi
if [ -n "$INPUT_MAXISSUES" ]; then ARG_MAXISSUES="--max-issues $INPUT_MAXISSUES"; fi
if [ -n "$INPUT_RELEASEURL" ]; then ARG_RELEASEURL="--release-url $INPUT_RELEASEURL"; fi
if [ -n "$INPUT_GITHUBSITE" ]; then ARG_GITHUBSITE="--github-site $INPUT_GITHUBSITE"; fi
if [ -n "$INPUT_GITHUBAPI" ]; then ARG_GITHUBAPI="--github-api $INPUT_GITHUBAPI"; fi
if istrue "$INPUT_SIMPLELIST"; then ARG_SIMPLELIST="--simple-list"; fi
if [ -n "$INPUT_FUTURERELEASE" ]; then ARG_FUTURERELEASE="--future-release $INPUT_FUTURERELEASE"; fi
if [ -n "$INPUT_RELEASEBRANCH" ]; then ARG_RELEASEBRANCH="--release-branch $INPUT_RELEASEBRANCH"; fi
if istrue "$INPUT_HTTPCACHE"; then ARG_HTTPCACHE="--http-cache"; fi
if [ -n "$INPUT_CACHEFILE" ]; then ARG_CACHEFILE="--cache-file $INPUT_CACHEFILE"; fi
if [ -n "$INPUT_CACHELOG" ]; then ARG_CACHELOG="--cache-log $INPUT_CACHELOG"; fi
if [ -n "$INPUT_SSLCAFILE" ]; then ARG_SSLCAFILE="--ssl-ca-file $INPUT_SSLCAFILE"; fi
if istrue "$INPUT_VERBOSE"; then ARG_VERBOSE="--verbose"; else ARG_VERBOSE="--no-verbose"; fi
if [ -n "$INPUT_BREAKINGLABEL" ]; then ARG_BREAKINGLABEL=(--breaking-label "$INPUT_BREAKINGLABEL"); fi
if [ -n "$INPUT_BREAKINGLABELS" ]; then ARG_BREAKINGLABELS="--breaking-labels $INPUT_BREAKINGLABELS"; fi
if [ -n "$INPUT_ENHANCEMENTLABEL" ]; then ARG_ENHANCEMENTLABEL=(--enhancement-label "$INPUT_ENHANCEMENTLABEL"); fi
if [ -n "$INPUT_ENHANCEMENTLABELS" ]; then ARG_ENHANCEMENTLABELS="--enhancement-labels $INPUT_ENHANCEMENTLABELS"; fi
if [ -n "$INPUT_BUGSLABEL" ]; then ARG_BUGSLABEL=(--bugs-label "$INPUT_BUGSLABEL"); fi
if [ -n "$INPUT_BUGLABELS" ]; then ARG_BUGLABELS="--bug-labels $INPUT_BUGLABELS"; fi
if [ -n "$INPUT_DEPRECATEDLABEL" ]; then ARG_DEPRECATEDLABEL=(--deprecated-label "$INPUT_DEPRECATEDLABEL"); fi
if [ -n "$INPUT_DEPRECATEDLABELS" ]; then ARG_DEPRECATEDLABELS="--deprecated-labels $INPUT_DEPRECATEDLABELS"; fi
if [ -n "$INPUT_REMOVEDLABEL" ]; then ARG_REMOVEDLABEL=(--removed-label "$INPUT_REMOVEDLABEL"); fi
if [ -n "$INPUT_REMOVEDLABELS" ]; then ARG_REMOVEDLABELS="--removed-labels $INPUT_REMOVEDLABELS"; fi
if [ -n "$INPUT_SECURITYLABEL" ]; then ARG_SECURITYLABEL=(--security-label "$INPUT_SECURITYLABEL"); fi
if [ -n "$INPUT_SECURITYLABELS" ]; then ARG_SECURITYLABELS="--security-labels $INPUT_SECURITYLABELS"; fi
if [ -n "$INPUT_ISSUESLABEL" ]; then ARG_ISSUESLABEL=(--issues-label "$INPUT_ISSUESLABEL"); fi
if [ -n "$INPUT_PRLABEL" ]; then ARG_PRLABEL=(--pr-label "$INPUT_PRLABEL"); fi

# Generate change log.
# shellcheck disable=SC2086 # We specifically want to allow word splitting.
github_changelog_generator \
  $ARG_USER \
  $ARG_PROJECT \
  $ARG_TOKEN \
  $ARG_DATEFORMAT \
  $ARG_OUTPUT \
  $ARG_BASE \
  "${ARG_HEADERLABEL[@]}" \
  "${ARG_CONFIGURESECTIONS[@]}" \
  "${ARG_ADDSECTIONS[@]}" \
  "${ARG_FRONTMATTER[@]}" \
  $ARG_ISSUES \
  $ARG_ISSUESWOLABELS \
  $ARG_PULLREQUESTS \
  $ARG_PRWOLABELS \
  $ARG_FILTERBYMILESTONE \
  $ARG_AUTHOR \
  $ARG_USERNAMESASGITHUBLOGINS \
  $ARG_UNRELEASEDONLY \
  $ARG_UNRELEASED \
  "${ARG_UNRELEASEDLABEL[@]}" \
  $ARG_COMPARELINK \
  $ARG_INCLUDELABELS \
  $ARG_EXCLUDELABELS \
  $ARG_ISSUELINELABELS \
  $ARG_EXCLUDETAGS \
  $ARG_EXCLUDETAGSREGEX \
  $ARG_SINCETAG \
  $ARG_DUETAG \
  $ARG_MAXISSUES \
  $ARG_RELEASEURL \
  $ARG_GITHUBSITE \
  $ARG_GITHUBAPI \
  $ARG_SIMPLELIST \
  $ARG_FUTURERELEASE \
  $ARG_RELEASEBRANCH \
  $ARG_HTTPCACHE \
  $ARG_CACHEFILE \
  $ARG_CACHELOG \
  $ARG_SSLCAFILE \
  $ARG_VERBOSE \
  "${ARG_BREAKINGLABEL[@]}" \
  $ARG_BREAKINGLABELS \
  "${ARG_ENHANCEMENTLABEL[@]}" \
  $ARG_ENHANCEMENTLABELS \
  "${ARG_BUGSLABEL[@]}" \
  $ARG_BUGLABELS \
  "${ARG_DEPRECATEDLABEL[@]}" \
  $ARG_DEPRECATEDLABELS \
  "${ARG_REMOVEDLABEL[@]}" \
  $ARG_REMOVEDLABELS \
  "${ARG_SECURITYLABEL[@]}" \
  $ARG_SECURITYLABELS \
  "${ARG_ISSUESLABEL[@]}" \
  "${ARG_PRLABEL[@]}"

# Locate change log.
FILE="CHANGELOG.md"
if [ -n "$INPUT_OUTPUT" ]; then FILE="$INPUT_OUTPUT"; fi

# Strip Markdown headers.
if istrue "$INPUT_STRIPHEADERS"; then
  echo "Stripping headers."
  sed -i '/^#/d' "$FILE"
fi

# Strip generator notice.
if istrue "$INPUT_STRIPGENERATORNOTICE"; then
  echo "Stripping generator notice."
  sed -i '/This Changelog was automatically generated/d' "$FILE"
fi

# Save change log to outputs.
if [[ -e "$FILE" ]]; then
  CONTENT=$(cat "$FILE")
  # Escape as per https://github.community/t/set-output-truncates-multiline-strings/16852/3.
  CONTENT="${CONTENT//'%'/'%25'}"
  CONTENT="${CONTENT//$'\n'/'%0A'}"
  CONTENT="${CONTENT//$'\r'/'%0D'}"
  echo ::set-output name=changelog::"$CONTENT"
fi
