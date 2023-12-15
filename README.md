# esxi-config-backup

Docker image to back up ESXi host configuration.

The idea behind this is to use it in a scheduled manner, since otherwise it provides no real value over the [native backup/restore commands](https://kb.vmware.com/s/article/2042141).

Scheduling a backup with this image could be achieved using something as simple as cron, as exemplified in the [Cron Schedule Example](#cron-schedule-example) section below.

> [!IMPORTANT]  
> The backup files are not encrypted or otherwise secured in any way. It is up to you, the user, to ensure the files are stored securely.

## Run

1. Create a copy of `config.example.yml` called `config.yml` and modify it to your requirements.

2. Start the container
    ```shell
    docker run \
      --rm \
      -v ${PWD}/backups:/app/backups \
      -v ${PWD}/config.yml:/app/config.yml
      ghcr.io/tigattack/esxi-config-backup
    ```

> [!NOTE]  
> The `--rm` flag in the `docker run` command means the container will be removed once the task succeeds. This is fine, since the backup is a one-shot action.

### Cron Schedule Example

The example below assumes that `/opt/esxi-backup` exists, containing a `backups` directory and your `config.yml` (per step 1 in the [Run](#run) section above)

Create a backup once a day at midnight:

`0 0 * * * docker run --rm -v /opt/esxi-backup/backups:/app/backups -v /opt/esxi-backup/config.yml:/app/config.yml ghcr.io/tigattack/esxi-config-backup`
