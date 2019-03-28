workflow "push" {
  on = "push"
  resolves = "do a thing"
}

workflow "pr debug" {
  on = "pull_request"
  resolves = "do a thing"
}

action "do a thing" {
  uses = "docker://stedolan/jq:latest"
  args = [".", "/github/workflow/event.json"]
}
