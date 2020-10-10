import Danger 
let danger = Danger()

// Pull out the edited files and find ones that come from a sub-folder
// where our app lives
let editedFiles = danger.git.modifiedFiles + danger.git.createdFiles
let editedAppFiles = editedFiles.filter { $0.contains("/App") }

// Let people bail from the CHANGELOG check
let hasSkipChangelog = danger.github.pullRequest.body?.contains("#no_changelog") ?? false
let hasSkipChangelogLabel = danger.github.issue.labels.first { $0.name == "Skip Changelog" }
let skipCheck = hasSkipChangelog || (hasSkipChangelogLabel != nil)

// Request for a CHANGELOG entry with each app change
if editedAppFiles.count > 0 && !skipCheck {
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

