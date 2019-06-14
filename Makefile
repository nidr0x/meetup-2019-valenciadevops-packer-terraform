include .env
export $(shell sed 's/=.*//' .env)

packer-build:
	cd packer && \
	packer build centos7-nginx-valenciadevops.json && \
	cd -

terraform-init:
	cd terraform && terraform init && cd -

terraform-plan:
	cd terraform && \
	terraform plan && \
	cd -

terraform-apply:
	cd terraform && \
	terraform apply && \
	cd -

terraform-destroy:
	cd terraform && \
	terraform destroy && \
	cd -

