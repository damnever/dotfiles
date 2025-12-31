venv-versioned() {
    python -m venv venv-$(python -V | tr ' ' '-')
}
