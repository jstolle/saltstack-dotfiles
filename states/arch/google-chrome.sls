google-chrome:
  cmd.run:
    - name: pacaur -S --noconfirm google-chrome
    - user: {{ grains.user }}