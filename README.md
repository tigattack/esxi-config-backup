# esxi-config-backup

Docker image to back up ESXi host configuration.

The idea behind this is to use it in a scheduled manner, since otherwise it provides no real value over the [native backup/restore commands](https://kb.vmware.com/s/article/2042141).

Scheduling a backup with this image could be achieved using something as simple as cron, as exemplified in the [Cron Schedule Example](#cron-schedule-example) section below.

> [!IMPORTANT]  
> The backup files are not encrypted or otherwise secured in any way. It is up to you, the user, to ensure the files are stored securely.

## Run

1. Create a copy of `config.example.yml` called `config.yml` and fill out your host(s) details.

2. Start the container
    ```shell
    docker run \
      --rm \
      -v backups:/app/backups \
      -v ./config.yml:/app/config.yml
      ghcr.io/tigattack/esxi-config-backup
    ```

Note: The `--rm` flag in the `docker run` command means the container will be removed once the task succeeds. This is fine, since the backup is a one-shot action.

### Cron Schedule Example

This example assumes that `/opt/esxi-backup` exists, containing a `backups` directory and your `config.yml` (per step 1 in the [Run](#run) section above)

`0 0 * * * docker run --rm -v /opt/esxi-backup/backups:/app/backups -v /opt/esxi-backup/config.yml:/app/config.yml ghcr.io/tigattack/esxi-config-backup`

## Environment Variables

| Environment Variable  | Default Value  | Info                                    |
|-----------------------|----------------|-----------------------------------------|
| `BACKUP_DIRECTORY`    | `/app/backups` | Supported in Jinja2 mode only.          |
| `VALIDATE_HOST_CERTS` | `true`         | Validate ESXi host(s) SSL certificates. |

**Tip:** Specify in the `docker run` command with `-e <variable>=<value>` , e.g. `docker run -e VALIDATE_HOST_CERTS=false [...]`
