# Homebrew tap for Agent

[Agent](https://github.com/lydakis/agent) is a runtime for many durable,
named AI agents. This tap publishes its macOS desktop app.

Install the latest stable release:

```sh
brew install --cask lydakis/agent/agent
```

Upgrade an existing installation:

```sh
brew update
brew upgrade --cask lydakis/agent/agent
```

The app carries its own copy of the `agent` runtime and starts the daemon
when none is running. The command-line client is not published here.

## Maintainers

The publication integration belongs in the Agent repository. Its Homebrew
workflow runs when a stable GitHub release is published, verifies the
generated `agent.rb` and the app archive's checksum, installs and audits the
cask, then updates `Casks/agent.rb` here.

Set `HOMEBREW_TAP_GITHUB_TOKEN` in Agent's Actions secrets with Contents
write access to this repository.

Tags and draft or prerelease releases do not publish a cask. There is no
scheduled polling. The workflow can be rerun manually for an already published
stable release; it will not downgrade the tap or overwrite a changed
same-version cask.
