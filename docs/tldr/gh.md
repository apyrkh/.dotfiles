# gh — GitHub CLI

Interact with GitHub repos without leaving the terminal.

## Setup

```bash
gh auth login        # Authenticate with your GitHub account
gh auth status       # Check auth status
```

## Common tasks

```bash
# List/create issues
gh issue list
gh issue create --title "Fix bug" --body "Description"
gh issue view <number>

# List/create pull requests
gh pr list
gh pr create --draft
gh pr view <number>

# Clone a repo (auto-auth)
gh repo clone owner/repo

# Run workflows / view logs
gh run list
gh run view <run-id> --log

# Check repo stats
gh repo view --web           # Open in browser
gh api repos/{owner}/{repo}  # Raw API call
```

For more: `gh --help`, `gh <command> --help`
