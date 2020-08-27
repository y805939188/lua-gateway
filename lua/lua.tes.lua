test = {
  {ip = "127.0.0.1", port = "3344"},
  {ip = "127.0.0.1", port = "4455"},
  {ip = "127.0.0.1", port = "5566"},
  {ip = "127.0.0.1", port = "6677"},
  {ip = "127.0.0.1", port = "7788"},
  {ip = "127.0.0.1", port = "8899"}
}

local ip_port = test[math.random(1, test)];

print(ip_port)

