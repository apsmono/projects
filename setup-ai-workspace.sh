#!/bin/bash
# AI Workspace Setup Script
# Run this to set up your AI-powered productivity environment

set -e

echo "🚀 Setting up AI Workspace..."
echo "================================"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 1. Check prerequisites
echo -e "${YELLOW}Checking prerequisites...${NC}"

if ! command -v node &> /dev/null; then
    echo "❌ Node.js not found. Install from https://nodejs.org/"
    exit 1
fi

if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Install from https://docs.docker.com/get-docker/"
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo "❌ Git not found. Install from https://git-scm.com/"
    exit 1
fi

echo -e "${GREEN}✓ Prerequisites met${NC}"

# 2. Install Claude Code (if not present)
echo -e "${YELLOW}Installing Claude Code...${NC}"
if ! command -v claude &> /dev/null; then
    npm install -g @anthropic-ai/claude-code
    echo -e "${GREEN}✓ Claude Code installed${NC}"
else
    echo -e "${GREEN}✓ Claude Code already installed${NC}"
fi

# 3. Install Kimi Code CLI (if not present)
echo -e "${YELLOW}Installing Kimi Code CLI...${NC}"
if ! command -v kimi &> /dev/null; then
    curl -LsSf https://code.kimi.com/install.sh | bash
    echo -e "${GREEN}✓ Kimi Code CLI installed${NC}"
else
    echo -e "${GREEN}✓ Kimi Code CLI already installed${NC}"
fi

# 4. Setup Claude Code global config
echo -e "${YELLOW}Setting up Claude Code configuration...${NC}"
mkdir -p ~/.claude/skills
mkdir -p ~/.claude/hooks
mkdir -p ~/.claude/projects

if [ ! -f ~/.claude/settings.json ]; then
    cp claude-settings-template.json ~/.claude/settings.json
    echo -e "${GREEN}✓ Claude Code settings created${NC}"
else
    echo -e "${YELLOW}⚠ ~/.claude/settings.json already exists. Merge manually if needed.${NC}"
fi

# 5. Copy skills
echo -e "${YELLOW}Copying skills...${NC}"
cp -r skills/* ~/.claude/skills/ 2>/dev/null || true
echo -e "${GREEN}✓ Skills copied${NC}"

# 6. Start n8n
echo -e "${YELLOW}Starting n8n with Docker...${NC}"
docker compose -f docker-compose.n8n.yml up -d
echo -e "${GREEN}✓ n8n started at http://localhost:5678${NC}"

# 7. Summary
echo ""
echo "================================"
echo -e "${GREEN}🎉 Setup Complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Run 'claude' to start Claude Code"
echo "  2. Run 'kimi' to start Kimi Code CLI"
echo "  3. Open http://localhost:5678 for n8n"
echo "  4. Read AI_PRODUCTIVITY_MASTERGUIDE_2026.md for full guide"
echo ""
echo "Recommended: Configure API keys in ~/.claude/settings.json and run /login in each tool"
echo ""
