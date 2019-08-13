FROM silex/emacs:master-alpine

RUN mkdir -p /root/wcfShells
COPY ./emacs/dotEmacs /root/.emacs
COPY ./emacs /root/wcfShells/emacs
# RUN emacs --batch -f /root/.emacs

ENTRYPOINT tail -f /dev/null

