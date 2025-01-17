init:
	cmake -S . -G "Unix Makefiles" -B cmake && ln -s cmake/compile_commands.json .

build:
	cmake -S . -G "Unix Makefiles" -B cmake

rebuild:
	cmake --build ./cmake --target rebuild_cache

clean:
	cmake --build ./cmake --target clean

compile_all:
	cmake --build ./cmake --target all

