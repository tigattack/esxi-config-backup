FROM python:3.12-slim

ARG BASEDIR=/app

ENV BASEDIR=${BASEDIR}
ENV PATH="${BASEDIR}/.local/bin:${PATH}"

ENV ANSIBLE_LOCALHOST_WARNING=False
ENV ANSIBLE_INVENTORY_UNPARSED_WARNING=False

ENV BACKUP_DIRECTORY="${BASEDIR}/backups"
ENV VALIDATE_HOST_CERTS=true

WORKDIR $BASEDIR

COPY requirements.txt requirements.yml playbook.yml ./

RUN pip install --no-cache-dir -r requirements.txt &&\
    ansible-galaxy install -r requirements.yml &&\
    mkdir backups

VOLUME [ "${BACKUP_DIRECTORY}", "${BASEDIR}/backups" ]

ENTRYPOINT [ "ansible-playbook", "playbook.yml" ]
