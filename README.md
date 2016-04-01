# Fleetctl Docker Image

Use [`fleetctl`](https://github.com/coreos/fleet) inside a Docker container.

## Usage Examples

- Run container with `fleetctl --help` command:

  ```bash
  docker run -it --rm \
             --volume=$HOME/.ssh/id_rsa:/home/fleet/.ssh/id_rsa:ro \
             --volume=$HOME/.fleetctl:/home/fleet/.fleetctl \
             --name=fleet --user=fleet \
             czerasz/fleetctl --help
  ```

  > **NOTE**
  > <br/> Only the `--help` argument needs to be passed.

- Use container with `~/.ssh/digitalocean.com` ssh key:

  ```bash
  docker run -it --rm \
             --volume=$HOME/.ssh/digitalocean.com:/home/fleet/.ssh/id_rsa:ro \
             --volume=$HOME/.fleetctl:/home/fleet/.fleetctl \
             --name=fleet --user=fleet \
             czerasz/fleetctl
  ```

- Run bash shell inside the container to execute multiple commands:

  ```bash
  docker run -it --rm \
             --volume=$HOME/.ssh/id_rsa:/home/fleet/.ssh/id_rsa:ro \
             --volume=$HOME/.fleetctl:/home/fleet/.fleetctl \
             --name=fleet --user=fleet \
             --entrypoint=/bin/bash \
             czerasz/fleetctl
  ```

## Build Image Locally

To build the Docker image locally run the following commands:

- Download Project:

  ```bash
  git clone git@github.com:czerasz/docker-fleetctl && cd docker-fleetctl
  ```

- Build the Docker image:

  ```bash
  ./scripts/build.sh
  ```

You can change the build behavior with environment variables:

```bash
user_id=<id> version=<version> image_name=<name> ./scripts/build.sh
```

Where:

- `user_id`    - id of the user you plan to work with fleetctl
- `version`    - fleetctl version which should be build
- `image_name` - name of the Docker image
