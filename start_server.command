#!/bin/bash
cd "$(dirname "$0")"
# 用 Bonjour 注册固定名称，这样用 teach-calendar.local 就能访问
python3 -c "
import http.server, socketserver, sys, threading
class H(http.server.SimpleHTTPRequestHandler):
    def log_message(self, f, *a): pass

# 启动 HTTP 服务器
s = socketserver.TCPServer(('0.0.0.0', 8888), H)
print('✅ 教学日历服务器已启动')
print('📲 iPhone Safari 输入: http://$(ifconfig | grep "inet " | grep -v 127.0.0.1 | grep -v "10\." | awk "{print \$2}"):8888')
print('📲 或使用固定地址: http://teach-calendar.local:8888')
s.serve_forever()
"
