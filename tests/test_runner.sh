#!/bin/bash

set -e
set -u

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${YELLOW}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

run_test() {
    local test_name=$1
    local test_script=$2
    
    log_info "Running test: $test_name"
    if bash "$test_script"; then
        log_success "$test_name passed"
        return 0
    else
        log_error "$test_name failed"
        return 1
    fi
}

# Run all test files
FAILED_TESTS=0
for test_file in /home/testuser/tests/test_*.sh; do
    if [ -f "$test_file" ]; then
        if ! run_test "$(basename "$test_file")" "$test_file"; then
            ((FAILED_TESTS++))
        fi
    fi
done

# Summary
if [ $FAILED_TESTS -eq 0 ]; then
    log_success "All tests passed!"
    exit 0
else
    log_error "$FAILED_TESTS test(s) failed"
    exit 1
fi
