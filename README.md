# envy

docker-compose wrapper for fish for easy local dev services.

## installation

use a plugin manager or drop `functions/envy.fish` and `completions/envy.fish` into your fish config.

## usage

```console
$ envy init
Creating ~/.config/envy/docker-compose.yml

$ $EDITOR ~/.config/envy/docker-compose.yml

$ envy switch
Switching containers
[+] Running 14/1
 ✔ postgres 13 layers [⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]      0B/0B      Pulled                                                                    12.9s 
[+] Running 2/2
 ✔ Network envy_default       Created                                                                                            0.0s 
 ✔ Container envy-postgres-1  Started                                                                                            1.0s 
```

## but you can just use docker-compose

yes.

```console
$ $EDITOR ~/.config/bigbrain/docker-compose.yml

$ docker-compose -f ~/.config/bigbrain/docker-compose.yml down

$ docker-compose -f ~/.config/bigbrain/docker-compose.yml up -d
[+] Running 14/1
 ✔ postgres 13 layers [⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]      0B/0B      Pulled                                                                    12.9s 
[+] Running 2/2
 ✔ Network envy_default       Created                                                                                            0.0s 
 ✔ Container envy-postgres-1  Started                                                                                            1.0s 
```

envy merely makes the commands shorter and provides shell completions.
