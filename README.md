# esxi-config-backup

## Build & Run

```shell
# Clone repo
git clone https://github.com/tigattack/esxi-config-backup.git
cd esxi-config-backup
```

Create a copy of `config.example.yml` called `config.yml` and fill out your host(s) details.

```shell
# Build the Docker image
docker build . -t esxi-config-backup

# Run the container
docker run \
  --rm \
  -v backups:/app/backups \
  -v ./config.yml:/app/config.yml
  esxi-config-backup
```

## Environment Variables

| Environment Variable | Default Value  | Info                                                                                                                                           |
|----------------------|----------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| `BACKUP_DIRECTORY`   | `/app/backups` | Supported in Jinja2 mode only.                                                                                                                 |
| `DEBUG`              | `false`        | Disables `no_log` on the Ansible task. Useful to discover why a backup is failing.<br>Secrets WILL be shown in logs if enabled and a task fails. |
