getdebs--key:
  cmd.run:
    - name: wget -q -O - http://archive.getdeb.net/getdeb-archive.key | apt-key add -

getdebs-source:
  cmd.run:
    - name: sh -c 'echo "deb http://archive.getdeb.net/ubuntu yakkety-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'

i3-dependencies:
  pkg.installed:
    - pkgs:
      - polybar
      - fonts-font-awesome
      - nitrogen
      - dunst
      - compton
      - volti
      - libtool
      - libxcb1-dev
      - libxcb-keysyms1-dev
      - libpango1.0-dev
      - libxcb-util0-dev
      - libyajl-dev
      - libstartup-notification0-dev
      - libxcb-randr0-dev
      - libev-dev
      - libxcb-cursor-dev
      - libxcb-ewmh-dev
      - libxcb-xinerama0-dev
      - libxcb-xkb-dev
      - libxcb-icccm4-dev
      - libxkbcommon-dev
      - libxkbcommon-x11-dev
      - libxinerama-dev
      - autoconf
      - ruby-ronn
      - libyajl-dev
      - xutils-dev

xcb-util-xrm:
    git.latest:
        - name: https://github.com/Airblader/xcb-util-xrm
        - target: /opt/xcb-util-xrm

xcb-util-xrm-submodule-update:
    cmd.run:
        - name: git submodule update --init
        - cwd: /opt/xcb-util-xrm
        - require:
            - git: xcb-util-xrm

xcb-util-xrm-autogen:
    cmd.run:
        - name: ./autogen.sh --prefix=/usr
        - cwd: /opt/xcb-util-xrm
        - require:
            - cmd: xcb-util-xrm-submodule-update

xcb-util-xrm-make:
    cmd.run:
        - name: make && make install
        - cwd: /opt/xcb-util-xrm
        - require:
            - cmd: xcb-util-xrm-autogen

i3-gaps:
    git.latest:
        - name: https://github.com/Airblader/i3.git
        - target: /opt/i3-gaps
        - force_reset: True
        - require:
            - pkg: i3-dependencies
            - cmd: xcb-util-xrm-make

i3-gaps-make:
    cmd.run:
        - name: make
        - cwd: /opt/i3-gaps
        - require:
            - git: i3-gaps

i3-gaps-make-install:
    cmd.run:
        - name: make install
        - cwd: /opt/i3-gaps
        - require:
            - cmd: i3-gaps-make

rofi:
    git.latest:
        - name: https://github.com/DaveDavenport/rofi.git
        - target: /opt/rofi
        - submodules: True
        - force_reset: True
        - force_fetch: True

rofi-autoreconf:
    cmd.run:
        - name: autoreconf -i
        - cwd: /opt/rofi
        - depends:
            - git: rofi

rofi-build-dir:
    file.directory:
        - name: /opt/rofi/build
        - user: root
        - group: root
        - mode: 755
        - depends:
            - cmd: rofi-autoreconf

rofi-configure:
    cmd.run:
        - name: ../configure
        - cwd: /opt/rofi/build
        - require:
            - file: rofi-build-dir

rofi-make:
    cmd.run:
        - name: make && make install
        - cwd: /opt/rofi/build
        - require:
            - cmd: rofi-configure


vim-install:
  pkg.latest:
    - refresh: True
    - require:
      - pkgrepo: neovim-ppa
    - pkgs:
      - neovim
