#!/bin/bash
IMGNAME=cloud9
IMGVERSION=3.1.2968
docker build -t localreg:5000/$IMGNAME:$IMGVERSION .

