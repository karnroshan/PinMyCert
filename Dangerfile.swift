// Let people bail from the CHANGELOG check
let hasSkipChangelog = danger.github.pullRequest.body?.contains("#no_changelog") ?? false
let hasSkipChangelogLabel = danger.github.issue.labels.first { $0.name == "Skip Changelog" }
let skipCheck = hasSkipChangelog || (hasSkipChangelogLabel != nil)

// Request for a CHANGELOG entry with each app change
if editedFiles.count > 0 && !skipCheck {
  fail("Please add a CHANGELOG entry for these changes. If you would like to skip this check, add `#no_changelog` to the PR body and re-run CI.")
}


let hasJiraID = danger.github.pullRequest.body?.contains("AM") ?? false
if !hasJiraID {
    fail("I couldn't find the Jira ticket ID! Did you forget to add it?")
}

let editedTravisFile = editedFiles.filter { $0.contains(".travis.yml") }
if !editedTravisFile.isEmpty {
    warn("Did you really mean to edit the travis.yml file?")
}

if danger.github.pullRequest.user.login == "dagostini" {
    warn("Not this guy again!")
}

markdown("![Alt iphone](https://s3.ap-southeast-1.amazonaws.com/images.deccanchronicle.com/dc-Cover-3e2ftda9jabdn5q9ffti1emnc3-20170929123140.Medi.jpeg)")

