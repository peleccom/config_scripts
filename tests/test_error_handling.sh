#!/bin/zsh
emulate -L zsh
setopt err_exit

# Initialize environment
autoload -Uz compinit
compinit

# Create temporary directory for test files
TEST_TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEST_TMP_DIR"' EXIT

# Ensure required directories exist
mkdir -p "$HOME/.ssh" "$TEST_TMP_DIR/local/shell/env.d"
chmod 700 "$HOME/.ssh"

# Add bin to PATH and ensure gitid is available
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/config_scripts/bin:$PATH"
if [[ ! -x "$HOME/bin/gitid" ]]; then
    mkdir -p "$HOME/bin"
    cp "$HOME/config_scripts/core/git/bin/gitid" "$HOME/bin/"
    chmod +x "$HOME/bin/gitid"
fi

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Test counter
TESTS_RUN=0
TESTS_FAILED=0

run_test() {
    local test_name=$1
    local command=$2
    local expected_exit_code=$3

    echo "Running test: $test_name"
    TESTS_RUN=$((TESTS_RUN + 1))

    # Run the command and capture output and exit code
    local output
    local exit_code=0
    output=$(eval "$command" 2>&1) || exit_code=$?
    # If command not found, set exit code to 127
    if [[ $output == *"command not found"* ]]; then
        exit_code=127
    fi

    if [ "$exit_code" -eq "$expected_exit_code" ]; then
        echo -e "${GREEN}✓ Test passed: $test_name${NC}"
    else
        echo -e "${RED}✗ Test failed: $test_name${NC}"
        echo "Expected exit code: $expected_exit_code"
        echo "Actual exit code: $exit_code"
        echo "Output: $output"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
    echo
}

echo "Starting error handling tests..."
echo "================================"

# Test 1: Invalid gitid command
run_test "Invalid gitid command" \
    "gitid invalid-command" \
    2

# Test 2: Switch to non-existent git identity
run_test "Switch to non-existent git identity" \
    "gitid switch non-existent-identity" \
    1

# Test 3: Create git identity without email
run_test "Create git identity without email" \
    "gitid create test-identity" \
    2

# Test 4: Invalid environment file
echo "export INVALID_SYNTAX='missing quote" > "$TEST_TMP_DIR/local/shell/env.d/test.sh"
chmod 644 "$TEST_TMP_DIR/local/shell/env.d/test.sh"
run_test "Invalid environment file" \
    "zsh -c 'source $TEST_TMP_DIR/local/shell/env.d/test.sh'" \
    126

# Test 5: Missing required tool
run_test "Missing required tool" \
    "non-existent-command" \
    127

# Test 6: Permission denied
touch "$TEST_TMP_DIR/local/shell/env.d/readonly.sh"
chmod 000 "$TEST_TMP_DIR/local/shell/env.d/readonly.sh"
run_test "Permission denied" \
    "zsh -c 'source $TEST_TMP_DIR/local/shell/env.d/readonly.sh'" \
    127

# Test 7: Invalid SSH key type
run_test "Invalid SSH key type" \
    "gitid create test test@test.com --key-type invalid" \
    1

echo "Running shell script linting..."
echo "================================"

# Test 8: Shell script linting
# Run shellcheck only on shell scripts
run_test "Shell script linting" \
    "for file in \$(find ./bin -type f ! -name '*.py' ! -name '*.pl' ! -path '*/.git/*' ! -path '*/\.*' ! -path '*/venv/*' ! -path '*/sunrise/*'); do if head -n1 \"\$file\" | grep -q '^#!.*\(ba\|z\)sh'; then shellcheck \"\$file\" || exit 1; fi; done" \
    0

# Print summary
echo "================================"
echo "Tests completed:"
echo "Total tests: $TESTS_RUN"
echo "Failed tests: $TESTS_FAILED"
echo "Passed tests: $((TESTS_RUN - TESTS_FAILED))"

# Exit with failure if any tests failed
[ "$TESTS_FAILED" -eq 0 ] || exit 1