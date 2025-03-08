init: /opt/homebrew/bin/tflint /opt/homebrew/bin/terraform-docs /opt/homebrew/bin/tfsec

/opt/homebrew/bin/terraform-docs:
	brew install terraform-docs

/opt/homebrew/bin/tflint:
	brew install tflint
	tflint --init

/opt/homebrew/bin/tfsec:
	brew install tfsec

init-module:
	read -p "Enter the module name [new_module]: " module;\
	cp -r templates/new-module ./$$module;\
	printf "# $$module\nThis module sets up...\n\n## Resources Provided\nThis module will:\n\n* item one\n* item two\n\n## Caveats\nExplain caveats here.\n" > ./$$module/README.md

fmt: init
	terraform fmt -recursive

docs: init
	./tools/gen-docs.sh

lint: init
	tflint --recursive

sasl: init
	tfsec

check: lint sasl

install:
	cp tools/pre-commit .git/hooks/pre-commit

.PHONY: clean
clean:
	find . -iname ".terraform" -type d -exec rm -rf {} +;\
	find . -iname "terraform.tfstate" -type f -exec rm -f {} +;\
	find . -iname "terraform.tfstate.backup" -type f -exec rm -f {} +;\