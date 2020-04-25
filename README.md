# Dotfile

**Dotfile hace referencia a esos archivos de configuracion que se utilizan para configurar una herramienta ejemplo: .bashrc, .vimrc, etc**


Este dotfile se apoya de gnu-stow el cual creara enlaces simbolicos en el sistema operativo

instalar gnu-stow

```sudo apt install stow```

Ejemplo de uso en ubuntu

```stow ubuntu```
donde "ubuntu" es la carpeta donde estan los dotfiles

```sh -c "$(wget -O- https://raw.githubusercontent.com/dannywolfmx/dotfiles/master/init.sh)"``


