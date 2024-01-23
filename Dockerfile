FROM barichello/godot-ci

COPY . /game/
WORKDIR /game

CMD godot -v --export "HTML5" .
