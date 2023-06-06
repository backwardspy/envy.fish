function envy -d "Manage your local dev services via docker-compose"
    if test -z "$argv"
        echo "No command given. Try `envy switch` or `envy init`."
        return
    end

    _envy $argv
end

function _envy
    function _default
        for v in $argv
            if test "$v" != ""
                echo $v
                return
            end
        end
    end

    set confdir (_default $XDG_CONFIG_HOME ~/.config)/envy
    set datadir (_default $XDG_DATA_HOME ~/.local/share)/envy
    set conf $confdir/docker-compose.yml

    switch $argv
        case init
            _envy_init $conf
        case switch
            _envy_switch $conf
        case down
            _envy_down $conf
        case up
            _envy_up $conf
        case '*'
            echo "Unknown command: $argv[1]"
            return 1
    end
end

function _envy_check_requirements -a conf
    if not command -v docker-compose >/dev/null
        echo "docker-compose is not installed or not executable"
        return 1
    end

    if not test -f $conf
        echo "Compose file not found, try `envy init`"
        return 1
    end
end

function _envy_init -a conf
    if test -f $conf
        echo "Error: Compose file already exists ($conf)" >&2
        return
    end

    echo "Creating $conf"

    mkdir -p (dirname $conf)
    echo "services:
    postgres:
        image: postgres:latest
        ports:
            - '5432:5432'
        environment:
            POSTGRES_HOST_AUTH_METHOD: 'trust'" >$conf
end

function _envy_switch -a conf
    if not _envy_check_requirements $conf
        return
    end

    echo "Switching containers"
    docker-compose --file $conf down
    docker-compose --file $conf up --detach
end

function _envy_down -a conf
    if not _envy_check_requirements $conf
        return
    end

    echo "Stopping containers"
    docker-compose --file $conf down
end

function _envy_up -a conf
    if not _envy_check_requirements $conf
        return
    end

    echo "Starting containers"
    docker-compose --file $conf up --detach
end
