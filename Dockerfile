FROM python:3.12-slim

ARG USERNAME=ansible
ARG USER_UID=123
ARG USER_GID=$USER_UID
ARG BASEDIR=/app

ENV PATH="${BASEDIR}/.local/bin:${PATH}"

ENV ANSIBLE_LOCALHOST_WARNING=False
ENV ANSIBLE_INVENTORY_UNPARSED_WARNING=False

ENV BACKUP_DIRECTORY="${BASEDIR}/backups"
ENV VALIDATE_HOST_CERTS=true

RUN groupadd --gid $USER_GID $USERNAME &&\
    useradd --uid $USER_UID --gid $USER_GID -d ${BASEDIR} $USERNAME && ls -l /home

USER $USERNAME

WORKDIR $BASEDIR

COPY --chown=${USERNAME}:${USERNAME} \
    requirements.txt requirements.yml playbook.yml ./

RUN pip install --no-cache-dir -r requirements.txt &&\
    ansible-galaxy install -r requirements.yml &&\
    mkdir backups

VOLUME ${BACKUP_DIRECTORY}

ENTRYPOINT [ "ansible-playbook", "playbook.yml" ]
