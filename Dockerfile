FROM texlive/texlive

RUN apt-get update && apt-get install -y \
    python3 python3-pip \
    python3-venv \
    pandoc \
    && rm -rf /var/lib/apt/lists/*

# Some kind of permissions thing goes wrong if don't use venv
RUN python3 -m venv /env && \
    /env/bin/pip install --no-cache-dir \
    jupyter nbconvert jinja2

ENV PATH="/env/bin:$PATH"

COPY mono_unicode.tex.j2 /env/share/jupyter/nbconvert/templates/mono_unicode/index.tex.j2
COPY conf.json /env/share/jupyter/nbconvert/templates/mono_unicode/conf.json

# Set working directory
WORKDIR /data
