FROM chip-build-test:1.1

# COPY connectedhomeip /opt/connectedhomeip

# WORKDIR /opt/connectedhomeip

# zap工具
# zap-v2023.04.27-nightly
COPY zap-linux.zip /opt/
RUN set -x \
    && cd /opt \
    && unzip zap-linux.zip -d zap-v2023.04.27-nightly \
    # && echo "export ZAP_INSTALL_PATH=/opt/zap-v2023.04.27-nightly" >> ~/.bashrc \
    && : # last line
ENV ZAP_INSTALL_PATH /opt/zap-v2023.04.27-nightly

RUN set -x \
    && cd /opt/connectedhomeip/scripts/py_matter_idl \
    && python setup.py sdist bdist_wheel \
    && pip install dist/matter_idl-0.0.1-py3-none-any.whl \
    && pip3 install --no-cache-dir \
    lark \
    jinja2 \
    stringcase \
    && : # last line

COPY chip_build /opt/chip_build
WORKDIR /opt/chip_build
RUN set -x \
    && gn gen out \
    && ninja -C out \
    && : # last line
