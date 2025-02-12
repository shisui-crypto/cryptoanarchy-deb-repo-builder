name = "bitcoin-mainnet"
version = "0.18.1"
bin_package = "bitcoind"
binary = "/usr/bin/bitcoind"
conf_param = "-conf="
user = { group = true, create = { home = true } }
summary = "Bitcoin fully validating node"
extra_service_config = """
# Stopping bitcoind can take a very long time
TimeoutStopSec=300
Restart=always
"""

[config."bitcoin.conf"]
format = "plain"
cat_dir = "conf.d"
cat_files = ["chain_mode"]

[config."bitcoin.conf".ivars.datadir]
type = "path"
file_type = "dir"
create = { mode = 755, owner = "$service", group = "$service" }
default = "/var/lib/bitcoin-mainnet"
priority = { dynamic = { script = "test `df /var | tail -1 | awk '{ print $4; }'` -lt 10000000 && PRIORITY=high || PRIORITY=medium"} }
summary = "Directory containing the timechain data"
long_doc = """
The full path to the directory which will contain timechain data (blocks and chainstate).
Important: you need around 10GB of free space!
"""

[config."bitcoin.conf".ivars.rpcport]
type = "bind_port"
default = "8331"
priority = "low"
summary = "Bitcoin RPC port"

[config."bitcoin.conf".ivars.dbcache]
type = "uint"
default = "450"
priority = "medium"
summary = "Size of database cache in MB"

[config."bitcoin.conf".hvars.rpccookiefile]
type = "string"
constant = "/var/lib/bitcoin-mainnet/cookie"

[config."chain_mode"]
internal = true
content = """
prune=1
txindex=0
"""
