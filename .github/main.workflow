workflow "run env on push" {
  on = "push"
  resolves = ["🤔"]
}

action "GitHub Action for Docker" {
  uses = "docker://alpine"
  runs = "env"
  secrets = ["TEST_SECRET"]
}

action "docker://alpine" {
  uses = "docker://alpine"
  needs = ["GitHub Action for Docker"]
  runs = "echo \"HELLO THERE TEST\""
}

workflow "run on comment" {
  resolves = ["docker://alpine-1"]
  on = "issue_comment"
}

action "docker://alpine-1" {
  uses = "docker://alpine"
  args = "echo \"Hi\""
}

action "🤔" {
  uses = "docker://alpine"
  needs = ["docker://alpine"]
  args = "echo \"Testing this\""
}

workflow "Does this work? 🤔" {
  on = "push"
  resolves = ["docker://alpine-2"]
}

action "echo something else" {
  uses = "docker://alpine"
  args = "echo \"This better not error out.\""
}

action "docker://alpine-2" {
  uses = "docker://alpine"
  needs = ["echo something else"]
  args = "sleep 20"
}

workflow "Debug Pull Request Event" {
  on = "pull_request"
  resolves = ["show me the payload"]
}

action "show me the payload" {
  uses = "docker://alpine"
  args = "cat  /github/workflow/event.json"
}
