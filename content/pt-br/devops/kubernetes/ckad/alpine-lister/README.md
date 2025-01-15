# Converter imagem para OCI

```
# Criar uma imagem Docker
docker build -t alpine-lister:1.0.0 .

# Exportar a imagem Docker para tar
docker save alpine-lister:1.0.0 -o alpine-lister.tar

# Instalar o skopeo
sudo apt update
sudo apt install -y skopeo

# Converter para OCI usando skopeo
skopeo copy docker-archive:alpine-lister.tar oci:alpine-lister-oci:1.0.0
```

```
docker buildx version
docker buildx create --use
docker buildx inspect --bootstrap
docker buildx build --output type=oci,dest=alpine-lister-oci.tar -t alpine-lister:1.0.0 .
```