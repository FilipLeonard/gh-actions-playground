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
    # src_pr=$(gh pr list --search "f72da1b85efafbbe89b95fb3a5cd36400484b36c" --state merged --json 'title,body,url' | jq -r '.[0]')
    src_pr=$(gh pr list --search "f72da1b85efafbbe89b95fb3a5cd36400484b36c" --state merged --json 'title,body,url' --jq '.[0]')
    # echo "${src_pr}"
    

    # src_pr_title=$(gh pr list --search "f72da1b85efafbbe89b95fb3a5cd36400484b36c" --state merged --json 'title' --jq '.[0].title')
    # src_pr_body=$(gh pr list --search "f72da1b85efafbbe89b95fb3a5cd36400484b36c" --state merged --json 'body' --jq '.[0].body')
    # src_pr_url=$(gh pr list --search "f72da1b85efafbbe89b95fb3a5cd36400484b36c" --state merged --json 'url' --jq '.[0].url')
    # printf "Original PR\n%s\n%s\n%s\n" "${src_pr_url}" "${src_pr_title}" "${src_pr_body}"

    src_pr_title=$(printf "%s" "${src_pr}" | jq -r ".title" )
    src_pr_body=$(printf "%s" "${src_pr}" | jq -r ".body" )
    src_pr_url=$(printf "%s" "${src_pr}" | jq -r ".url" )
    # printf "Original PR\n%s\n%s\n%s\n" "${src_pr_url}" "${src_pr_title}" "${src_pr_body}"


    echo "✅"

        "$(cat << EOF
$src_pr_url

$src_pr_title
$src_pr_body
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

echo $(make_body_3)