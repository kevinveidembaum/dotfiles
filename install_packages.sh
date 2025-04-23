#!/bin/bash

set -e

echo "==> Atualizando sistema..."
sudo pacman -Syu --noconfirm

echo "==> Instalando dependências básicas..."
sudo pacman -S --needed --noconfirm git base-devel

echo "==> Instalando yay (se ainda não estiver instalado)..."
if ! command -v yay &>/dev/null; then
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay
  makepkg -si --noconfirm
  cd -
  rm -rf /tmp/yay
fi

echo "==> Instalando pacotes via pacman..."
if [[ -f pkglist.txt ]]; then
  sudo pacman -S --needed --noconfirm $(<pkglist.txt)
else
  echo "Arquivo pkglist.txt não encontrado!"
fi

echo "==> Instalando pacotes AUR via yay..."
if [[ -f aurlist.txt ]]; then
  yay -S --needed --noconfirm $(<aurlist.txt)
else
  echo "Arquivo aurlist.txt não encontrado!"
fi

echo "==> Instalando snapd..."
sudo pacman -S --needed --noconfirm snapd
sudo systemctl enable --now snapd.socket
sudo ln -sf /var/lib/snapd/snap /snap

echo "==> Instalando pacotes Snap..."
if [[ -f snaplist.txt ]]; then
  while read app; do
    echo "Instalando $app..."
    sudo snap install "$app" || echo "Erro ao instalar $app. Pode precisar de --classic"
  done <snaplist.txt
else
  echo "Arquivo snaplist.txt não encontrado!"
fi

echo "✅ Instalação completa!"
