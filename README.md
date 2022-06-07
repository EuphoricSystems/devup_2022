# Swimlane Hub

## Development Setup

### Prerequisites
* Docker for Linux or for Mac
* node.js v16 (install node version manager to be able to switch between them: https://github.com/nvm-sh/nvm)
* npmjs account + access to Swimlane organization on NPM. Then sign in running npm login

### Optional
* commitizen - https://commitizen-tools.github.io/commitizen/#installation

### Package manager
* yarn
* yarn
* yarn
* npm? No, yarn

### Quick Setup
* Clone the repository
* run yarn bootstrap
* run yarn start:all

### Develop URLs
* http://localhost:4200 - UI
* http://localhost:3000/docs - API

## Scripts

* **bootstrap** - Used to install dependencies and setup husky hooks
* **nifo** - Nuke It From Orbit - cleans dist and node_modules and installs dependencies
* **start:dev:services** - starts all the dependent services in docker
* **start:dev:api** - starts the api
* **start:dev:ui** - starts the ui
* **start:all** - starts the ui, api and dependant services concurrently
* **docker:build:api** - builds affected and the api docker container with the tag local/hub/api
* **docker:build:ui** - builds affected and the ui docker container with the tag local/hub/ui
* **docker:test:api** - builds affected and starts the docker containers and services
* **docker:test:ui** - builds affected and starts the docker containers and services
* **docker:test:all** - builds all the apps, docker containers and services


## Git workflow
The following branch name and commit message policies are enforced during committing with scripts run on Git hooks by Husky.

### Branch names
Branch names should have format feature/<ticket ID>_<kebab-case-concise-description>.

e.g. feature/AH-153_precommit-enhancements

# Commit Message Format
Please use conventional commits for structuring commit messages

```
<type>(<scope>): <short summary>
  │       │             │
  │       │             └─⫸ Summary in present tense. Not capitalized. No period at the end.
  │       │
  │       └─⫸ Commit Scope: auth|common|search|platform|connectors|dashboard|shell
  │
  └─⫸ Commit Type: build|ci|docs|feat|fix|perf|refactor|test
```
The `<type>` and `<summary>` fields are mandatory, the `(<scope>)` field is optional.


##### Type

Must be one of the following:

* **build**: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
* **ci**: Changes to our CI configuration files and scripts (examples: CircleCi, SauceLabs)
* **docs**: Documentation only changes
* **feat**: A new feature
* **fix**: A bug fix
* **perf**: A code change that improves performance
* **refactor**: A code change that neither fixes a bug nor adds a feature
* **test**: Adding missing tests or correcting existing tests


##### Scope
The scope should be the name of the npm package affected (as perceived by the person reading the changelog generated from commit messages).

The following is the list of supported scopes:

* `auth`
* `common`
* `search`
* `platform`
* `connectors`
* `dashboard`
* `shell`

##### Summary

Use the summary field to provide a succinct description of the change:

* use the imperative, present tense: "change" not "changed" nor "changes"
* don't capitalize the first letter
* no dot (.) at the end
