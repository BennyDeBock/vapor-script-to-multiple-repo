#!/bin/bash

githubURL="https://github.com/vapor/"
declare -a repositoriesInVapor=("vapor" "fluent" "fluent-kit" "leaf" "leaf-kit" "fluent-postgres-driver" "fluent-mysql-driver" "fluent-sqlite-driver" "fluent-mongo-driver" "postgres-nio" "mysql-nio" "sqlite-nio" "postgres-kit" "mysql-kit" "sqlite-kit" "sql-kit" "apns" "queues" "queues-redis-driver" "redis" "jwt" "jwt-kit" "websocket-kit" "routing-kit" "console-kit" "async-kit" "multipart-kit" "toolbox" "core" "swift-codecov-action" "api-docs")

for i in "${repositoriesInVapor[@]}"
do
    # Clone the repo
    git clone "${githubURL}${i}"
    
    cd "$i"
    # Make git workflow directory if it doesn't exist
    mkdir -p .github/workflows

    # Copy workflow file into the repo
    cp ../release-notes.yml .github/workflows

    # Commit and push the repo
    git checkout -b workflow/automaticReleaseNotes
    git add .
    git commit -m "Add automatic release notes workflow"
    git push --set-upstream origin workflow/automaticReleaseNotes

    gh pr create --title "Add automatic release notes workflow" --body "This pr adds the automatic release notes workflow that uses the reusable workflow defined in the [Vapor CI repository](https://github.com/vapor/ci)." -r "0xTim"
    # Remove repository after finishing
    cd ..
    sleep 5
    rm -rf "$nameRepo"
done