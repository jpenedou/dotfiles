# Dotfiles para ArchLinux con Hyprland

Este repositorio contiene mis dotfiles personalizados que utilizo en mi entorno ArchLinux con Hyprland. Aquí se incluyen configuraciones para diversas herramientas y aplicaciones que utilizo a diario. Uso los temas de TokyoNight en la mayoría de herramientas.

<p align="center">
  <img src="demo.png" alt="demo" width="80%" />
</p>

## Clonación del Repositorio

Para clonar este repositorio correctamente, incluyendo los submódulos y configurándolo como un repositorio bare, sigue los siguientes pasos:

1. Abre una terminal y navega al directorio de inicio:

```bash
cd ~
```

2. Clona el repositorio de forma bare:

```bash
git clone --bare https://github.com/jpenedou/dotfiles.git ~/.dotfiles
```

3. Define el alias `dotfiles` para facilitar la gestión del repositorio:

```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

4. Evita sobrescribir archivos existentes:

```bash
dotfiles checkout
```

Si ves mensajes de error por archivos existentes, mueve esos archivos antes de continuar. Luego, ejecuta de nuevo el comando anterior.

5. Establece el repositorio para no mostrar archivos no rastreados:

```bash
dotfiles config --local status.showUntrackedFiles no
```

6. Actualiza los submódulos:

```bash
dotfiles submodule update --init --recursive
```

---

## Herramientas Utilizadas

* **[Hyprland](https://hyprland.org/)**: Compositor dinámico para Wayland con soporte para tiling y floating windows.
* **[Rofi](https://github.com/lbonn/rofi)**: Lanzador de aplicaciones, menú y selector de ventanas personalizable.
* **[Waybar](https://github.com/Alexays/Waybar)**: Barra de estado y sistema personalizable para Wayland.
* **[Zsh + Oh My Zsh](https://ohmyz.sh/)**: Shell interactivo con mejoras sobre Bash y numerosas extensiones.
* **[Atuin](https://github.com/ellie/atuin)**: Historial de shell avanzado con sincronización y búsqueda mejorada.
* **[Kitty](https://sw.kovidgoyal.net/kitty/)**: Emulador de terminal GPU acelerado, rápido y altamente configurable.
* **[LazyVim](https://lazyvim.org/)**: Configuración avanzada para Neovim que facilita el uso de plugins y personalización.
* **[Yazi](https://github.com/sxyazi/yazi)**: Explorador de archivos rápido y minimalista basado en la línea de comandos.
* **[Lazygit](https://github.com/jesseduffield/lazygit)**: Interfaz de usuario para Git en la terminal, simple y altamente funcional.

---

Para más detalles sobre cada herramienta y configuración específica, revisa los archivos correspondientes en este repositorio.
