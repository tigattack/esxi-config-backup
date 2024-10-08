FROM python:3.13-slim

ARG BASEDIR=/app

ENV BASEDIR=${BASEDIR}
ENV PATH="${BASEDIR}/.local/bin:${PATH}"

ENV ANSIBLE_LOCALHOST_WARNING=False
ENV ANSIBLE_INVENTORY_UNPARSED_WARNING=False

WORKDIR $BASEDIR

COPY requirements.txt requirements.yml ./

RUN pip install --no-cache-dir -r requirements.txt &&\
    ansible-galaxy install -r requirements.yml &&\
    mkdir "${BASEDIR}/backups"

COPY playbook.yml ./

ENTRYPOINT [ "ansible-playbook", "playbook.yml" ]
