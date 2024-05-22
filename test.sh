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
    # printf "${message}\r\n$1\r\n$2"
    printf "%s\n\n%s\n%s" "${message}" "$1" "$2"
}

make_body_3() {
    src_pr=$(gh pr list --search "16127c1cea" --state merged --json 'title,body,url' --jq '.[0]')
    src_pr_title=$(echo $src_pr | jq -r .title )
    src_pr_body=$(echo $src_pr | jq -r .body )
    src_pr_url=$(echo $src_pr | jq -r .url )
    
    printf "Original PR\n%s\n%s\n%s\n" "${src_pr_url}" "${src_pr_title}" "${src_pr_body}"

        "$(cat << EOF
$src_pr_url

>$src_pr_title
>$src_pr_body
EOF
)"
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

make_body_3