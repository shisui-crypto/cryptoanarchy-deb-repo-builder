name = "bitcoin-rpc-proxy-mainnet"
version = "0.1"
bin_package = "bitcoin-rpc-proxy"
binary = "/usr/bin/btc_rpc_proxy"
conf_param = "--conf"
conf_d = { name = "conf.d", param = "--conf-dir" }
user = { name = "bitcoin-mainnet", group = true }
summary = "RPC proxy for Bitcoin"
extra_service_config = """
Restart=always
"""

[config."conf.d/interface.conf"]
format = "toml"
public = true

[config."conf.d/interface.conf".ivars.bind_address]
type = "bind_host"
default = "127.0.0.1"
priority = "low"
summary = "The address used for listening."

[config."conf.d/interface.conf".ivars.bind_port]
type = "bind_port"
default = "8332"
priority = "low"
summary = "The port used for listening."

[config."conf.d/credentials.conf"]
format = "toml"

[config."conf.d/credentials.conf".evars.bitcoin-mainnet.rpcport]
name = "bitcoind_port"

[config."conf.d/credentials.conf".hvars.cookie_file]
type = "string"
constant = "/var/lib/bitcoin-mainnet/cookie"
