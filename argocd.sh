
#!/bin/bash 



argocd app create myapp --repo https://github.com/vignesh-vicky-tech/repo14.git --path yaml-files --dest-server https://kubernetes.default.svc --dest-namespace default

argocd app myapp

argocd app sync myapp



