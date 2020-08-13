#!/usr/bin/env bash

shopt -s globstar

rm -rf fixtures
rm *.json
rm *.wasm

mkdir crates
cd crates

git clone https://github.com/khronosproject/wasi-test
cd wasi-test
rev=$(git rev-parse HEAD)

cargo build --target=wasm32-wasi --release
mv fixtures ../../
mv target/wasm32-wasi/release/**/*.json ../../
mv target/wasm32-wasi/release/**/*.wasm ../../

cd ..
rm -rf wasi-test

cd ..

git add fixtures/*
git add *.json
git add *.wasm
git commit -m "Build $rev"
