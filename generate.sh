# #!/bin/bash

# Rebuilds the website, blog, book, and API documentation from scratch.

gen_site() {
    echo "[1/3] Generating site..."

    cobalt build
    if [ $? -ne 0 ]; then
        echo "[1/3] ERROR: Failed to build website with Cobalt!"
        exit 1
    fi
}

gen_docs() {
    echo "[2/3] Generating documentation..."

    if [ ! -d build ]; then
        echo "[2/3] ERROR: \`build' folder could not be found!"
        exit 1
    fi

    mkdir -p engine
    if [ ! -d engine/master ]; then
        git clone -q https://github.com/amethyst/amethyst --branch master engine/master
    elif [ ! -d engine/develop ]; then
        git clone -q https://github.com/amethyst/amethyst engine/develop
    fi

    cargo doc -q --manifest-path engine/master/Cargo.toml --no-deps -p amethyst -p amethyst_ecs -p amethyst_engine
    if [ $? -ne 0 ]; then
        echo "[2/3] ERROR: Failed to compile and document the \`master' branch!"
        exit 1
    fi

    cargo doc -q --manifest-path engine/develop/Cargo.toml --no-deps -p amethyst -p amethyst_config -p amethyst_context -p amethyst_ecs
    if [ $? -ne 0 ]; then
        echo "[2/3] ERROR: Failed to compile and document the \`develop' branch!"
        exit 1
    fi

    mkdir -p build/doc/
    cp -r engine/master/target/doc/ build/doc/
    cp -r engine/develop/target/doc/ build/doc/develop/
}

gen_book() {
    echo "[3/3] Generating book..."

    if [ ! -d build ]; then
        echo "[3/3] ERROR: \`build' folder could not be found!"
        exit 1
    elif [ ! -d engine ]; then
        echo "[3/3] ERROR: \`engine' folder could not be found!"
        exit 1
    fi

    mdbook build engine/master/book/
    if [ $? -ne 0 ]; then
        echo "[3/3] ERROR: Failed to generate book with mdbook!"
        exit 1
    fi

    cp -r engine/master/book/html/ build/book/
    cp -r engine/master/book/images/ build/book/images/
}

gen_site && gen_docs && gen_book
echo "DONE! Please run \`cobalt serve' and navigate to \`127.0.0.1:3000' to"
echo "      view this site locally."
