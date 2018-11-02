FROM ubuntu:16.04

ENV VERSION 7.0.0
#ENV VERSION 6.0.1

# Make sure the image is updated, install some prerequisites,
# Download the latest version of Clang (official binary) for Ubuntu
# Extract the archive and add Clang to the PATH
RUN apt update && apt install -y \
  xz-utils \
  build-essential \
  curl \
  && rm -rf /var/lib/apt/lists/* \
  && curl -SL http://releases.llvm.org/${VERSION}/clang+llvm-${VERSION}-x86_64-linux-gnu-ubuntu-16.04.tar.xz \
  | tar -xvJC . && \
  mv clang+llvm-${VERSION}-x86_64-linux-gnu-ubuntu-16.04 clang_${VERSION} && \
  echo 'export PATH=/clang_'${VERSION}'/bin:$PATH' >> ~/.bashrc && \
  echo 'export LD_LIBRARY_PATH=/clang_${VERSION}/lib:$LD_LIBRARY_PATH' >> ~/.bashrc

# Install Text Editors
RUN apt update && apt install -y vim nano && rm -rf /var/lib/apt/lists/*

# Start from a Bash prompt
CMD [ "/bin/bash" ]
