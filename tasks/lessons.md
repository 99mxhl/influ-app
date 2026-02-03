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

## 2026-02-02: Check branch before committing unrelated changes

**Mistake:** Committed mobile UI changes to `fix/backend-lazy-init-categories` branch, which is a backend-specific PR. Mixed unrelated changes into a focused PR.

**Root cause:** Started implementing without checking which branch I was on. Assumed current branch was appropriate.

**Prevention:**
- BEFORE starting any new task, check `git status` to see current branch
- If the current branch name doesn't match the task scope (e.g., backend branch for mobile changes), STOP and ask user:
  - "You're on branch X which is for Y. Should I create a new branch for this task?"
- One PR = one concern. Don't mix unrelated changes.
- Branch naming convention matters: `fix/backend-*` = backend only, `fix/mobile-*` = mobile only

## 2026-02-02: Verify Flutter changes compile before committing

**Mistake:** Used `LucideIcons.handshake` which doesn't exist in the package. Committed and pushed broken code that failed to compile.

**Root cause:** Assumed icon name existed without verifying. Did not run compile check before committing.

**Prevention:**
- BEFORE committing Flutter changes, run `flutter analyze` or `flutter build apk --debug` to verify compilation
- For icon/API usage, verify the member exists (grep in package source or check docs)
- Never assume a symbol exists - always verify
- Quick verification: `flutter analyze <changed_files>` catches most issues

## 2026-02-03: Delete remote branches after PR merge

**Mistake:** Left stale branches on origin after PRs were merged, cluttering the repository.

**Prevention:**
- After a PR is merged, delete the remote branch: `git push origin --delete <branch-name>`
- Or use GitHub's "Delete branch" button after merge
- Also delete local tracking branches: `git branch -d <branch-name>` and `git remote prune origin`
- Periodically clean up with: `git fetch --prune` to remove stale remote-tracking references
