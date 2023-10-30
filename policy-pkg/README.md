# policy-pkg

## Description
this policy disallow root user container

## Usage

### Fetch the package
`kpt pkg get REPO_URI[.git]/PKG_PATH[@VERSION] policy-pkg`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree policy-pkg`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init policy-pkg
kpt live apply policy-pkg --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/
