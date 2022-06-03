.DEFAULT_GOAL := default

clean:
	@rm ./bin/*

default: install-deps build test

build: install-deps
	@./bin/hey go build -o bin/innsecure ./cmd/innsecure
	@./bin/hey go build -o bin/token ./cmd/token

bin_dir:
	@mkdir -p ./bin

install-deps: install-hey install-goimports install-kind

install-hey: bin_dir
	@curl -L --insecure https://github.com/rossmcf/hey/releases/download/v1.0.0/installer.sh | bash
	@mv hey bin

install-goimports:
	@if [ ! -f ./goimports ]; then \
		cd ~ && go install golang.org/x/tools/cmd/goimports@latest; \
	fi

install-kind:
	@go install sigs.k8s.io/kind@v0.13.0

test:
	@echo "executing tests..."
	go test github.com/form3tech/innsecure

# package for release to candidates (ignore for test exercise)
package-%:
	@echo $*
	@cd ..&& pwd && tar -czvf innsecure-$*.tar.gz --exclude={".git",".github","bin","releases"} innsecure
	@mkdir -p releases
	@mv ../innsecure-$*.tar.gz releases 

get-docker-images:
	@docker build . -t form3/innsecure
	@docker pull postgres:12

start-kind: get-docker-images
	@kind create cluster
	@kind load docker-image form3/innsecure
	@kind load docker-image postgres:12
	@kubectl apply -f ./k8s

stop-kind:
	@kind delete cluster
	@docker image rm form3/innsecure

.PHONY: clean build test package-% get-docker-images start-kind stop-kind
