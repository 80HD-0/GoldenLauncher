# GoldenLauncher
An open-source portable (and installable) Minecraft beta launcher.
## Installing
Major updates are usually available in .deb form. if this one is not, install it this way.

Though GoldenLauncher is portable, it can be conveniently installed to the system. It's rather simple.
First, you will need to give the installer proper run permissions: <pre> ```bash chmod +x GoldenLauncherInstaller.sh ``` </pre>
Then simply run the installer. It will install by default to your user application folder () but you can use the -d argument to choose a different directory (use --help or -h to see more)
<pre> ```bash ./GoldenLauncherInstaller.sh ``` </pre>
## Using
If you skipped the installing section, using it portably is trivial:
Just download the "source" and modify permissions: <pre ```bash chmod +x GoldenLauncherInstaller.sh ``` </pre>
Then run the program:<pre> ```bash ./GoldenLauncher.sh ``` </pre>

If you installed it, it's much easier; it adds a symlink so you can just <pre> ```bash goldenlauncher ``` </pre> instead.

It also has some arguments:

-v or --version ) selects (beta) minecraft version. e.g. 1.7.3 for beta 1.7.3
-u or --uninstall ) uninstalls GoldenLauncher
-h or --help ) a help menu. basically it says this.

## Notice
It does install a desktop link, but currently that desktop link can only launch b1.7.3 unless modified. It's reccomended to use the terminal.
