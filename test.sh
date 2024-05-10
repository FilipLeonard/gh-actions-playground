#!/bin/sh


make_body() {
    local title="$1"
    local url="$2"
    "$(cat << EOF

This is an automated pull request created from a build pipeline owned by the upx team.

$title
$url
EOF
)"
}

make_body_2() {
    local message="This is an automated pull request created from a build pipeline owned by the upx team."
    echo "${message}\r\n$1\r\n$2"
}

var="pull_request"

case "${var}" in
    "pull_request")
        title=$(make_body_2 "PR" "https://PR_URL")
        ;;
    "push")
        title=$(make_body_2 "Push" "https://COMMIT_URL")
        ;;
esac

echo "$title" 