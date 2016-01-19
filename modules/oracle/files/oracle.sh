if [ "$USER" = "oracle" ]; then
	if [ -n "$BASH_VERSION" ]; then
	    # include .bashrc if it exists
	    if [ -f "$HOME/.bashrc" ]; then
	        . "$HOME/.bashrc"
	    fi
	fi

	if [ -d "$HOME/bin" ] ; then
	    PATH="$HOME/bin:$PATH"
	fi

	. /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh
fi

