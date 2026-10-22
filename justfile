_default:
    @just --list

# List Actions secrets held by each repository of the account
list-repo-secrets:
    @./scripts/list-repo-secrets.sh | { printf 'REPO\tSECRET\tUPDATED\n'; cat; } | column -t -s "$(printf '\t')" | awk 'NR==1 {print "\033[1m" $0 "\033[0m"; next} {gsub(/[0-9]{4}-[0-9]{2}-[0-9]{2}/, "\033[2m&\033[0m"); print}'

# List public repositories of the account
list-public-repos:
    @gh repo list gitt510 --visibility public
