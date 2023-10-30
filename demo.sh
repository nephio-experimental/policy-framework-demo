#!/bin/bash

color="\033[0;32m" #green Ansi escape code
reset="\033[0m"
bold=$(tput bold)
normal=$(tput sgr0)
echo -e "☀ ☀ ☀ welcome Everyone, [demo on policy framework for Nephio] ☀ ☀ ☀"

read -p ""
echo -e "✎ This is the kpt package which contains the policy"
kpt pkg tree policy-pkg

printf '%.0s\n' {1..3}
read -p "✎ policy details [policy.yaml]"
printf '%.s─' $(seq 1 $(tput cols))
echo -e "${color}"
cat policy-pkg/policy.yaml
echo -e "${reset}"
printf '%.s─' $(seq 1 $(tput cols))

printf '%.0s\n' {1..3}
read -p "✎ prepare kpt pkg and push it to configsync"

echo -e "current packages"

printf '%.s─' $(seq 1 $(tput cols))
echo -e "${color}"
kpt alpha rpkg get
echo -e "${reset}"
printf '%.s─' $(seq 1 $(tput cols))

printf '%.0s\n' {1..3}
read -p "✎ onboard the policy-pkg"
output=$(kpt alpha rpkg init policy --repository=deployments --workspace=v1 -n default)
pkgrev=$(echo "$output" | awk '{print $1}') 
echo "pkg : ${pkgrev}"

kpt alpha rpkg push $pkgrev ./policy-pkg -n default

echo -e "policy is onboard but in ${bold}draft${normal} state"
printf '%.s─' $(seq 1 $(tput cols))
echo -e "${color}"
kpt alpha rpkg get
echo -e "${reset}"
printf '%.s─' $(seq 1 $(tput cols))

printf '%.0s\n' {1..3}
read -p "✎ publish the package and it will be applied to cluster using configsync"
 kpt alpha rpkg propose $pkgrev -n default
 kpt alpha rpkg approve $pkgrev -n default
 sleep 15
printf '%.s─' $(seq 1 $(tput cols))
echo -e "${color}"
kpt alpha rpkg get
echo -e "${reset}"
printf '%.s─' $(seq 1 $(tput cols))

printf '%.0s\n' {1..3}
read -p "✎ now try to create a pod having image tag [kube-session]"
printf '%.s─' $(seq 1 $(tput cols))
echo -e "${color}"
cat sample-yaml/pod.yaml
echo -e "${reset}"
printf '%.s─' $(seq 1 $(tput cols))
sleep 10
echo -e "$ kubectl create -f sample-yaml/pod.yaml"
kubectl apply -f sample-yaml/pod.yaml 
printf '%.s─' $(seq 1 $(tput cols))

printf '%.0s\n' {1..3}
read -p "What if this whole process is moved at the time of packaging (shift left.. ◑)"

kpt pkg get https://github.com/GoogleContainerTools/kpt-functions-catalog.git/examples/gatekeeper-disallow-root-user

kpt pkg tree gatekeeper-disallow-root-user

printf '%.0s\n' {1..3}
echo "[Kptfile]"
printf '%.s─' $(seq 1 $(tput cols))
echo -e "${color}"
cat gatekeeper-disallow-root-user/Kptfile
echo -e "${reset}"
printf '%.s─' $(seq 1 $(tput cols))

printf '%.0s\n' {1..3}
read -p "Run the kpt pipeline to validate the package against policy [$ kpt fn render]"
printf '%.s─' $(seq 1 $(tput cols))
 kpt fn render gatekeeper-disallow-root-user
 printf '%.s─' $(seq 1 $(tput cols))

printf '%.0s\n' {1..8}
 read -p "☀ ☀ ☀ ☀ Thank you ☀ ☀ ☀ ☀"
