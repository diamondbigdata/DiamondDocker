#!/bin/bash
IMGNAME=ambari-node
IMGVERSION=2.2.2.0
docker build -t localreg:5000/$IMGNAME:$IMGVERSION .
