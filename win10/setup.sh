#!/bin/bash

self_dir=`dirname $0`
virsh net-start default
virsh define $self_dir/win10.xml

