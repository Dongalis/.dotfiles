.PHONY: deploy check-path chmod install

deploy:
	@echo "Deploying dotfiles package..."
	@stow -t $(HOME) stow-dotfiles --no-folding
	@echo "Deployment complete."

check-path:
	@if ! echo "$(PATH)" | tr ':' '\n' | grep -qx "$(HOME)/.local/bin"; then \
		echo "WARNING: $(HOME)/.local/bin is not in your PATH!"; \
		echo "Add this to your shell config:"; \
		echo "  export PATH=\"$$HOME/.local/bin:$$PATH\""; \
	fi

chmod:
	@chmod +x $(HOME)/.local/bin/dotfiles
	@echo "Dispatcher made executable."

install: check-path deploy chmod
