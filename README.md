# versionize container

> :warning: **Work in progress.** I will switch to pr-driven workflow as soon as a stable base was created.

This repository contains a Dockerfile to create a container for the project [Versionize](https://github.com/versionize/versionize). With this container you don't need to install any dotnet version or the tool on your CI tool.

This is useful for CI-Pipelines when your application was builded inside the container.

For more information, please check the project page: [Versionize](https://github.com/versionize/versionize).

# Requirements

- Installed container runtime (examples based in docker, others should also work)
- dotnet repository with at least one project containing a version tag in csproj.

# Usage

Because versionize directly commit the CHANGELOG and .csproj changes, it is required to:
- (A) have the project specific git config with user.name and user.email (just check .git/config file if you see [user] block)
- (B) include your .gitconfig from users home folder (as docker volume)

Depending on your system, it is required to pass your current user id to the container to not change the ownership of files.


## A) General usage (when user is configured in project's git config)
```
docker run -it \
    --user $(id -u):$(id -g) \
    --volume="<myproject-path>:/mount/" \
    sergogmbh/versionize:latest <command-parameters>
```

project related settings can be set with the following commands (do not use --global option):
```
git config user.name "My Name"
git config user.email "my@mail.com"
```


## B) General usage (when using users .gitconfig)
```
docker run -it \
    --user $(id -u):$(id -g) \
    --volume="<myproject-path>:/mount/" \
    --volume="${HOME}/.gitconfig:/root/.gitconfig" \
    sergogmbh/versionize:latest <command-parameters>
```



Example: 
```
docker run -v /Projects/my-dotnet-app:/mount/ -v ~/.gitconfig:/root/.gitconfig sergogmbh/versionize:latest --exit-insignificant-commits --changelog-all
```

# Build

## Build the image

```
docker build . --file Dockerfile --tag sergogmbh/versionize:$(date +%s)
```