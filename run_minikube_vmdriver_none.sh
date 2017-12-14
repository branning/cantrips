# start minikube using local docker engine, rather than a virtual machine
#
# from https://github.com/kubernetes/minikube#linux-continuous-integration-with-vm-support
# 

export MINIKUBE_WANTUPDATENOTIFICATION=false
export MINIKUBE_WANTREPORTERRORPROMPT=false
export MINIKUBE_HOME=$HOME
export CHANGE_MINIKUBE_NONE_USER=true
mkdir -p $HOME/.kube
[ ! -f $HOME/.kube/config ] && touch $HOME/.kube/config

export KUBECONFIG=$HOME/.kube/config
sudo -E minikube start 
