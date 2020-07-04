workflow "Build libogg" {
  on = "deployment"
  resolves = ["liboggBuildActions"]
}

action "liboggBuildActions" {
  uses = "./"
}
