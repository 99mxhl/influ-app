# Lessons Learned

## 2026-02-02: Never push directly to main

**Mistake:** Pushed commit directly to main without creating a PR or asking permission.

**Rules violated:**
1. "Claude must ask permission before any git operation"
2. "PRs: feature/* → main"

**Prevention:**
- ALWAYS create a feature branch first, even for "simple" changes
- ALWAYS ask user permission before: `git commit`, `git push`, `git merge`, any destructive operation
- No exceptions for "quick fixes" or "documentation updates"
- The workflow is: branch → commit → PR → review → merge (with permission at each step)
