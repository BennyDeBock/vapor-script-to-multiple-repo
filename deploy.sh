#!/bin/bash

declare -a repositories=("https://github.com/vapor/postgres-nio" "https://github.com/vapor/mysql-nio" "https://github.com/vapor/vapor" "https://github.com/vapor/penny-bot" "https://github.com/vapor/template" "https://github.com/vapor/fluent-kit" "https://github.com/vapor/docs" "https://github.com/vapor/toolbox" "https://github.com/vapor/fluent-postgres-driver" "https://github.com/vapor/website" "https://github.com/vapor/jwt-kit" "https://github.com/vapor/redis" "https://github.com/vapor/sql-kit" "https://github.com/vapor/postgres-kit" "https://github.com/vapor/sqlite-nio" "https://github.com/vapor/leaf" "https://github.com/vapor/fluent-mysql-driver" "https://github.com/vapor/mysql-kit" "https://github.com/vapor/fluent" "https://github.com/vapor/websocket-kit" "https://github.com/vapor/email" "https://github.com/vapor/async-kit" "https://github.com/vapor/console-kit" "https://github.com/vapor/leaf-kit" "https://github.com/vapor/sqlite-kit" "https://github.com/vapor/fluent-sqlite-driver" "https://github.com/vapor/routing-kit" "https://github.com/vapor/swift-codecov-action" "https://github.com/vapor/api-docs" "https://github.com/vapor/queues-redis-driver" "https://github.com/vapor/apns" "https://github.com/vapor/multipart-kit" "https://github.com/vapor/queues" "https://github.com/vapor/jwt" "https://github.com/vapor/fluent-mongo-driver" "https://github.com/vapor/release-bot" "https://github.com/vapor/docs-cn" "https://github.com/vapor/blog")

for i in "${repositories[@]}"
do
    # Get name of the repo
    nameRepo=${i:25}

    # Clone the repo
    git clone "$i"
    
    cd "$nameRepo"
    # Make git workflow directory if it doesn't exist
    mkdir -p .github/workflows

    # Copy workflow file into the repo
    cp ../projectboard.yml .github/workflows

    # Commit and push the repo
    git checkout -b enchancement/updateProjectboardWorkflow
    git add .
    git commit -m "Add project board workflow"
    git push --set-upstream origin enchancement/updateProjectboardWorkflow

    gh pr create --title "Update good first issue workflow to work for multiple labels" --body "This pr updates the project board workflow to use the reusable workflow defined in the [Vapor CI repository](https://github.com/vapor/ci)." -r "0xTim"
    # Remove repository after finishing
    cd ..
    sleep 5
    rm -rf "$nameRepo"
done