#!/bin/bash
IMGNAME=ubuntu-vnc-desktop
IMGVERSION=v2.3
docker build -t localreg:5000/$IMGNAME:$IMGVERSION .

