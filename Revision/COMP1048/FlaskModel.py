# ==========================================
# Flask 考试复习标准模板 (Standard Flask Template)
# ==========================================

from flask import Flask, render_template, request, flash

# 1. 初始化应用 (Initialize App)
app = Flask(__name__)
# 设置密钥，用于 Session 和 Flash 消息 (必须设置，否则报错)
app.secret_key = 'super secret key' 

# ==========================================
# 2. 基础路由 (Basic Route)
# ==========================================
# Task 1: 简单的 Hello World
@app.route("/")
def hello():
    return "Hello World"

# ==========================================
# 3. 动态路由与模板 (Dynamic Route & Templates)
# ==========================================
# Task 3: 带参数的路由，并渲染模板
# <username> 是变量，会传给函数
@app.route("/hello/<username>")
def hello_name(username):
    # render_template 渲染 HTML 文件
    # name=username 把 Python 变量传给 HTML (HTML中使用 {{ name }})
    return render_template('hello.html', name=username)

# ==========================================
# 4. 表单处理 (Form Handling - GET & POST)
# ==========================================
# Task 7: 处理 GET (显示表单) 和 POST (处理提交)
# methods=["GET", "POST"] 必须写，否则默认只有 GET
@app.route("/message/", methods=["GET", "POST"])
def message():
    # 情况 A: 用户刚打开页面 (GET 请求)
    if request.method == "GET":
        return render_template('message.html')
    
    # 情况 B: 用户提交了表单 (POST 请求)
    else:
        # request.form.get('name') 获取 HTML 中 <input name="name"> 的值
        name = request.form.get('name')
        email = request.form.get('email')
        message_text = request.form.get('message') 
        
        # 数据验证 (Validation)
        if name and email and message_text:
            # 成功：渲染页面并回显数据
            return render_template('message.html', name=name, email=email, message=message_text)
        else:
            # 失败：显示错误消息 (需要在 HTML 中用 get_flashed_messages() 显示)
            flash("Please fill out the form completely")
            # 重新显示表单
            return render_template('message.html')

# ==========================================
# 5. 启动应用 (Run App)
# ==========================================
if __name__ == "__main__":
   # debug=True: 修改代码自动重启，页面显示详细错误
   # port=5000: 指定端口
   app.run(debug=True, port=5000)
    