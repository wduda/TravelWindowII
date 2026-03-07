# Instructions

## workflow

for every new task I provide, go into plan mode, prepare a plan without executing, start a new branch based on main, checkout that branch, commit the plan into an .md file in the `plans` folder, named with the date in ISO 8601 format and an abbreviated description of the feature
if the plan is updated based on my fedback make sure to patch the .md file for the plan as well

## skills

use the skills found in the `.skills` directory

use the `lotro-plugins-development-skill` only for main plugin implementation work
(Lua source, XML UI/layout, plugin runtime behavior)

for repository infrastructure tasks (for example GitHub Actions, CI/CD, docs, release automation, tooling), do not use that skill unless explicitly requested

default rule: if a task does not modify plugin Lua/XML behavior, do not apply `lotro-plugins-development-skill`

## code style

when writing code, do not use ; to end lines as a convention

## changelog data style

when adding lines to changelog and changelogdata, the strings should have a prefix of either major: for major features, feat: for enhancements and minor features, fix: for changes which address behavior that was not as intended

## LOTRO Lua limits

utility classes found in turbine folder can be used but should be considered libraries we cannot change
