#!/usr/bin/env bash

useradd k8s
usermod -aG sudo k8s

sudo hostnamectl set-hostname worker