BITSIZE=4096
FILE=eatabrick.org

all: $(FILE).pem $(FILE).key

$(FILE).pem: $(FILE).csr
	@echo "Copy and paste the following into your CA:"
	@cat $(FILE).csr
	@echo "Paste the certificate from your CA here (^D to finish):"
	@cat >$(FILE).crt

$(FILE).csr: $(FILE).key
	openssl req -new -key $(FILE).key -out $(FILE).csr

$(FILE).key:
	openssl genrsa -des3 -passout pass:x -out $(FILE).pass.key $(BITSIZE)
	openssl rsa -passin pass:x -in $(FILE).pass.key -out $(FILE).key
	rm $(FILE).pass.key

clean:
	rm $(FILE).*
