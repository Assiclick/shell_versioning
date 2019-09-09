# Assiclick Shell Versioning Scripts

These scripts are made to handle code [versioning](http://semver.org/spec/v2.0.0.html#semantic-versioning-200) and *CHANGELOG.md* updating.

> Note: You need a [Personal Access Token (PAT)](https://github.com/settings/tokens) to use these scripts. Duplicate [github_pat.sh.example](/shell_versioning/github_pat.sh.example), insert your PAT and rename it to *github_pat.sh*

### Scripts

- [Major Release](#major-release)
- [Minor Release](#minor-release)
- [Hotfix](#hotfix)

### Major Release

On `develop` branch:

```shell
./shell_versioning/major-release-create.sh
```

The script suggests the number accordind to current version number. If needed you can change it, otherwise you can proceed.

The script generate a new branch for the major release.

Edit files and push commits to origin.

On `release` branch:


```shell
./shell_versioning/major-release-finish.sh
```

Follow the requests.

At the end, a new version will be created on `master` branch with right tag and `develop` branch will be updated.


### Minor Release

On `develop` branch:

```shell
./shell_versioning/minor-release-create.sh
```

The script suggests the number accordind to current version number. If needed you can change it, otherwise you can proceed.

The script generate a new branch for the major release.

Edit files and push commits to origin.

On `release` branch:


```shell
./shell_versioning/minor-release-finish.sh
```

Follow the requests.

At the end, a new version will be created on `master` branch with right tag and `develop` branch will be updated.


### Hotfix

On `master` branch:

```shell
./shell_versioning/hotfix-create.sh
```

The script suggests the number accordind to current version number. If needed you can change it, otherwise you can proceed.

The script generate a new branch for the major release.

Edit files and push commits to origin.

On `hotfix` branch:


```shell
./shell_versioning/hotfix-finish.sh
```

Follow the requests.

At the end, a new version will be created on `master` branch with right tag and `develop` branch will be updated.

