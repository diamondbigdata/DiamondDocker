#!/bin/bash
IMGNAME=ambari-base
IMGVERSION=2.2.2.0
docker build -t localreg:5000/$IMGNAME:$IMGVERSION .

