#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Parse arguments
DRY_RUN=false
BUMP_TYPE="patch"

for arg in "$@"; do
  case $arg in
    --dry-run|-d)
      DRY_RUN=true
      ;;
    major|minor|patch)
      BUMP_TYPE=$arg
      ;;
    -h|--help)
      echo "Usage: ./release.sh [OPTIONS] [BUMP_TYPE]"
      echo ""
      echo "BUMP_TYPE: major, minor, patch (default: patch)"
      echo ""
      echo "OPTIONS:"
      echo "  --dry-run, -d    Show what would be done without making changes"
      echo "  -h, --help       Show this help message"
      exit 0
      ;;
    *)
      echo -e "${RED}Unknown option: $arg${NC}"
      exit 1
      ;;
  esac
done

if [[ "$DRY_RUN" == true ]]; then
  echo -e "${BLUE}[DRY-RUN MODE]${NC}"
fi

# Get current branch
BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo -e "${YELLOW}Current branch: $BRANCH${NC}"

# Extract version from package.json
CURRENT_VERSION=$(grep '"version"' package.json | head -1 | sed 's/.*"version": "\(.*\)".*/\1/')
echo -e "${YELLOW}Current version: $CURRENT_VERSION${NC}"

# Parse current version
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

# Bump version based on type
case $BUMP_TYPE in
  major)
    MAJOR=$((MAJOR + 1))
    MINOR=0
    PATCH=0
    ;;
  minor)
    MINOR=$((MINOR + 1))
    PATCH=0
    ;;
  patch)
    PATCH=$((PATCH + 1))
    ;;
  *)
    echo -e "${RED}Invalid bump type: $BUMP_TYPE (use: major, minor, patch)${NC}"
    exit 1
    ;;
esac

NEW_VERSION="$MAJOR.$MINOR.$PATCH"
NEW_TAG="v$NEW_VERSION"

echo -e "${YELLOW}New version: $NEW_VERSION${NC}"
echo -e "${YELLOW}New tag: $NEW_TAG${NC}"

# Verify branch name matches version pattern
EXPECTED_BRANCH="release/$MAJOR.$MINOR"
if [[ "$BRANCH" != "$EXPECTED_BRANCH" ]]; then
  echo -e "${RED}Error: Branch name '$BRANCH' does not match expected pattern '$EXPECTED_BRANCH'${NC}"
  exit 1
fi

echo -e "${GREEN}✓ Branch name matches version pattern${NC}"

# Show summary of what will be done
echo ""
echo -e "${YELLOW}=== Release Summary ===${NC}"
echo "Current version: $CURRENT_VERSION"
echo "New version:    $NEW_VERSION"
echo "Tag:            $NEW_TAG"
echo "Branch:         $BRANCH"
echo ""
echo "Actions:"
echo "  1. Fetch from origin"
echo "  2. Merge origin/main"
echo "  3. Update package.json version"
echo "  4. Commit: 'chore: bump version to $NEW_VERSION'"
echo "  5. Push to origin/$BRANCH"
echo "  6. Create tag $NEW_TAG"
echo "  7. Push tag to origin"
echo ""

# Confirm before proceeding
PROMPT="Proceed with release?"
if [[ "$DRY_RUN" == true ]]; then
  PROMPT="$PROMPT (dry-run)?"
else
  PROMPT="$PROMPT (y/n) "
fi

read -p "$PROMPT" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Release cancelled"
  exit 1
fi

# Helper function to execute or show command
execute() {
  if [[ "$DRY_RUN" == true ]]; then
    echo -e "${BLUE}[DRY-RUN]${NC} $@"
  else
    "$@"
  fi
}

# Merge origin/main
echo -e "${YELLOW}Merging origin/main...${NC}"
execute git fetch origin
execute git merge origin/main --no-edit

# Update package.json
echo -e "${YELLOW}Updating package.json...${NC}"
if [[ "$DRY_RUN" == true ]]; then
  echo -e "${BLUE}[DRY-RUN]${NC} sed -i '' \"s/\\\"version\\\": \\\"$CURRENT_VERSION\\\"/\\\"version\\\": \\\"$NEW_VERSION\\\"/\" package.json"
else
  sed -i '' "s/\"version\": \"$CURRENT_VERSION\"/\"version\": \"$NEW_VERSION\"/" package.json
fi

# Commit changes
echo -e "${YELLOW}Committing changes...${NC}"
execute git add package.json
execute git commit -m "chore: bump version to $NEW_VERSION"

# Push to origin
echo -e "${YELLOW}Pushing to origin...${NC}"
execute git push origin $BRANCH

# Create and push tag
echo -e "${YELLOW}Creating tag $NEW_TAG...${NC}"
execute git tag $NEW_TAG

echo -e "${YELLOW}Pushing tag...${NC}"
execute git push origin $NEW_TAG

if [[ "$DRY_RUN" == true ]]; then
  echo -e "${BLUE}[DRY-RUN]${NC} Release simulation completed (no changes made)${NC}"
else
  echo -e "${GREEN}✓ Release $NEW_VERSION completed successfully!${NC}"
  echo -e "${GREEN}Tag: $NEW_TAG${NC}"
fi
