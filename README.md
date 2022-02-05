# EquiDocker
Docker image for the [EquiDock](https://github.com/octavian-ganea/equidock_public) rigid protein docking system.


## Running Docker

### Build
```sh
docker build -t equidock .
```

### Run
```sh
# with GPUs
docker run --gpus all --name equidock --rm -p 8888:8888 equidock
# with CPU
docker run  --name equidock --rm -p 8888:8888 equidock
```