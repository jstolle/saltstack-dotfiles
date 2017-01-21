{% for aur in [
  'gnome-shell-extension-dash-to-dock-git',
  'gnome-shell-extension-topicons-plus-git',
  'gnome-shell-extension-pixel-saver',
  'gnome-shell-extension-caffeine-git',
  'gnome-shell-extension-workspaces-to-dock',
  'gnome-shell-extension-battery-status-git',
  'gnome-shell-extension-dynamic-top-bar',
  'gnome-shell-extension-gravatar',
  'gnome-shell-extension-docker-integration-git',
  'adapta-gtk-theme',
  'adapta-backgrounds',
  'paper-icon-theme-git',
  'capitaine-cursors'
] %}
install-aur-extension-{{ aur }}:
  cmd.run:
    - name: yaourt -S --noconfirm {{ aur }}
    - user: {{ grains.user }}
{% endfor %}

