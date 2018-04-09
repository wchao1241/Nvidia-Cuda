#!/bin/sh
set -ex


KERNEL_VERSION=$(uname -r)
echo "aws-ena for ${KERNEL_VERSION}"

STAMP=/lib/modules/${KERNEL_VERSION}/.nvidia-cuda-done

if [ -e $STAMP ]; then
    modprobe ena

    echo "nvidia-cuda for ${KERNEL_VERSION} already installed. Delete $STAMP to reinstall"
    exit 0
fi

ros service enable kernel-headers
ros service up kernel-headers

# NVIDIA-Linux-x86_64-390.48.run
NVIDIA_DRIVER=NVIDIA-Linux-x86_64-${ENA_VERSION}.run
NVIDIA_DRIVER_URL=http://us.download.nvidia.com/XFree86/Linux-x86_64/${ENA_VERSION}/${NVIDIA_DRIVER}

NVIDIA_BUILD_DIR=$(mktemp -d -p .)

echo "Downloading ${NVIDIA_DRIVER_URL} to ${NVIDIA_DRIVER}"
cd ${NVIDIA_BUILD_DIR}
curl -sL ${NVIDIA_DRIVER_URL} -o ${NVIDIA_DRIVER}
echo "Install ${NVIDIA_DRIVER}"
sh ${NVIDIA_DRIVER}

cd /dist
touch $STAMP
echo "nvidia-cuda for ${KERNEL_VERSION} installed. Delete $STAMP to reinstall"

echo "Cleaning ena code"
rm -rf ${NVIDIA_BUILD_DIR}

echo "Cleaning kernel headers"
ros service disable kernel-headers
rm -rf /lib/modules/${KERNEL_VERSION}/build/ && rm -f /lib/modules/${KERNEL_VERSION}/.headers-done
